From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-scsi: automatically use DMADIR if drive/bridge
 requires it
Date: Wed, 20 Feb 2008 12:18:56 -0500
Message-ID: <47BC6100.9020906@pobox.com>
References: <47B9D64C.3000705@rtr.ca> <47B9F05A.1060207@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44487 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976AbYBTRTB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 12:19:01 -0500
In-Reply-To: <47B9F05A.1060207@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Albert Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> Back in 2.6.17-rc2, a libata module parameter was added for atapi_dmadir.
> 
> That's nice, but most SATA devices which need it will tell us about it
> in their IDENTIFY PACKET response, as bit-15 of word-62 of the
> returned data (as per ATA7, ATA8 specifications).
> 
> So for those which specify it, we should automatically use the DMADIR bit.
> Otherwise, disc writing will fail by default on many SATA-ATAPI drives.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/libata-scsi.c    2008-02-18 14:45:08.000000000 -0500
> +++ linux/drivers/ata/libata-scsi.c    2008-02-18 14:53:02.000000000 -0500
> @@ -2543,9 +2543,10 @@
>         qc->tf.protocol = ATAPI_PROT_DMA;
>         qc->tf.feature |= ATAPI_PKT_DMA;
> 
> -        if (atapi_dmadir && (scmd->sc_data_direction != DMA_TO_DEVICE))
> -            /* some SATA bridges need us to indicate data xfer 
> direction */
> -            qc->tf.feature |= ATAPI_DMADIR;
> +        /* some SATA bridges need us to indicate data xfer direction */
> +        if (atapi_dmadir || (dev->id[62] & 0x8000))
> +            if (scmd->sc_data_direction != DMA_TO_DEVICE)
> +                qc->tf.feature |= ATAPI_DMADIR;

Regardless of the historical usage (or lack thereof) of that I.D. word, 
I would prefer

1) an ata version check

2) a simple wrapper in linux/ata.h, similar to the many that already exist

So, conditional ACK...

