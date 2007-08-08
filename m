From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata git tree, mbox queue status and contents
Date: Wed, 08 Aug 2007 12:28:58 -0400
Message-ID: <46B9EF4A.1030609@garzik.org>
References: <46B35344.3090208@garzik.org> <46B9D64E.6070609@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47846 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936596AbXHHQ3A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Aug 2007 12:29:00 -0400
In-Reply-To: <46B9D64E.6070609@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alan <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Jeff,
> 
> This patch (below) is needed by WD drives that powerup-in-standby.

> drivers/ata/libata-core.c~libata-adjust-libata-to-ignore-errors-after 
> drivers/ata/libata-core.c
> --- a/drivers/ata/libata-core.c~libata-adjust-libata-to-ignore-errors-after
> +++ a/drivers/ata/libata-core.c
> @@ -1723,7 +1723,7 @@ int ata_dev_read_id(struct ata_device *d
>         tf.protocol = ATA_PROT_NODATA;
>         tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>         err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
> -        if (err_mask) {
> +        if (err_mask && id[2] != 0x738c) {
>             rc = -EIO;
>             reason = "SPINUP failed";
>             goto err_out;


Thanks for the poke, it wasn't in my queue.

	Jeff


