From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [v4 00/10] add support SATA for BMIPS_GENERIC
Date: Fri, 13 Nov 2015 12:27:26 -0800
Message-ID: <564647AE.7070805@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34487 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932293AbbKMU2W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2015 15:28:22 -0500
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org

On 30/10/15 07:01, Jaedon Shin wrote:
> Hi all,
> 
> This patch series add support SATA for BMIPS_GENERIC.

Sorry for the lag.

Tested on 7425b2, there is a small mistake in the interrupt number for
the AHCI controller in the 7425.dtsi file (40 -> 41, see below), after
fixing that, I get both drives (external and internal ports) to be
identified successfully:

# dmesg | grep scsi
<6>[    0.964097] scsi host0: brcm-ahci
<6>[    0.967982] scsi host1: brcm-ahci
<5>[    1.122386] scsi 0:0:0:0: Direct-Access     ATA      WDC
WD2500AAKX-7 1H19 PQ: 0 ANSI: 5
<5>[    1.124512] sd 0:0:0:0: Attached scsi generic sg0 type 0
<5>[    1.411546] scsi 1:0:0:0: Direct-Access     ATA      WDC
WD2500AAKX-7 1H19 PQ: 0 ANSI: 5
<5>[    1.428870] sd 1:0:0:0: Attached scsi generic sg1 type 0
#

And performance looks good:

# hdparm -tT /dev/sda

/dev/sda:
[   48.557068] random: nonblocking pool is initialized
Timing buffer-cache reads:   524 MB in 0.50 seconds = 1052111 kB/s
Timing buffered disk reads:  358 MB in 3.00 seconds = 122132 kB/s
# hdparm -tT /dev/sdb

/dev/sdb:
Timing buffer-cache reads:   528 MB in 0.50 seconds = 1060559 kB/s
Timing buffered disk reads:  374 MB in 3.00 seconds = 127496 kB/s


Tested-by: Florian Fainelli <f.fainelli@gmail.com>

For interrupt numbers, computing them from the HIF_CPU_INTR1 register
works like this this:

HW IRQ# = N * 32 + M

where N ranges from 0->2 and M is the bit within the 32-bits word.

Thanks!

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
> Jaedon Shin (10):
>   ata: ahci_brcmstb: add support MIPS-based platforms
>   ata: ahci_brcmstb: add quirk for broken ncq
>   ata: ahci_brcmstb: add quirk for different phy
>   ata: ahci_brcmstb: remove unused definitions
>   phy: phy_brcmstb_sata: remove duplicate definitions
>   phy: phy_brcmstb_sata: add data for phy version
>   phy: phy_brcmstb_sata: add support MIPS-based platforms
>   MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
>   MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
>   MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362
> 
>  .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
>  .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
>  arch/mips/boot/dts/brcm/bcm7346.dtsi               | 40 +++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7362.dtsi               | 40 +++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7425.dtsi               | 40 +++++++++++++++
>  arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  8 +++
>  arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  8 +++
>  drivers/ata/Kconfig                                |  2 +-
>  drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
>  drivers/phy/Kconfig                                |  4 +-
>  drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
>  11 files changed, 236 insertions(+), 16 deletions(-)
> 


-- 
Florian
