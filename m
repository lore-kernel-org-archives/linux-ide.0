From: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V7 0/7] Refactor and add AHCI support for tegra210
Date: Mon, 12 Feb 2018 22:56:39 +0530
Message-ID: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

1. ADD AHCI support for tegra210
2. Extend the tegra AHCI controller device tree binding with tegra210
3. Update initialization sequence
4. Initialize regulators based on chip
5. Disable DevSlp
6. Disable DIPM
---
Preetham Ramchandra (7):
  dt-bindings: ahci-tegra: add binding documentation
  arm64: tegra: Enable AHCI on Jetson TX1
  ata: ahci_tegra: Update initialization sequence
  ata: ahci_tegra: initialize regulators from soc_data
  ata: ahci_tegra: disable devslp for t124
  ata: ahci_tegra: disable DIPM
  ata: ahci_tegra: Add AHCI support for Tegra210

 .../bindings/ata/nvidia,tegra124-ahci.txt          |  35 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   6 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  16 +
 drivers/ata/ahci_tegra.c                           | 362 ++++++++++++++++-----
 4 files changed, 329 insertions(+), 90 deletions(-)

-- 
2.7.4
