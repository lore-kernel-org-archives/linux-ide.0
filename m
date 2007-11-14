From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
Date: Wed, 14 Nov 2007 14:13:05 +0800
Message-ID: <473A91F1.1060003@tw.ibm.com>
References: <471C6C44.2030607@gmail.com>	<471CEDD4.5040201@garzik.org>	<471D25D0.9020702@rtr.ca>	<47397784.9070205@tw.ibm.com>	<47397CC0.1070401@tw.ibm.com>	<4739AB5B.7000703@rtr.ca>	<20071113151459.086ffcae@the-village.bc.nu>	<4739DDDD.7060305@rtr.ca> <20071113181257.24ab95dd@the-village.bc.nu> <4739EB53.5010206@rtr.ca> <473A56CE.4080804@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:39594 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759620AbXKNGNO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 01:13:14 -0500
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAE6DE01015682
	for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 01:13:14 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id lAE6DEPh124138
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 23:13:14 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lAE6DDpa013833
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 23:13:14 -0700
In-Reply-To: <473A56CE.4080804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

After an error condition, some ATAPI tape drives set DRQ=1 together with ERR=1
when asking the host to transfer the CDB of the next packet command (i.e. request sense).
This patch, a revised version of Alan/Mark's previous patch, adds ATA_HORKAGE_STUCK_ERR
to workaround the problem by ignoring the ERR bit and proceed sending the CDB.


Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>
---
Revised per Alan, Mark and Tejun's comments. Tested ok with the Seagate STT8000A tape drive.
Patch against the libata-dev tree.

diff -Nrup 00_libata-dev/drivers/ata/libata-core.c 01_ide_tape_stuck_err/drivers/ata/libata-core.c
--- 00_libata-dev/drivers/ata/libata-core.c	2007-11-14 10:08:36.000000000 +0800
+++ 01_ide_tape_stuck_err/drivers/ata/libata-core.c	2007-11-14 11:20:31.000000000 +0800
@@ -5490,11 +5490,19 @@ fsm_start:
 		 * let the EH abort the command or reset the device.
 		 */
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
-			ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
-					"error, dev_stat 0x%X\n", status);
-			qc->err_mask |= AC_ERR_HSM;
-			ap->hsm_task_state = HSM_ST_ERR;
-			goto fsm_start;
+			/* Some ATAPI tape drives forget to clear the ERR bit
+			 * when doing the next command (mostly request sense).
+			 * We ignore ERR here to workaround and proceed sending
+			 * the CDB.
+			 */
+			if (!(qc->dev->horkage & ATA_HORKAGE_STUCK_ERR)) {
+				ata_port_printk(ap, KERN_WARNING,
+						"DRQ=1 with device error, "
+						"dev_stat 0x%X\n", status);
+				qc->err_mask |= AC_ERR_HSM;
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
 		}
 
 		/* Send the CDB (atapi) or the first data block (ata pio out).
diff -Nrup 00_libata-dev/include/linux/libata.h 01_ide_tape_stuck_err/include/linux/libata.h
--- 00_libata-dev/include/linux/libata.h	2007-11-14 10:08:59.000000000 +0800
+++ 01_ide_tape_stuck_err/include/linux/libata.h	2007-11-14 11:19:32.000000000 +0800
@@ -340,6 +340,7 @@ enum {
 	ATA_HORKAGE_HPA_SIZE	= (1 << 6),	/* native size off by one */
 	ATA_HORKAGE_IPM		= (1 << 7),	/* Link PM problems */
 	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
+	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */


