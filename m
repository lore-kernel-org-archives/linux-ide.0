From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/6] ata: add ata_is_fpdma() accessor
Date: Mon, 20 Jun 2016 11:42:49 -0400
Message-ID: <20160620154249.GK3262@mtj.duckdns.org>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
 <1466422756-126637-4-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36705 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbcFTPmw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2016 11:42:52 -0400
Received: by mail-yw0-f194.google.com with SMTP id f75so2773965ywb.3
        for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2016 08:42:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466422756-126637-4-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>

On Mon, Jun 20, 2016 at 01:39:13PM +0200, Hannes Reinecke wrote:
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index d15c19e..264414c 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -152,6 +152,7 @@ enum {
>  	ATA_PROT_FLAG_DATA	= ATA_PROT_FLAG_PIO | ATA_PROT_FLAG_DMA,
>  	ATA_PROT_FLAG_NCQ	= (1 << 2), /* is NCQ */
>  	ATA_PROT_FLAG_ATAPI	= (1 << 3), /* is ATAPI */
> +	ATA_PROT_FLAG_FPDMA	= ATA_PROT_FLAG_NCQ | ATA_PROT_FLAG_DMA,
>  
>  	/* struct ata_device stuff */
>  	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
> @@ -1093,6 +1094,11 @@ static inline int ata_is_data(u8 prot)
>  	return ata_prot_flags(prot) & ATA_PROT_FLAG_DATA;
>  }
>  
> +static inline int ata_is_fpdma(u8 prot)
> +{
> +	return ata_prot_flags(prot) & ATA_PROT_FLAG_FPDMA;
> +}
> +

This is NCQ or DMA which isn't the same thing as some of the tests
it's replacing.  Is this intentional?

Thanks.

-- 
tejun
