import argparse
import os
import pathlib
import shutil
import sys

sys.path.append(str(pathlib.Path(__file__).parent.parent.parent.absolute()))

FINAL_DIR = os.path.abspath("/home/agibek/test_deploy")
DATA_NAME = "data"
JSON_NAME = "json"
FIGURE_NAME = "figure"
QL_NAME = "ql"
SYNTHESIS_NAME = "analysis"
QL_JSON_NAME = "quicklooks.json"
REOBS_JSON_NAME = "reobs_infos.json"
SYNTHESIS_JSON_NAME = "synthesis.json"


class SitePathBuilder:
    def __init__(self, site):
        site = site.lower()
        self.FILE_NAME = f"reobs_{site}_1H_QC.nc"
        self.SYM_DATA_DIR = os.path.join(FINAL_DIR, site, DATA_NAME)
        self.SYM_FILE_NAME = os.path.join(self.SYM_DATA_DIR, self.FILE_NAME)
        self.SYM_JSON_DIR = os.path.join(FINAL_DIR, site, JSON_NAME)
        self.SYM_FIGURE_DIR = os.path.join(FINAL_DIR, site, FIGURE_NAME)
        self.SYM_QL_DIR = os.path.join(self.SYM_FIGURE_DIR, QL_NAME)
        self.SYM_SYNTHESIS_DIR = os.path.join(self.SYM_FIGURE_DIR, SYNTHESIS_NAME)
        self.SYM_QL_JSON = os.path.join(self.SYM_JSON_DIR, QL_JSON_NAME)
        self.SYM_REOBS_JSON = os.path.join(self.SYM_JSON_DIR, REOBS_JSON_NAME)
        self.SYM_SYNTHESIS_JSON = os.path.join(self.SYM_JSON_DIR, SYNTHESIS_JSON_NAME)


def get_parser():
    parser = argparse.ArgumentParser(description="Plot nc files")
    parser.add_argument("--site", required=True, help="Site name")
    parser.add_argument("--folder_version", required=True, help="Folder version")
    parser.add_argument(
        "--file", required=True, help="Name of the folder to symlink from"
    )
    parser.add_argument(
        "--quicklooks_folder",
        required=True,
        help="Name of the folder of quicklooks to symlink from",
    )
    parser.add_argument(
        "--synthesis_folder",
        required=True,
        help="Name of the folder of multi-year-synthesis plots to symlink from",
    )
    parser.add_argument(
        "--quicklooks_json", required=True, help="JSON used for quicklooks"
    )
    parser.add_argument(
        "--synthesis_json", required=True, help="JSON used for synthesis"
    )
    parser.add_argument(
        "--reobs_json", required=True, help="JSON used for variables tabular"
    )

    return parser


class ReOBSDeploymentCopier:
    def __init__(self, site: str, folder_version: str):
        self.site = site
        self.folder_version = folder_version
        self.paths = SitePathBuilder(site)

    def copy_file(self, filepath: str):
        hard_file_path = os.path.join(
            FINAL_DIR,
            self.site,
            self.folder_version,
            DATA_NAME,
            os.path.basename(filepath),
        )
        os.makedirs(os.path.dirname(hard_file_path), exist_ok=True)
        shutil.copyfile(filepath, hard_file_path)

    def copy_ql(self, ql_folder: str):
        hard_ql_dir = os.path.join(
            FINAL_DIR, self.site, self.folder_version, FIGURE_NAME, QL_NAME
        )
        os.makedirs(os.path.dirname(hard_ql_dir), exist_ok=True)
        shutil.copyfile(ql_folder, hard_ql_dir)

    def copy_synthesis(self, synthesis_folder: str):
        hard_synthesis_dir = os.path.join(
            FINAL_DIR, self.site, self.folder_version, FIGURE_NAME, SYNTHESIS_NAME
        )
        os.makedirs(os.path.dirname(hard_synthesis_dir), exist_ok=True)
        shutil.copyfile(synthesis_folder, hard_synthesis_dir)

    def copy_jsons(self, ql_json_path: str, synthesis_json_path: str, reobs_json: str):
        hard_json_dir = os.path.join(
            FINAL_DIR, self.site, self.folder_version, JSON_NAME
        )
        os.makedirs(os.path.dirname(hard_json_dir), exist_ok=True)
        shutil.copyfile(
            ql_json_path,
            os.path.join(
                hard_json_dir,
                QL_JSON_NAME,
            ),
        )

        shutil.copyfile(
            synthesis_json_path,
            os.path.join(
                hard_json_dir,
                SYNTHESIS_JSON_NAME,
            ),
        )

        shutil.copyfile(
            reobs_json,
            os.path.join(
                hard_json_dir,
                REOBS_JSON_NAME,
            ),
        )


class ReOBSDeploymentSymlinker:
    def __init__(self, site: str, folder_version: str):
        self.site = site
        self.folder_version = folder_version
        self.paths = SitePathBuilder(site)

    def symlink_file(self, filepath: str):
        os.makedirs(os.path.dirname(self.paths.SYM_FILE_NAME), exist_ok=True)
        if os.path.exists(self.paths.SYM_FILE_NAME):
            os.remove(self.paths.SYM_FILE_NAME)
        hard_file_path = os.path.join(
            FINAL_DIR,
            self.site,
            self.folder_version,
            DATA_NAME,
            os.path.basename(filepath),
        )
        os.symlink(hard_file_path, self.paths.SYM_FILE_NAME)

    def symlink_jsons(self):
        os.makedirs(os.path.dirname(self.paths.SYM_JSON_DIR), exist_ok=True)
        if os.path.exists(self.paths.SYM_JSON_DIR):
            os.rmdir(self.paths.SYM_JSON_DIR)
        hard_json_dir = os.path.join(
            FINAL_DIR, self.site, self.folder_version, JSON_NAME
        )
        os.symlink(hard_json_dir, self.paths.SYM_JSON_DIR, target_is_directory=True)

    def symlink_ql(self):
        os.makedirs(os.path.dirname(self.paths.SYM_QL_DIR), exist_ok=True)
        if os.path.exists(self.paths.SYM_QL_DIR):
            os.rmdir(self.paths.SYM_QL_DIR)
        hard_json_dir = os.path.join(
            FINAL_DIR, self.site, self.folder_version, FIGURE_NAME, QL_NAME
        )
        os.symlink(hard_json_dir, self.paths.SYM_QL_DIR, target_is_directory=True)

    def symlink_synthesis(self):
        os.makedirs(os.path.dirname(self.paths.SYM_SYNTHESIS_DIR), exist_ok=True)
        if os.path.exists(self.paths.SYM_SYNTHESIS_DIR):
            os.rmdir(self.paths.SYM_SYNTHESIS_DIR)
        hard_json_dir = os.path.join(
            FINAL_DIR, self.site, self.folder_version, FIGURE_NAME, SYNTHESIS_NAME
        )
        os.symlink(
            hard_json_dir, self.paths.SYM_SYNTHESIS_DIR, target_is_directory=True
        )


def main():
    args = get_parser().parse_args()

    copier = ReOBSDeploymentCopier(args.site, args.folder_version)
    copier.copy_file(args.file)
    copier.copy_jsons(args.quicklooks_json, args.synthesis_json, args.reobs_json)
    copier.copy_ql(args.quicklooks_folder)
    copier.copy_synthesis(args.synthesis_folder)

    symlinker = ReOBSDeploymentSymlinker(args.site, args.folder_version)
    symlinker.symlink_file(args.file)
    symlinker.symlink_jsons()
    symlinker.symlink_ql()
    symlinker.symlink_synthesis()


if __name__ == "__main__":
    main()
