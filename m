From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: fix ata_id_logical_per_physical_sectors
Date: Thu, 28 Jan 2010 13:56:21 +0300
Message-ID: <4B616D55.6080802@ru.mvista.com>
References: <20100128104234.GA25693@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:19715 "HELO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752791Ab0A1K45 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2010 05:56:57 -0500
In-Reply-To: <20100128104234.GA25693@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

Hello.

Christoph Hellwig wrote:

> The value we get from the low byte of the ATA_ID_SECTOR_SIZE word is not not
> a plain multiple, but the log of it, so fix the helper to give the correct
> answer.  Without this we'll get an incorrect minimal I/O size in the block
> limits VPD page for 4k sector drives.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Index: linux-2.6/include/linux/ata.h
> ===================================================================
> --- linux-2.6.orig/include/linux/ata.h	2010-01-28 11:17:41.968003842 +0100
> +++ linux-2.6/include/linux/ata.h	2010-01-28 11:20:02.355268610 +0100
> @@ -649,7 +649,7 @@ static inline int ata_id_has_large_logic
>  
>  static inline u8 ata_id_logical_per_physical_sectors(const u16 *id)
>  {
> -	return id[ATA_ID_SECTOR_SIZE] & 0xf;
> +	return 1 << (id[ATA_ID_SECTOR_SIZE] & 0xf);
>   

   Will this still fit into u8?

WBR, Sergei


