From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [v5 0/7] add support SATA for BMIPS_GENERIC
Date: Tue, 24 Nov 2015 15:51:22 -0800
Message-ID: <5654F7FA.4060508@gmail.com>
References: <1447900879-1549-1-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34809 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbbKXXw2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Nov 2015 18:52:28 -0500
Received: by padhx2 with SMTP id hx2so37190897pad.1
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2015 15:52:27 -0800 (PST)
In-Reply-To: <1447900879-1549-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

On 18/11/15 18:41, Jaedon Shin wrote:
> Hi all,
> 
> This patch series add support SATA for BMIPS_GENERIC.
> 
> Changes in v5:
> - uses brcm_sata_readreg and brcm_sata_writereg for HOST_CAP_NCQ overriding
> - pull out already applied patches for device tree entries
> - add "Tested-by:" and "Acked-by:" tags

And now also tested on 7435 and 7429 and worked just fine, I plan on
submitting DTSes updates or additions for these chips a little later on.

Jaedon, can you address Brian's and Kishon's feedback so we can get
these patches included in their respective trees?

Thanks again!

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
> - adds quirk for ncq
> - adds quirk for phy interface control
> - remove unused definitions in ahci_brcmstb
> - combines compatible string
> 
> Jaedon Shin (7):
>   ata: ahci_brcmstb: add support MIPS-based platforms
>   ata: ahci_brcmstb: add quirk for broken ncq
>   ata: ahci_brcmstb: add quirk for different phy
>   ata: ahci_brcmstb: remove unused definitions
>   phy: phy_brcmstb_sata: remove duplicate definitions
>   phy: phy_brcmstb_sata: add data for phy version
>   phy: phy_brcmstb_sata: add support MIPS-based platforms
> 
>  .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
>  .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
>  drivers/ata/Kconfig                                |  2 +-
>  drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
>  drivers/phy/Kconfig                                |  4 +-
>  drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
>  6 files changed, 100 insertions(+), 16 deletions(-)
> 
> --
> 2.6.3
> 


-- 
Florian
