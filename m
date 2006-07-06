From: Mark Lord <liml@rtr.ca>
Subject: Re: libata EH appears to be NFG up to 2.6.17 (at least).
Date: Thu, 6 Jul 2006 17:24:13 -0400
Message-ID: <200607061724.13448.liml@rtr.ca>
References: <44AD749C.1070208@rtr.ca> <44AD76CA.40100@pobox.com> <44AD77D5.90905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:27870 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750771AbWGFVZf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jul 2006 17:25:35 -0400
In-Reply-To: <44AD77D5.90905@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Ric Wheeler <ric@emc.com>

On Thursday 06 July 2006 16:51, Mark Lord wrote:
>..
> All drivers, all architectures.  Dunno about 2.6.18-rc1 yet.
>
> This patch (below) appears to fix it, but I really need your opinion
> on its correctness.  My apologies in advance for the likely bad whitespace,
> as I don't currently have access to my usual patch-mailer at present.

Whoops.. got the wrong function when regenerating the patch.
Here it is again, on the correct lines:

Enable libata-scsi to report correct sense data on errors.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---
--- linux/drivers/scsi/libata-scsi.c.orig	2006-07-06 17:09:54.000000000 -0400
+++ linux/drivers/scsi/libata-scsi.c	2006-07-06 17:17:43.000000000 -0400
@@ -667,6 +667,13 @@
 	qc->ap->ops->tf_read(qc->ap, tf);
 
 	/*
+	 * Restore the error bit, which got cleared when the
+	 * interrupt handler first read the ata_status.
+	 */
+	if (qc->err_mask & AC_ERR_DEV)
+		tf->command |= ATA_ERR;
+
+	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
