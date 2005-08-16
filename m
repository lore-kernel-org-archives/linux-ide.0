From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: Clear ATA_QCFLAG_ACTIVE flag before calling the completion
 callback
Date: Tue, 16 Aug 2005 14:25:38 +0800
Message-ID: <430186E2.4050203@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030609090104040701010401"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:36334 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S932603AbVHPG0h
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 02:26:37 -0400
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp01.au.ibm.com (8.12.10/8.12.10) with ESMTP id j7G6SnAP061066
	for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 16:28:54 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7G6T33f063266
	for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 16:29:03 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11/8.13.3) with ESMTP id j7G6Q2Xa015144
	for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 16:26:03 +1000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------030609090104040701010401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

Description:
  After calling the completion callback, the libata error handler might be
running and getting atapi sense data. Clearing the ATA_QCFLAG_ACTIVE flag
at this point might interfere with the libata error handler.

Changes:
   - Clear the ATA_QCFLAG_ACTIVE flag before calling the completion callback
     (and also before the error handler)
   - Add some comment

Resend for 2.6.13-rc6(3edea4833a1efcd43e1dff082bc8001fdfe74b34).
For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------030609090104040701010401
Content-Type: text/plain;
 name="misc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc1.diff"

--- linux/drivers/scsi/libata-core.c	2005-08-16 10:54:12.000000000 +0800
+++ 01_qcactive/drivers/scsi/libata-core.c	2005-08-16 13:36:22.000000000 +0800
@@ -3086,9 +3086,14 @@
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
 
+	/* atapi: mark qc as inactive to prevent the interrupt handler
+	 * from completing the command twice later, before the error handler
+	 * is called. (when rc != 0 and atapi request sense is needed)
+	 */
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
+
 	/* call completion callback */
 	rc = qc->complete_fn(qc, drv_stat);
-	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately

--------------030609090104040701010401--

