import time
import re
import os
import click
import requests
import json
import logging
import sys


def _get_jwt(username, password):
    url = "https://hub.docker.com/v2/users/login/"
    params = {"username": username, "password": password}

    resp = requests.post(url, json=params)
    if 200 != resp.status_code:
        logging.error("Couldn't authenicate")
        sys.exit(1)

    return resp.json()["token"]


@click.command()
@click.pass_context
@click.option("-r", "--repository", required=True)
@click.option("-t", "--tag", required=True)
@click.option("-p", "--platform", required=False)
def get_digest(ctx, repository, tag, platform=None):
    url = f"https://registry.hub.docker.com/v2/repositories/{ctx.obj['username']}/{repository}/tags/{tag}/"

    headers = {"Authorization": f"JWT {ctx.obj['jwt']}", "Accept": "application/json"}
    resp = requests.get(url, headers=headers)

    if resp.status_code != 200:
        logging.warning("Request failed, perhaps tag is not present")
        sys.exit(0)

    images = resp.json()["images"]
    digest = ""
    if len(images) > 1 and platform == None:
        logging.error(
            "This tag has more than one platform associated to it, please input a platform"
        )
        sys.exit(1)


    for image in images:
        if platform != None:
            if (platform.split("/")[0] == image["os"]) and (
                platform.split("/")[1] == image["architecture"]
            ):
                digest = image["digest"]
        else:
            digest = image["digest"]

    print(digest)


@click.command()
@click.pass_context
@click.option("-r", "--repository", required=True)
@click.option("-t", "--tag", required=True)
def delete_tag(ctx, repository, tag):
    url = f"https://registry.hub.docker.com/v2/repositories/{ctx.obj['username']}/{repository}/tags/{tag}"

    headers = {"Authorization": f"JWT {ctx.obj['jwt']}", "Accept": "application/json"}
    resp = requests.delete(url, headers=headers)

    if resp.status_code != 204:
        logging.error("Request failed, check credentials")
        sys.exit(1)


@click.group()
@click.pass_context
@click.option("-u", "--username", required=False)
@click.option("-p", "--passwd", required=False)
@click.option("-v", "--verbose", is_flag=True, default=False)
def main(ctx, username, passwd, verbose):

    ctx.obj = {
        "username": username,
        "passwd": passwd,
        "jwt": _get_jwt(username, passwd),
    }

    if verbose:
        logging.basicConfig(
            stream=sys.stdout,
            format="%(levelname)s %(asctime)s %(message)s",
            datefmt="%m/%d/%Y %I:%M:%S %p",
        )
        logging.getLogger().setLevel(logging.DEBUG)
    else:
        logging.basicConfig(
            format="%(levelname)s %(asctime)s %(message)s",
            datefmt="%m/%d/%Y %I:%M:%S %p",
        )
        logging.getLogger().setLevel(logging.INFO)


if __name__ == "__main__":
    main.add_command(get_digest)
    main.add_command(delete_tag)
    main()
