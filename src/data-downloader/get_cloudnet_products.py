#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.14"
# dependencies = [
#     "click>=8.4.2",
#     "cloudnet-api-client>=0.12.11",
# ]
# ///
import datetime as dt
import tomllib
import sys
from pathlib import Path

import click
from cloudnet_api_client import APIClient

DATE_FMTS: list[str] = ["%Y-%m-%d", "%Y%m%d"]
SITES: list[str] = [
    site.id for site in APIClient().sites() if site.actris_id is not None
]


@click.command()
@click.option(
    "-s",
    "--site",
    type=click.Choice(SITES, case_sensitive=False),
    multiple=True,
    required=True,
    help="site(s) cloudnet id",
)
@click.option(
    "-c",
    "--config",
    type=click.Path(
        exists=True,
        readable=True,
        file_okay=True,
        dir_okay=False,
        resolve_path=True,
        path_type=Path,
    ),
    help="path to toml config file",
    required=True,
)
@click.option(
    "-d",
    "--date",
    type=click.DateTime(formats=DATE_FMTS),
    default=None,
    help="date in format YYYY-MM-DD to download products. Cannot be used with --date-from and --date-to options.",  # noqa: E501
)
@click.option(
    "-df",
    "--date-from",
    type=click.DateTime(formats=DATE_FMTS),
    default=None,
    help="date in format YYYY-MM-DD to download products. Needs to be used with --date-to option.",  # noqa: E501
)
@click.option(
    "-dt",
    "--date-to",
    type=click.DateTime(formats=DATE_FMTS),
    default=None,
    help="date in format YYYY-MM-DD to download products. Needs to be used with --date-from option.",  # noqa: E501
)
def main(
    site: list[str],
    config: Path,
    date: dt.datetime | None = None,
    date_from: dt.datetime | None = None,
    date_to: dt.datetime | None = None,
) -> None:
    """Download cloudnet products for a given site and date range."""
    # Manage inputs
    # ----------------------------------------------------------------------------------
    # sites
    sites: list[str] = site
    # config
    with config.open("rb") as f:
        conf = tomllib.load(f)
    # dates
    if date_from is None or date_to is None:
        click.echo(
            "Error: --date option cannot be used with --date-from and --date-to options.",  # noqa: E501
            err=True,
        )
        sys.exit(1)
    if date is not None and (date_from is None and date_to is None):
        date_from: dt.datetime = date
        date_to: dt.datetime = date

    date_range = [
        date_from + dt.timedelta(days=i) for i in range((date_to - date_from).days + 1)
    ]

    # download data
    client = APIClient()
    for site in sites:  # noqa: PLR1704
        click.echo(
            f"Downloading cloudnet products for site {site} from {date_from:%Y-%m-%d} to {date_to:%Y-%m-%d}"  # noqa: E501
        )
        n_files = 0
        for d in date_range:
            output_dir = d.strftime(conf["output_dir_mask"].format(site=site))

            files = client.files(
                site_id=site,
                date=d.strftime("%Y-%m-%d"),
                product_id=conf["products"],
            )
            n_files += len(files)
            _ = client.download(files, output_dir)

        click.echo(
            f"Downloaded {n_files} files for site {site} from {date_from:%Y-%m-%d} to {date_to:%Y-%m-%d}"  # noqa: E501
        )


if __name__ == "__main__":
    main()
