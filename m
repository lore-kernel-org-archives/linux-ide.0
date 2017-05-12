From: Preetham Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V3 0/3] ADD AHCI support for tegra210
Date: Fri, 12 May 2017 09:45:02 +0000
Message-ID: <b48143948d8b4fb1a0330d9a96e57528@bgmail103.nvidia.com>
References: <1494581650-11115-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1494581650-11115-1-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

+CC linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>-----Original Message-----
>From: Preetham Chandru
>Sent: Friday, May 12, 2017 3:04 PM
>To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>Cc: tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Laxman Dewangan
><ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Venu Byravarasu
><vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Preetham
>Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>Subject: [PATCH V3 0/3] ADD AHCI support for tegra210
>
>From: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
>1. ADD AHCI support for tegra210
>2. Extend the tegra AHCI controller device tree binding with tegra210
>---
>Preetham Chandru R (3):
>  ata: ahci_tegra: Add AHCI support for tegra210
>  dt-bindings: tegra: Add tegra210 AHCI
>  arm64: tegra: Enable SATA on Tegra210
>
> .../bindings/ata/nvidia,tegra124-ahci.txt          |  45 ++-
> arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   6 +
> arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  16 +
> drivers/ata/ahci_tegra.c                           | 377 ++++++++++++++++-----
> 4 files changed, 346 insertions(+), 98 deletions(-)
>
>--
>2.1.4
