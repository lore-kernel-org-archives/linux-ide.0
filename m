From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: enable ATAPI DMA for GEN_IIE chips
Date: Thu, 05 Feb 2009 10:33:51 -0500
Message-ID: <498B06DF.8010501@rtr.ca>
References: <4989D8F9.2060500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:41652 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbZBEPdx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Feb 2009 10:33:53 -0500
In-Reply-To: <4989D8F9.2060500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Enable ATAPI DMA transfers on GEN_IIE chips (6042/7042/SOC).
> This also gets rid of any need for mv_mode_filter().
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/sata_mv.c    2009-02-03 14:58:13.000000000 -0500
> +++ linux/drivers/ata/sata_mv.c    2009-02-04 12:58:52.000000000 -0500
> @@ -345,7 +345,7 @@
>     EDMA_ARB_CFG_OFS    = 0x38,
> 
>     EDMA_HALTCOND_OFS    = 0x60,        /* GenIIe halt conditions */
> -
> +    EDMA_UNKNOWN_RSVD_OFS    = 0x6C,        /* GenIIe unknown/reserved */
..

Scuttle that patch.  I'll re-issue a (v2) version shortly.

-ml
