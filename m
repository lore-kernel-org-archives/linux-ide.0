From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
Date: Tue, 13 Nov 2007 18:30:24 +0800
Message-ID: <47397CC0.1070401@tw.ibm.com>
References: <471C6C44.2030607@gmail.com> <471CEDD4.5040201@garzik.org> <471D25D0.9020702@rtr.ca> <47397784.9070205@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:55535 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbXKMKaf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 05:30:35 -0500
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id lAD9Tiu2006092
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 04:29:44 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id lADAUT1S109448
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 03:30:29 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lADAUSYo032298
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 03:30:29 -0700
In-Reply-To: <47397784.9070205@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>


After an error condition, some ATAPI tape drives set DRQ=1 together with ERR=1
when asking the host to transfer the CDB of the next packet command (i.e. request sense).
This patch workarounds the problem by ignoring the ERR bit and proceed REQUEST SENSE.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>
---
Tested ok with the Seagate STT8000A tape drive. A similar workaround is seen in ide-tape.c:

	if (status.b.check && pc->c[0] == IDETAPE_REQUEST_SENSE_CMD)
		status.b.check = 0;

Although ide-tape only does it when DRQ=0...

--- linux-2.6.23.1/drivers/ata/libata-core.c.orig	2007-10-13 00:43:44.000000000 +0800
+++ linux-2.6.23.1/drivers/ata/libata-core.c	2007-11-13 17:11:03.000000000 +0800
@@ -4930,11 +4930,18 @@ fsm_start:
 		 * let the EH abort the command or reset the device.
 		 */
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
-			ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
-					"error, dev_stat 0x%X\n", status);
-			qc->err_mask |= AC_ERR_HSM;
-			ap->hsm_task_state = HSM_ST_ERR;
-			goto fsm_start;
+			/* Some ATAPI tape drives forget to clear the ERR bit
+			 * when doing the next command (i.e. request sense). We
+			 * ignore ERR here to workaround and proceed REQUEST_SENSE.
+			 */
+			if (qc->tf.protocol == ATA_PROT_PIO ||
+			    qc->cdb[0] != REQUEST_SENSE) {
+				ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
+						"error, dev_stat 0x%X\n", status);
+				qc->err_mask |= AC_ERR_HSM;
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
 		}
 
 		/* Send the CDB (atapi) or the first data block (ata pio out).


