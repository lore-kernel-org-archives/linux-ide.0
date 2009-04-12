From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: increate the IORDY timeout for the soc controllers
Date: Sun, 12 Apr 2009 10:37:48 -0400
Message-ID: <49E1FCBC.5010101@rtr.ca>
References: <20090411160815.GA10995@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43805 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662AbZDLOhu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Apr 2009 10:37:50 -0400
In-Reply-To: <20090411160815.GA10995@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org

Martin Michlmayr wrote:
> From: Saeed Bishara <saeed@marvell.com>
> 
> The old value (in clock cycles) is not suitable for soc devices that
> have internal clock more that 150MHz.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 5315b5f..f19f2e3 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -3330,7 +3330,7 @@ static void mv_soc_reset_hc_port(struct mv_host_priv *hpriv,
>  	ZERO(0x024);		/* respq outp */
>  	ZERO(0x020);		/* respq inp */
>  	ZERO(0x02c);		/* test control */
> -	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
> +	writel(0x800, port_mmio + EDMA_IORDY_TMOUT);
>  }
>  
>  #undef ZERO
..

I want to see somebody actually test/verify that
this works with PIO/MWDMA2 devices (eg. CF cards) first.

Test results?
