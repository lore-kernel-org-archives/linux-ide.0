From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Fri, 7 Jul 2006 09:43:17 -0400
Message-ID: <200607070943.17957.liml@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <200607070908.44751.liml@rtr.ca> <Pine.LNX.4.64.0607070923130.4099@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4075 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750957AbWGGNnU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jul 2006 09:43:20 -0400
In-Reply-To: <Pine.LNX.4.64.0607070923130.4099@p34.internal.lan>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Sander <sander@humilis.net>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Justin Piszcz wrote:
> 
> had to change
> 
> KERN_WARN -> KERN_WARNING
> 
> then more errors

Eh?  After fixing the KERN_WARN -> KERN_WARNING part,
the patch compiles / links cleanly here on 2.6.17.
(fixed copy below).   Still untested, though.

> do you know who wrote the original patch?

I did.

Cheers

--- linux/drivers/scsi/libata-scsi.c.orig	2006-06-19 10:37:03.000000000 -0400
+++ linux/drivers/scsi/libata-scsi.c	2006-07-07 09:06:57.000000000 -0400
@@ -542,6 +542,7 @@
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned char *sb = cmd->sense_buffer;
 	unsigned char *desc = sb + 8;
+	unsigned char ata_op = tf->command;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
 
@@ -558,6 +559,7 @@
 	 * onto sense key, asc & ascq.
 	 */
 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
+		printk(KERN_WARNING "ata_gen_ata_desc_sense: failed ata_op=0x%02x\n", ata_op);
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[1], &sb[2], &sb[3]);
 		sb[1] &= 0x0f;
