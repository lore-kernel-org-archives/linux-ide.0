From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] ata: ahci-dm816: new driver
Date: Mon, 13 Mar 2017 17:36:20 +0100
Message-ID: <1489422982-3461-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Add support for the on-board SATA controller present on TI DM816 SoCs.

This IP suffers from the same issue DA850 does, that is: if we enable
PMP, but connect the drive directly to the board, the disk cannot be
detected. A workaround similar to the one implemented in ahci-da850 is
included in this driver as well.

Bartosz Golaszewski (2):
  dt-bindings: ata: add DT bindings for ahci-dm816 SATA controller
  ata: ahci: add support for DaVinci DM816 SATA controller

 .../devicetree/bindings/ata/ahci-dm816.txt         |  20 +++
 drivers/ata/Kconfig                                |   9 +
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_dm816.c                           | 200 +++++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt
 create mode 100644 drivers/ata/ahci_dm816.c

-- 
2.9.3
