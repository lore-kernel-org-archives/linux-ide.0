From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
Date: Tue, 12 May 2015 16:28:18 -0700
Message-ID: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36812 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933877AbbELX3V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2015 19:29:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Kevin Cernekee <cernekee@gmail.com>

Few changes since v2, and the changes are *only* to the SATA driver, not to any
of the DT bindings or the PHY driver. I'm resending the whole series for
completeness.

I'll list the changelog in each patch, but in summary:

v2 -> v3:
 - straighten out endianness for big endian MIPS and ARM in AHCI driver
 - rename sata_brcmstb.c to ahci_brcmstb.c
 - bind ahci_brcmstb.c against the specific string, "brcm,bcm7445-ahci" instead
   of the generic one

Brian

Brian Norris (5):
  Documentation: devicetree: add Broadcom SATA binding
  Documentation: devicetree: add Broadcom SATA PHY binding
  ata: add Broadcom AHCI SATA3 driver for STB chips
  phy: add Broadcom SATA3 PHY driver for Broadcom STB SoCs
  ARM: dts: brcmstb: add nodes for SATA controller and PHY

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  35 +++
 .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  40 +++
 arch/arm/boot/dts/bcm7445.dtsi                     |  37 +++
 drivers/ata/Kconfig                                |   9 +
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_brcmstb.c                         | 322 +++++++++++++++++++++
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-brcmstb-sata.c                     | 216 ++++++++++++++
 9 files changed, 670 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
 create mode 100644 drivers/ata/ahci_brcmstb.c
 create mode 100644 drivers/phy/phy-brcmstb-sata.c

-- 
1.9.1

