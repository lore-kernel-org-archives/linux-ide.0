From: Suneel Garapati <suneel.garapati@xilinx.com>
Subject: [PATCH 0/2] Support for CEVA SATA Host controller
Date: Thu, 21 May 2015 09:27:03 +0530
Message-ID: <1432180625-25159-1-git-send-email-suneel.garapati@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tj@kernel.org, michals@xilinx.com, sorenb@xilinx.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Suneel Garapati <suneel.garapati@xilinx.com>
List-Id: linux-ide@vger.kernel.org

Adds support for CEVA SATA Host controller found on Xilinx Zynq
Ultrascale+ MPSoC.

Suneel Garapati (2):
  devicetree:bindings: add devicetree bindings for ceva ahci
  drivers: ata: add support for Ceva sata host controller

 .../devicetree/bindings/ata/ahci-ceva.txt          |  20 ++
 drivers/ata/Kconfig                                |   9 +
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_ceva.c                            | 225 +++++++++++++++++++++
 4 files changed, 255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt
 create mode 100644 drivers/ata/ahci_ceva.c

--
2.1.2
