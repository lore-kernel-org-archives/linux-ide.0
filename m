From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 05/10] phy: phy_brcmstb_sata: remove unused definitions
Date: Fri, 23 Oct 2015 13:40:13 -0700
Message-ID: <20151023204013.GO13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-6-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33185 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbbJWUkQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 16:40:16 -0400
Content-Disposition: inline
In-Reply-To: <1445564663-66824-6-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org

On Fri, Oct 23, 2015 at 10:44:18AM +0900, Jaedon Shin wrote:
> Remove unused definitions.

The first one is actually a duplicate (oops!), so is that technically
"unused" or just redundant?

Pedantry aside:

Acked-by: Brian Norris <computersforpeace@gmail.com>

> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/phy/phy-brcmstb-sata.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
> index 8a2cb16a1937..0be55dafe9ea 100644
> --- a/drivers/phy/phy-brcmstb-sata.c
> +++ b/drivers/phy/phy-brcmstb-sata.c
> @@ -26,8 +26,6 @@
>  
>  #define SATA_MDIO_BANK_OFFSET				0x23c
>  #define SATA_MDIO_REG_OFFSET(ofs)			((ofs) * 4)
> -#define SATA_MDIO_REG_SPACE_SIZE			0x1000
> -#define SATA_MDIO_REG_LENGTH				0x1f00
>  
>  #define MAX_PORTS					2
>  
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
