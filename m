From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 00/10] add support SATA for BMIPS_GENERIC
Date: Fri, 23 Oct 2015 10:44:13 +0900
Message-ID: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36113 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbJWBpM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2015 21:45:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Hi all,

This patch series adds support SATA for BMIPS_GENERIC.

Ralf,
I request you to drop already submitted patches for NAND device nodes.
It is merge conflicts with this patches.
http://patchwork.linux-mips.org/patch/10577/
http://patchwork.linux-mips.org/patch/10578/
http://patchwork.linux-mips.org/patch/10579/
http://patchwork.linux-mips.org/patch/10580/

Jaedon Shin (10):
  ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
  ata: ahch_brcmstb: add data for port offset
  ata: ahci_brcmstb: add support 40nm platforms
  phy: phy_brcmstb_sata: make the driver buildable on BMIPS_GENERIC
  phy: phy_brcmstb_sata: remove unused definitions
  phy: phy_brcmstb_sata: add data for phy offset
  phy: phy_brcmstb_sata: add support 40nm platforms
  MIPS: BMIPS: brcmstb: add SATA nodes for bcm7346
  MIPS: BMIPS: brcmstb: add SATA nodes for bcm7360
  MIPS: BMIPS: brcmstb: add SATA nodes for bcm7362

 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 40 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 40 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 40 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  8 +++++++
 drivers/ata/Kconfig                       |  2 +-
 drivers/ata/ahci_brcmstb.c                | 34 +++++++++++++++++++-------
 drivers/phy/Kconfig                       |  4 ++--
 drivers/phy/phy-brcmstb-sata.c            | 34 ++++++++++++++++++--------
 10 files changed, 196 insertions(+), 22 deletions(-)

-- 
2.6.2

