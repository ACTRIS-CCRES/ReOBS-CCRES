# cloudnet data downloader for ReOBS

Download all cloudnet products required for ReOBS workflow.
If files are already present, they will not be downloaded again but the script should check if they are complete and download missing files.

## Install

You just need to have `uv` command available.

## Configuration file

The code needs a configuration files in TOML format to define the list of products
and to specify the output directory. An example configuration file is provided in `reobs-ccres_download.toml`.

For the output directory a mask can be provided to create subdirectories for each site. For example, if the output directory is set to `/data/cloudnet/{site}` , then the products for each site will be downloaded in a separate subdirectory and the files can be sorted by dates.

For example:

```toml
output_dir_mask = "/scratchx/ccres/cloudnet/{site}/%Y/%m/%d"
```

- `{site}' is used to create a subdirectory for each site.
- `%Y`, `%m`, `%d` are used to create subdirectories for each year, month and day.


## Usage

```bash
./get_cloudnet_products.py --config reobs-ccres_download.toml \
                           --site <site1> --site <site2> \
                           --date-from <YYYY-MM-DD> --date-to <YYYY-MM-DD>
```
