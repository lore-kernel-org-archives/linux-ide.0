From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
Date: Thu, 26 Dec 2013 19:01:57 +0100
Message-ID: <20131226180157.GA6919@lunn.ch>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42395 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594Ab3LZSC7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Dec 2013 13:02:59 -0500
Content-Disposition: inline
In-Reply-To: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, stable@vger.kernel.org

On Mon, Dec 23, 2013 at 01:07:35PM +0100, Simon Guinot wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> From: Lior Amsalem <alior@marvell.com>
> 
> This patch fixes a SATA hotplug issue on the Armada 370 and Armada XP
> SoCs. Without it, if a disk is unplugged from a SATA port, then further
> hotplug notification are now longer received on this port.
> 
> This should be applied to every -stable kernel supporting Armada SoCs.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: stable@vger.kernel.org

I tested this on Kirkwood, which does not have any issues to
(re)hotplug. Still works O.K. with this patch.

My only reservation is that neither the Kirkwood nor Dove datasheet
list the LP_PHY_CTL register. Are we now poking something which does
not exist on these SoCs? Is that safe?

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


> ---
>  drivers/ata/sata_mv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 56be318..89ca472 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -304,6 +304,7 @@ enum {
>  	MV5_LTMODE		= 0x30,
>  	MV5_PHY_CTL		= 0x0C,
>  	SATA_IFCFG		= 0x050,
> +	LP_PHY_CTL		= 0x058,
>  
>  	MV_M2_PREAMP_MASK	= 0x7e0,
>  
> @@ -1358,6 +1359,7 @@ static int mv_scr_write(struct ata_link *link, unsigned int sc_reg_in, u32 val)
>  
>  	if (ofs != 0xffffffffU) {
>  		void __iomem *addr = mv_ap_base(link->ap) + ofs;
> +		void __iomem *lp_phy_addr = mv_ap_base(link->ap) + LP_PHY_CTL;
>  		if (sc_reg_in == SCR_CONTROL) {
>  			/*
>  			 * Workaround for 88SX60x1 FEr SATA#26:
> @@ -1374,6 +1376,14 @@ static int mv_scr_write(struct ata_link *link, unsigned int sc_reg_in, u32 val)
>  			 */
>  			if ((val & 0xf) == 1 || (readl(addr) & 0xf) == 1)
>  				val |= 0xf000;
> +
> +			/*
> +			 * Setting PHY speed according to SControl speed
> +			 */
> +			if ((val & 0xf0) == 0x10)
> +				writelfl(0x7, lp_phy_addr);
> +			else
> +				writelfl(0x227, lp_phy_addr);
>  		}
>  		writelfl(val, addr);
>  		return 0;
> -- 
> 1.8.5.1
> 
