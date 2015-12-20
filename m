From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [v6 0/7] add support SATA for BMIPS_GENERIC
Date: Sun, 20 Dec 2015 17:31:26 +0530
Message-ID: <56769896.6060908@ti.com>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38729 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932274AbbLTMBl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Dec 2015 07:01:41 -0500
In-Reply-To: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>



On Thursday 26 November 2015 08:26 AM, Jaedon Shin wrote:
> Hi all,
> 
> This patch series add support SATA for BMIPS_GENERIC.
> 
> Changes in v6:
> - change error message for invalid phy version
> - use a flag AHCI_HFLAG_NO_NCQ instead of HOST_CAP_NCQ overriding
> 
> Changes in v5:
> - uses brcm_sata_readreg and brcm_sata_writereg for HOST_CAP_NCQ overriding
> - pull out already applied patches for device tree entries
> - add "Tested-by:" and "Acked-by:" tags
> 
> Changes in v4:
> - remove unused properties from bcm{7425,7342,7362}.dtsi
> 
> Changes in v3:
> - fix typo quirk instead of quick
> - disable NCQ before initialzing SATA controller endianness
> - fix misnomer controlling phy interface
> - remove brcm,broken-ncq and brcm,broken-phy properties from devicetree
> - use compatible string for quirks
> - use list for compatible strings
> - add "Acked-by:" tags
> 
> Changes in v2:
> - add a quirk for disable NCQ
> - add a quirk for skip phy interface control
> - remove unused definitions in ahci_brcmstb
> - combine compatible string
> 
> Jaedon Shin (7):
>   ata: ahci_brcmstb: add support for MIPS-based platforms
>   ata: ahci_brcmstb: disable NCQ for MIPS-based platforms
>   ata: ahci_brcmstb: add a quirk for MIPS-based platforms
>   ata: ahci_brcmstb: remove unused definitions
>   phy: phy_brcmstb_sata: remove duplicate definitions
>   phy: phy_brcmstb_sata: add data for phy version
>   phy: phy_brcmstb_sata: add support for MIPS-based platforms

merged phy susbsystem patches to linux-phy tree.

Thanks
Kishon
> 
>  .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
>  .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
>  drivers/ata/Kconfig                                |  2 +-
>  drivers/ata/ahci_brcmstb.c                         | 23 ++++++++++-
>  drivers/phy/Kconfig                                |  4 +-
>  drivers/phy/phy-brcmstb-sata.c                     | 47 +++++++++++++++++-----
>  6 files changed, 65 insertions(+), 16 deletions(-)
> 
