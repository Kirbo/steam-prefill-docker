# Dockerised Steam Prefill

> :warning: 
> This project is deprecated, the official Docker image should be used instead: 
> https://hub.docker.com/r/tpill90/steam-lancache-prefill
>
> The setup guide can be found at: [Setup Guide](https://tpill90.github.io/steam-lancache-prefill/install-guides/Docker-Setup-Guide)

[![](https://dcbadge.vercel.app/api/server/BKnBS4u?style=flat-square)](https://discord.com/invite/lancachenet)


- [GitLab repository](https://gitlab.com/kirbo/steam-prefill-docker)
- [GitLab CI/CD](https://gitlab.com/kirbo/steam-prefill-docker/-/pipelines)
- [Docker hub images](https://hub.docker.com/r/kirbownz/steam-prefill-docker/tags)

## Introduction

This repository is a fork based on Jessica Smiths' (mintopia) repository: [https://github.com/mintopia/steam-prefill-docker](https://github.com/mintopia/steam-prefill-docker).

Dockerfile, docker-compose and helper scripts for running [tpill90](https://github.com/tpill90)'s [steam-lancache-prefill](https://github.com/tpill90/steam-lancache-prefill) within a docker container.

## Usage

Prerequisites

 - Git
 - Docker

Clone this repository and then use either the `SteamPrefill` command or `SteamPrefill.cmd` if you're on Windows.

```bash
git clone https://gitlab.com/kirbownz/steam-prefill-docker.git
cd steam-prefill-docker
./SteamPrefill select-apps
```

For instructions on how to use SteamPrefill please read the [README on the GitHub project](https://github.com/tpill90/steam-lancache-prefill).

Config and cache data are written to bind-mounted volumes.

### Running without Docker-Compose

This is NOT recommended as it's more awkward, but if you *really* want to:

```bash
docker run \
  -v ${PWD}/Cache:/app/Cache \
  -v ${PWD}/Config:/app/Config \
  -it \
  --rm \
  kirbownz/steam-prefill-docker:latest \
  select-apps
```

This will use the latest image from Docker hub.

## Adding as a stack on Portainer

1. Go to "Stacks" page in the menu
2. Click "+ Add stack"
3. Give it a name (e.g. "steam-prefill") and under "Build method" select "Repository" and paste `https://gitlab.com/kirbo/steam-prefill-docker` into "Repository URL"
4. Once you've done your own modifications, at the bottom of the page click "Deploy the stack"
5. Navigate to "Containers" page
6. Click on `steam-lancache-prefill-<name-you-gave-in-step-3>-1` (e.g. `steam-lancache-prefill-steam-prefill-1`)
7. Click "Duplicate/Edit"
8. Scroll at the bottom of the page, next to "Command" click the "Override" button and next to that button fill in `select-apps`
9. Underneath select the Console `Interactive & TTY`
10. Click the "Deploy the container" which is slightly above the Command you just modified
11. You should be automatically redirected to "Containers" page, so open the same container you did in step 6
12. Click the "Console"
13. Click the "Connect"
14. Type in `./SteamPrefill select-apps`
15. Log in into Steam using your Steam account
16. Select the games you want to prefill, using arrow up/down, Space to select the game and once you've selected all you want to prefill, press Enter (program will ask whether you want to prefill now or not, your choise)
17. Click "Disconnect"
18. Navigate back to the same page you did on step 6
19. Click "Duplicate/Edit"
20. Scroll at the bottom of the page, change the "Command" to be `prefill`
21. Underneath select the Console `None`
22. Click the "Deploy the container"
23. Done

### Troubleshooting

For me, the Steam prefill occasionally forgets the Steam credentials, so I need to do the steps 6 - 22 again.

### Schedule the prefill

To make the prefill scheduled:
1. You need to enable and setup Edge Computing (Settings -> Edge Computing -> "Enable Edge Compute features").
2. You will need to set up the Edge Agent.
3. Once those are done, go to Edge Jobs and click "Add Edge job"
4. Give it a name, e.g. "scheduled-steam-prefill" 
5. Select when do you want the prefill to be run, for me I chose "Advanced configuration" and fill in the input `0 0,2,4,6,8,10,12,14,16,18,20,22 * * *` so the Steam prefill will be run at every even hour
6. Under the "Web editor" add the same name you had in the bullets above on step 6, such as:
   ```
   docker start steam-lancache-prefill-steam-prefill-1
   ```
7. Select the Target environment
8. Click "Create edge job"
9. Done

## Support

For support, please visit the [LanCache.Net Discord Server](https://discord.com/invite/lancachenet) in the `#steam-prefill` channel.

## Thanks

This would not exist without the following:

- [Jessica Smith](https://github.com/mintopia)
- [Tim Pilius](https://github.com/tpill90)
- LanCache.Net Team
- UK LAN Techs

## License

The MIT License (MIT)

Copyright (c) 2022 Jessica Smith, Kimmo Saari

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
