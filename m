From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 00/10] add support SATA for BMIPS_GENERIC
Date: Fri, 30 Oct 2015 23:01:14 +0900
Message-ID: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34714 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031336AbbJ3OBf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 10:01:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Hi all,

This patch series add support SATA for BMIPS_GENERIC.

Changes in v4:
- remove unused properties from bcm{7425,7342,7362}.dtsi

Changes in v3:
- fix typo quirk instead of quick
- disable NCQ before initialzing SATA controller endianness
- fix misnomer controlling phy interface
- remove brcm,broken-ncq and brcm,broken-phy properties from devicetree
- use compatible string for quirks
- use list for compatible strings
- add "Acked-by:" tags

Changes in v2:
- adds quirk for ncq
- adds quirk for phy interface control
- remove unused definitions in ahci_brcmstb
- combines compatible string

Jaedon Shin (10):
  ata: ahci_brcmstb: add support MIPS-based platforms
  ata: ahci_brcmstb: add quirk for broken ncq
  ata: ahci_brcmstb: add quirk for different phy
  ata: ahci_brcmstb: remove unused definitions
  phy: phy_brcmstb_sata: remove duplicate definitions
  phy: phy_brcmstb_sata: add data for phy version
  phy: phy_brcmstb_sata: add support MIPS-based platforms
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
 .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
 arch/mips/boot/dts/brcm/bcm7346.dtsi               | 40 +++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi               | 40 +++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi               | 40 +++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  8 +++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  8 +++
 drivers/ata/Kconfig                                |  2 +-
 drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
 drivers/phy/Kconfig                                |  4 +-
 drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
 11 files changed, 236 insertions(+), 16 deletions(-)

-- 
2.6.2

