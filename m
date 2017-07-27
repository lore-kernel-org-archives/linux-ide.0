From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 0/2] Add support for MediaTek AHCI SATA
Date: Thu, 27 Jul 2017 14:38:05 +0800
Message-ID: <cover.1501134896.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
List-Id: linux-ide@vger.kernel.org

Hi,

This patch series add support for AHCI compatible SATA controller, and it is
compliant with the ahci 1.3 and sata 3.0 specification. This driver is slightly
different than ahci_platform.c (eg. reset control, subsystem setting).

Ryder Lee (2):
  ata: mediatek: add support for MediaTek SATA controller
  dt-bindings: ata: add DT bindings for MediaTek SATA controller

 Documentation/devicetree/bindings/ata/ahci-mtk.txt |  48 +++++
 drivers/ata/Kconfig                                |  10 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_mtk.c                             | 196 +++++++++++++++++++++
 4 files changed, 255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
 create mode 100644 drivers/ata/ahci_mtk.c

-- 
1.9.1
