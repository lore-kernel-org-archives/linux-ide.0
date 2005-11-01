From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/4] irq-pio: misc fixes
Date: Tue, 01 Nov 2005 19:19:01 +0800
Message-ID: <43674F25.6080109@tw.ibm.com>
References: <43674D9A.9010007@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:34243 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750746AbVKALTF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 06:19:05 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA1BIx7e021559
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 06:18:59 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id jA1BIxfJ536622
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:18:59 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jA1BIwMs014447
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:18:58 -0700
In-Reply-To: <43674D9A.9010007@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <mlord@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Patch 1/4: misc fixes

Changes:
   - ata_pio_block(): add ata_altstatus(ap) to prevent reading device status before it is valid
   - remove the unnecessary HSM_ST_IDLE state from ata_pio_task()
   - raise BUG() when unknown state is found in ata_pio_task()

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============

--- linux-ori/drivers/scsi/libata-core.c	2005-11-01 17:22:41.000000000 +0800
+++ id1/drivers/scsi/libata-core.c	2005-11-01 18:45:16.000000000 +0800
@@ -3224,6 +3224,8 @@ static void ata_pio_block(struct ata_por
 
 		ata_pio_sector(qc);
 	}
+
+	ata_altstatus(ap); /* flush */
 }
 
 static void ata_pio_error(struct ata_port *ap)
@@ -3251,9 +3253,6 @@ fsm_start:
 	qc_completed = 0;
 
 	switch (ap->hsm_task_state) {
-	case HSM_ST_IDLE:
-		return;
-
 	case HSM_ST:
 		ata_pio_block(ap);
 		break;
@@ -3271,6 +3270,10 @@ fsm_start:
 	case HSM_ST_ERR:
 		ata_pio_error(ap);
 		return;
+
+	default:
+		BUG();
+		return;
 	}
 
 	if (timeout)


