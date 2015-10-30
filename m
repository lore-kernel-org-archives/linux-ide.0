From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [v3 00/10] add support SATA for BMIPS_GENERIC
Date: Fri, 30 Oct 2015 22:56:36 +0900
Message-ID: <673D3A37-DE97-4136-BDCE-3DF803405F59@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35582 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031259AbbJ3N4m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 09:56:42 -0400
In-Reply-To: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org

Hi all,

Please discard this patch series. These have fault properties.

Sorry, for the noise.

I will soon send v4 version again.

--
Jaedon

> On Oct 30, 2015, at 10:38 PM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> 
> Hi all,
> 
> This patch series add support SATA for BMIPS_GENERIC.
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
>  ata: ahci_brcmstb: add support MIPS-based platforms
>  ata: ahci_brcmstb: add quirk for broken ncq
>  ata: ahci_brcmstb: add quirk for different phy
>  ata: ahci_brcmstb: remove unused definitions
>  phy: phy_brcmstb_sata: remove duplicate definitions
>  phy: phy_brcmstb_sata: add data for phy version
>  phy: phy_brcmstb_sata: add support MIPS-based platforms
>  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
>  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
>  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362
> 
> .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
> .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
> arch/mips/boot/dts/brcm/bcm7346.dtsi               | 42 ++++++++++++++++
> arch/mips/boot/dts/brcm/bcm7362.dtsi               | 42 ++++++++++++++++
> arch/mips/boot/dts/brcm/bcm7425.dtsi               | 42 ++++++++++++++++
> arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  8 +++
> arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  8 +++
> drivers/ata/Kconfig                                |  2 +-
> drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
> drivers/phy/Kconfig                                |  4 +-
> drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
> 11 files changed, 242 insertions(+), 16 deletions(-)
> 
> -- 
> 2.6.2
> 

