From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v5 0/7] add support SATA for BMIPS_GENERIC
Date: Thu, 19 Nov 2015 11:41:12 +0900
Message-ID: <1447900879-1549-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36806 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125AbbKSCmA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2015 21:42:00 -0500
Received: by pacdm15 with SMTP id dm15so64611141pac.3
        for <linux-ide@vger.kernel.org>; Wed, 18 Nov 2015 18:42:00 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>

Hi all,

This patch series add support SATA for BMIPS_GENERIC.

Changes in v5:
- uses brcm_sata_readreg and brcm_sata_writereg for HOST_CAP_NCQ overriding
- pull out already applied patches for device tree entries
- add "Tested-by:" and "Acked-by:" tags

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

Jaedon Shin (7):
  ata: ahci_brcmstb: add support MIPS-based platforms
  ata: ahci_brcmstb: add quirk for broken ncq
  ata: ahci_brcmstb: add quirk for different phy
  ata: ahci_brcmstb: remove unused definitions
  phy: phy_brcmstb_sata: remove duplicate definitions
  phy: phy_brcmstb_sata: add data for phy version
  phy: phy_brcmstb_sata: add support MIPS-based platforms

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
 .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
 drivers/ata/Kconfig                                |  2 +-
 drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
 drivers/phy/Kconfig                                |  4 +-
 drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
 6 files changed, 100 insertions(+), 16 deletions(-)

--
2.6.3
