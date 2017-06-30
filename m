From: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V5 0/3] ADD AHCI support for tegra210
Date: Fri, 30 Jun 2017 19:26:30 +0530
Message-ID: <1498830993-24666-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

1. ADD AHCI support for tegra210
2. Extend the tegra AHCI controller device tree binding with tegra210
---
Preetham Chandru R (3):
  ata: ahci_tegra: Add AHCI support for tegra210
  arm64: tegra: Enable AHCI on Tegra210
  dt-bindings: tegra: add binding documentation

 .../bindings/ata/nvidia,tegra124-ahci.txt          |  38 ++-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   6 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  16 +
 drivers/ata/ahci_tegra.c                           | 379 ++++++++++++++++-----
 4 files changed, 343 insertions(+), 96 deletions(-)

-- 
2.1.4
