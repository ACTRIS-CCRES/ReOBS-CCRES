# Problèmes lindenberg

Il y a eu des soucis le 20261005 et le 20261006 pour télécharger les fichiers
  202609. Même chose pour les stations palaiseau et juelich à la même heure
  mais moins d'itérations.

## Soucis

* Il a fallu lancer 6 fois téléchargement\_cloudnet\_1 pour avoir tous les
    fichiers disponibles sur cloudnet à la main.

```bash
$> cat telechargement_cloudnet_1/05/job.err
WARNING:root:Attempt 1 failed for https://cloudnet.fmi.fi/api/download/product/fa6e3c7f-d38b-4bf1-b5ab-4eb6d1b11aaf/20260918_lindenberg_cl61d_695573e5.nc: Response payload is not completed: <ContentLengthError: 400, message='Not enough data to satisfy content length header (received 45743148 of 232415971 bytes).'>
WARNING:root:Attempt 1 failed for https://cloudnet.fmi.fi/api/download/product/2c9ca4bc-0a41-4af8-9ac7-83260cecbf7b/20260919_lindenberg_cl61d_695573e5.nc: Response payload is not completed: <ContentLengthError: 400, message='Not enough data to satisfy content length header (received 145288676 of 232175403 bytes).'>
WARNING:root:Attempt 2 failed for https://cloudnet.fmi.fi/api/download/product/2c9ca4bc-0a41-4af8-9ac7-83260cecbf7b/20260919_lindenberg_cl61d_695573e5.nc: Response payload is not completed: <ContentLengthError: 400, message='Not enough data to satisfy content length header (received 124779526 of 232175403 bytes).'>
WARNING:root:Attempt 3 failed for https://cloudnet.fmi.fi/api/download/product/2c9ca4bc-0a41-4af8-9ac7-83260cecbf7b/20260919_lindenberg_cl61d_695573e5.nc: Response payload is not completed: <ContentLengthError: 400, message='Not enough data to satisfy content length header (received 56163172 of 232175403 bytes).'>
ERROR:root:Giving up on https://cloudnet.fmi.fi/api/download/product/2c9ca4bc-0a41-4af8-9ac7-83260cecbf7b/20260919_lindenberg_cl61d_695573e5.nc after 3 attempts.
Traceback (most recent call last):
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/aiohttp/client_proto.py", line 143, in connection_lost
    uncompleted = self._parser.feed_eof()
  File "aiohttp/_http_parser.pyx", line 594, in aiohttp._http_parser.HttpParser.feed_eof
aiohttp.http_exceptions.ContentLengthError: 400, message:
  Not enough data to satisfy content length header (received 56163172 of 232175403 bytes).

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/home/ccres/flux/ReOBS-CCRES/src/data-downloader/get_cloudnet_products.py", line 122, in <module>
    main()
    ~~~~^^
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/click/core.py", line 1569, in __call__
    return self.main(*args, **kwargs)
           ~~~~~~~~~^^^^^^^^^^^^^^^^^
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/click/core.py", line 1490, in main
    rv = self.invoke(ctx)
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/click/core.py", line 1353, in invoke
    return ctx.invoke(self.callback, **ctx.params)
           ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/click/core.py", line 907, in invoke
    return callback(*args, **kwargs)
  File "/home/ccres/flux/ReOBS-CCRES/src/data-downloader/get_cloudnet_products.py", line 114, in main
    _ = client.download(files, output_dir)
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/cloudnet_api_client/client.py", line 331, in download
    return asyncio.run(
           ~~~~~~~~~~~^
        self.adownload(
        ^^^^^^^^^^^^^^^
    ...<5 lines>...
        )
        ^
    )
    ^
  File "/home/ccres/.local/share/uv/python/cpython-3.14.6-linux-x86_64-gnu/lib/python3.14/asyncio/runners.py", line 205, in run
    return runner.run(main)
           ~~~~~~~~~~^^^^^^
  File "/home/ccres/.local/share/uv/python/cpython-3.14.6-linux-x86_64-gnu/lib/python3.14/asyncio/runners.py", line 128, in run
    return self._loop.run_until_complete(task)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^
  File "/home/ccres/.local/share/uv/python/cpython-3.14.6-linux-x86_64-gnu/lib/python3.14/asyncio/base_events.py", line 719, in run_until_complete
    return future.result()
           ~~~~~~~~~~~~~^^
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/cloudnet_api_client/client.py", line 352, in adownload
    return await download_files(
           ^^^^^^^^^^^^^^^^^^^^^
    ...<6 lines>...
    )
    ^
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/cloudnet_api_client/dl.py", line 94, in download_files
    await asyncio.gather(*tasks)
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/cloudnet_api_client/dl.py", line 119, in _download_file_with_retries
    raise e
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/cloudnet_api_client/dl.py", line 111, in _download_file_with_retries
    await _download_file(params, position)
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/cloudnet_api_client/dl.py", line 149, in _download_file
    async for chunk in response.content.iter_chunked(8192):
    ...<2 lines>...
        params.bar_config.total_amount.update(len(chunk))
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/aiohttp/streams.py", line 46, in __anext__
    rv = await self.read_func()
         ^^^^^^^^^^^^^^^^^^^^^^
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/aiohttp/streams.py", line 448, in read
    await self._wait("read")
  File "/home/ccres/.cache/uv/environments-v2/get-cloudnet-products-5056d3356f451b75/lib/python3.14/site-packages/aiohttp/streams.py", line 365, in _wait
    await waiter
aiohttp.client_exceptions.ClientPayloadError: Response payload is not completed: <ContentLengthError: 400, message='Not enough data to satisfy content length header (received 56163172 of 232175403 bytes).'>
2026-10-06T12:07:59Z CRITICAL - failed/ERR
```

Le programme de téléchargement cloudnet a planté 5 fois et bloque cylc en
  l'état dont 2 fois à 14H local. Je ne sais comment contourner cela.
