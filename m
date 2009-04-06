From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/07] sata_mv: cosmetic renames
Date: Mon, 06 Apr 2009 15:51:12 -0400
Message-ID: <49DA5D30.4000704@pobox.com>
References: <49DA2DFD.4010402@rtr.ca> <49DA2E33.4050704@rtr.ca> <49DA2E76.7000800@rtr.ca> <49DA566D.9040501@rtr.ca> <49DA56DE.3000200@rtr.ca> <49DA5709.7060005@rtr.ca> <49DA5733.3050206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56829 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbZDFTvT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 15:51:19 -0400
In-Reply-To: <49DA5733.3050206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> Add _OFS suffix to more of the register offset names,
> for consistency with the rest of the driver.
> 
> Also tag the defines for LTMODE and PHY_MODE4 to note
> that read-after-write is necessary when updating those regs.
> 
> No code changes here.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/sata_mv.c    2009-04-06 14:20:53.000000000 -0400
> +++ new/drivers/ata/sata_mv.c    2009-04-06 15:00:16.000000000 -0400
> @@ -272,17 +272,17 @@
>     SATA_FIS_IRQ_CAUSE_OFS    = 0x364,
>     SATA_FIS_IRQ_AN        = (1 << 9),    /* async notification */
> 
> -    LTMODE_OFS        = 0x30c,
> +    LTMODE_OFS        = 0x30c,    /* requires read-after-write */
>     LTMODE_BIT8        = (1 << 8),    /* unknown, but necessary */
> 
> -    PHY_MODE3        = 0x310,
> -    PHY_MODE4        = 0x314,
> +    PHY_MODE2_OFS        = 0x330,
> +    PHY_MODE3_OFS        = 0x310,
> +    PHY_MODE4_OFS        = 0x314,    /* requires read-after-write */
>     PHY_MODE4_CFG_MASK    = 0x00000003,    /* phy internal config field */
>     PHY_MODE4_CFG_VALUE    = 0x00000001,    /* phy internal config field */
>     PHY_MODE4_RSVD_ZEROS    = 0x5de3fffa,    /* Gen2e always write zeros */
>     PHY_MODE4_RSVD_ONES    = 0x00000005,    /* Gen2e always write ones */

_OFS suffix is redundant, and not often used in other Linux drivers.

	Jeff



