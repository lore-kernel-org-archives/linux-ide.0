From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] libata: fix reporting of drained bytes when clearing
 DRQ
Date: Tue, 15 Dec 2009 19:16:55 -0600
Message-ID: <4B283507.1090808@gmail.com>
References: <4B1F0FEA.7070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:45738 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbZLPBQ7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2009 20:16:59 -0500
Received: by ywh12 with SMTP id 12so581677ywh.21
        for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 17:16:58 -0800 (PST)
In-Reply-To: <4B1F0FEA.7070403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: ide <linux-ide@vger.kernel.org>

On 12/08/2009 08:48 PM, Robert Hancock wrote:
> When we drain data from a device to clear DRQ during error recovery, the number
> of bytes reported as drained is too low by a factor of 2 because the count
> is actually reporting the number of words drained, not bytes. Fix this.
>
> Signed-off-by: Robert Hancock<hancockrwd@gmail.com>
>
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 51eb1e2..3afa21b 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2275,7 +2275,7 @@ void ata_sff_drain_fifo(struct ata_queued_cmd *qc)
>   	ap = qc->ap;
>   	/* Drain up to 64K of data before we give up this recovery method */
>   	for (count = 0; (ap->ops->sff_check_status(ap)&  ATA_DRQ)
> -						&&  count<  32768; count++)
> +						&&  count<  65536; count += 2)
>   		ioread16(ap->ioaddr.data_addr);
>
>   	/* Can become DEBUG later */

Jeff, ping?
