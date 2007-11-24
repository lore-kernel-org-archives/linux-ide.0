From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: reorganize controller IDs
Date: Fri, 23 Nov 2007 20:21:25 -0500
Message-ID: <47477C95.8050706@garzik.org>
References: <20071119041459.GA30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38286 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbXKXBV1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:21:27 -0500
In-Reply-To: <20071119041459.GA30919@htj.mynetwork.cxm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Move piix_pata_mwdma to top, rename ich9_2port_sata to ich8_2port_sata
> for consistency and use automatically incremented values instead of
> assigning fixed values to ease adding new controller IDs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> applied to #tj-upstream-fixes.
> 
>  drivers/ata/ata_piix.c |   62 ++++++++++++++++++++++++------------------------
>  1 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 80b735b..77fea05 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -119,18 +119,18 @@ enum {
>  	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
>  
>  	/* controller IDs */
> -	piix_pata_33		= 0,	/* PIIX4 at 33Mhz */
> -	ich_pata_33		= 1,	/* ICH up to UDMA 33 only */
> -	ich_pata_66		= 2,	/* ICH up to 66 Mhz */
> -	ich_pata_100		= 3,	/* ICH up to UDMA 100 */
> -	ich5_sata		= 5,
> -	ich6_sata		= 6,
> -	ich6_sata_ahci		= 7,
> -	ich6m_sata_ahci		= 8,
> -	ich8_sata_ahci		= 9,
> -	piix_pata_mwdma		= 10,	/* PIIX3 MWDMA only */
> -	tolapai_sata_ahci	= 11,
> -	ich9_2port_sata		= 12,
> +	piix_pata_mwdma		= 0,	/* PIIX3 MWDMA only */
> +	piix_pata_33,			/* PIIX4 at 33Mhz */
> +	ich_pata_33,			/* ICH up to UDMA 33 only */
> +	ich_pata_66,			/* ICH up to 66 Mhz */
> +	ich_pata_100,			/* ICH up to UDMA 100 */
> +	ich5_sata,
> +	ich6_sata,
> +	ich6_sata_ahci,
> +	ich6m_sata_ahci,
> +	ich8_sata_ahci,
> +	ich8_2port_sata,
> +	tolapai_sata_ahci,

When using automatically filled values, please move to a separate and 
distinct enum...

ACK everything else

	Jeff



