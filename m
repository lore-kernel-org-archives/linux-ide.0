From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 00/10] add support SATA for BMIPS_GENERIC
Date: Tue, 27 Oct 2015 15:48:01 +0900
Message-ID: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32959 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbbJ0Gse (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2015 02:48:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <robh+dt@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Hi all,

This patch series add support SATA for BMIPS_GENERIC.

Ralf,
I request you to drop already submitted patches for NAND deivce nodes.
They are merge conflict with these.
http://patchwork.linux-mips.org/patch/10577/
http://patchwork.linux-mips.org/patch/10578/
http://patchwork.linux-mips.org/patch/10579/
http://patchwork.linux-mips.org/patch/10580/

Changes in v2:
- Adds quick for ncq
- Adds quick for phy interface control
- Remove unused definitions in ahci_brcmstb
- Combines compatible string

Jaedon Shin (10):
  ata: ahci_brcmstb: add quick for broken ncq
  ata: ahci_brcmstb: add support MIPS-based platforms
  ata: ahci_brcmstb: add quick for broken phy
  ata: ahci_brcmstb: remove unused definitions
  phy: phy_brcmstb_sata: remove duplicate definitions
  phy: phy_brcmstb_sata: add data for phy version
  phy: phy_brcmstb_sata: add support MIPS-based platforms
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  8 +++-
 .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
 arch/mips/boot/dts/brcm/bcm7346.dtsi               | 42 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi               | 42 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi               | 42 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  8 ++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  8 ++++
 drivers/ata/Kconfig                                |  2 +-
 drivers/ata/ahci_brcmstb.c                         | 55 +++++++++++++++++++++-
 drivers/phy/Kconfig                                |  4 +-
 drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
 11 files changed, 242 insertions(+), 17 deletions(-)

-- 
2.6.2

