From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 08:59:01 -0400
Message-ID: <46349695.7080706@rtr.ca>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com> <463487F0.4040701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1318 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933213AbXD2M7D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Apr 2007 08:59:03 -0400
In-Reply-To: <463487F0.4040701@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>> Tejun Heo wrote:
>> ..
>>> Anyways, can you try to hack it into ata_bmdma_error_handler() and see
>>> whether it actually works?  You can check for AC_ERR_HSM there and drain
>>> data port if DRQ is set.  After HSM, ATA_NIEN is set and the port should
>>> be quiescent at that point.
> 
> Sure, I'll do that here shortly.

Okay, it recovers nicely now with the patch below,
which I'm including for illustrative purposes only.
Ideally, we would look into the qc to see how large
the request was, and determine the drain "limit" based
on that.  But I got tired of rebooting and just hardcoded
it for the time being.

For my failed IDENTIFY, it claims 255 iterations.
Which makes sense, as tf_read probably already read one word
of the 256 words in the pipeline.

Draining is a nice workaround for most problems,
but we cannot drain for a WRITE --> wrong data direction,
and I don't want to feed bad data *into* the output FIFO.
Mmm.. I guess I'll have to try a failed WRITE under the
same circumstances and see what that does.  Probably it just
recovers without any fuss, as the FIFO will be empty anyway.

>> Ah.. one more thing, is this draining also needed after DMA commands or
>> only after PIO commands?

My drive doesn't do IDENTIFY_DMA, so I fed it a READ_DMA instead
with "no data", and libata recovered without draining.

Here's the hack I used:

--- linux/drivers/ata/libata-sff.c.orig	2007-04-26 12:02:46.000000000 -0400
+++ linux/drivers/ata/libata-sff.c	2007-04-29 08:29:27.000000000 -0400
@@ -413,6 +413,24 @@
 	ap->ops->irq_on(ap);
 }
 
+static void ata_drain_fifo (struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	u8 stat = ata_chk_status(ap);
+	/*
+	 * Try to clear stuck DRQ if necessary.
+	 */
+	if ((stat & ATA_DRQ) && (!qc || qc->dma_dir != DMA_TO_DEVICE)) {
+		unsigned int i, limit = 512;
+		printk("Draining up to %u words from data FIFO.\n", limit);
+		for (i = 0; i < limit ; ++i) {
+			ioread16(ap->ioaddr.data_addr);
+			if (!(ata_chk_status(ap) & ATA_DRQ))
+				break;
+		}
+		printk("Drained %u/%u words.\n", i, limit);
+	}
+}
+
 /**
  *	ata_bmdma_drive_eh - Perform EH with given methods for BMDMA controller
  *	@ap: port to handle error for
@@ -469,7 +487,7 @@
 	}
 
 	ata_altstatus(ap);
-	ata_chk_status(ap);
+	ata_drain_fifo(ap, qc);
 	ap->ops->irq_clear(ap);
 
 	spin_unlock_irqrestore(ap->lock, flags);
