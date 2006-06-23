From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata: minor patch for ATA_DFLAG_PIO
Date: Thu, 22 Jun 2006 23:14:56 -0400
Message-ID: <449B5CB0.7050208@pobox.com>
References: <4497EB88.8030903@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46982 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751139AbWFWDPD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jun 2006 23:15:03 -0400
In-Reply-To: <4497EB88.8030903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@bebe.enoyolf.org>, Linux IDE <linux-ide@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> Problem:
>  - With 2.6.17, some PIO-only devices are given DMA commands.
> 
> Changes:
>  - Do not clear the ATA_DFLAG_PIO flag in ata_dev_configure().
> 
> Original patch by Tejun.
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> --
> The patch is done by Tejun and already in libata-dev upstream.
> Maybe we also need this for 2.6.17.
> 
> For your review, thanks.
> 
> albert
> 
> diff -Nrup linux-2.6.17-0/drivers/scsi/libata-core.c linux-2.6.17-1/drivers/scsi/libata-core.c
> --- linux-2.6.17-0/drivers/scsi/libata-core.c	2006-06-18 09:49:35.000000000 +0800
> +++ linux-2.6.17-1/drivers/scsi/libata-core.c	2006-06-20 16:56:14.000000000 +0800
> @@ -1229,7 +1229,7 @@ static int ata_dev_configure(struct ata_
>  		       id[84], id[85], id[86], id[87], id[88]);
>  
>  	/* initialize to-be-configured parameters */
> -	dev->flags = 0;
> +	dev->flags &= ~ATA_DFLAG_CFG_MASK;
>  	dev->max_sectors = 0;
>  	dev->cdb_len = 0;
>  	dev->n_sectors = 0;
> diff -Nrup linux-2.6.17-0/include/linux/libata.h linux-2.6.17-1/include/linux/libata.h
> --- linux-2.6.17-0/include/linux/libata.h	2006-06-18 09:49:35.000000000 +0800
> +++ linux-2.6.17-1/include/linux/libata.h	2006-06-20 16:55:41.000000000 +0800
> @@ -120,9 +120,12 @@ enum {
>  	ATA_SHT_USE_CLUSTERING	= 1,
>  
>  	/* struct ata_device stuff */
> -	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
> -	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
> -	ATA_DFLAG_LBA		= (1 << 2), /* device supports LBA */
> +	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
> +	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
> +
> +	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
> +
> +	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */

ACK for 2.6.17, if you would like to send it to stable@kernel.org...

	Jeff


