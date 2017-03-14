From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/2] ata: ahci-dm816: new driver
Date: Tue, 14 Mar 2017 12:04:49 +0100
Message-ID: <1489489491-14195-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Add support for the on-board SATA controller present on TI DM816 SoCs.

This IP suffers from the same issue DA850 does, that is: if we enable
PMP, but connect the drive directly to the board, the disk cannot be
detected. A workaround similar to the one implemented in ahci-da850 is
included in this driver as well.

Tested on DM8168-EVM.

v1 -> v2:
  PATCH 1/2
    - fixed the size of the mapped register region in the example
    - rephrased the clocks property description

Bartosz Golaszewski (2):
  dt-bindings: ata: add DT bindings for ahci-dm816 SATA controller
  ata: ahci: add support for DaVinci DM816 SATA controller

 .../devicetree/bindings/ata/ahci-dm816.txt         |  21 +++
 drivers/ata/Kconfig                                |   9 +
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_dm816.c                           | 200 +++++++++++++++++++++
 4 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt
 create mode 100644 drivers/ata/ahci_dm816.c

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
