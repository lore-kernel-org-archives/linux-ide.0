From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 04/10] phy: phy_brcmstb_sata: make the driver buildable on
 BMIPS_GENERIC
Date: Fri, 23 Oct 2015 20:17:07 +0530
Message-ID: <562A486B.5020500@ti.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33753 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbbJWOrR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Oct 2015 10:47:17 -0400
In-Reply-To: <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Tejun Heo <tj@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org

+Brian Norris

Hi,

On Friday 23 October 2015 07:14 AM, Jaedon Shin wrote:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3 PHY.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/phy/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 47da573d0bab..c83e48661fd7 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -364,11 +364,11 @@ config PHY_TUSB1210
>  
>  config PHY_BRCMSTB_SATA
>  	tristate "Broadcom STB SATA PHY driver"
> -	depends on ARCH_BRCMSTB
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC

Nice to see the same driver is been used across multiple platforms.
Cc'ed Brian who is the author of brcmstb-sata.c

Thanks
Kishon
>  	depends on OF
>  	select GENERIC_PHY
>  	help
> -	  Enable this to support the SATA3 PHY on 28nm Broadcom STB SoCs.
> +	  Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB SoCs.
>  	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
>  
>  endmenu
> 
