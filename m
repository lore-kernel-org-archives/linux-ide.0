From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] libata: fix ata_id_logical_per_physical_sectors
Date: Wed, 3 Feb 2010 18:37:21 +0100
Message-ID: <20100203173721.GA21703@lst.de>
References: <20100128104234.GA25693@lst.de> <20100128123011.GA32001@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:40825 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932673Ab0BCRjJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Feb 2010 12:39:09 -0500
Content-Disposition: inline
In-Reply-To: <20100128123011.GA32001@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org

Jeff, ping?  Without this patch the minimum I/O size for 4k drives will
be reported incorrectly, which will make paritions misaligned on modern
distros.

On Thu, Jan 28, 2010 at 01:30:11PM +0100, Christoph Hellwig wrote:
> The value we get from the low byte of the ATA_ID_SECTOR_SIZE word is not not
> a plain multiple, but the log of it, so fix the helper to give the correct
> answer.  Without this we'll get an incorrect minimal I/O size in the block
> limits VPD page for 4k sector drives.
> 
> Also change the return value of ata_id_logical_per_physical_sectors to u16
> for the unlikely case of very large logical sectors.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: linux-2.6/include/linux/ata.h
> ===================================================================
> --- linux-2.6.orig/include/linux/ata.h	2010-01-28 12:24:02.061016474 +0100
> +++ linux-2.6/include/linux/ata.h	2010-01-28 13:26:59.270005271 +0100
> @@ -647,9 +647,9 @@ static inline int ata_id_has_large_logic
>  	return id[ATA_ID_SECTOR_SIZE] & (1 << 13);
>  }
>  
> -static inline u8 ata_id_logical_per_physical_sectors(const u16 *id)
> +static inline u16 ata_id_logical_per_physical_sectors(const u16 *id)
>  {
> -	return id[ATA_ID_SECTOR_SIZE] & 0xf;
> +	return 1 << (id[ATA_ID_SECTOR_SIZE] & 0xf);
>  }
>  
>  static inline int ata_id_has_lba48(const u16 *id)
---end quoted text---
