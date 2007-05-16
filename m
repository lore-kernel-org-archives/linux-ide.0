From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/8] libata: fix the ata_altstatus() in ata_hsm_qc_complete()
Date: Wed, 16 May 2007 15:09:43 +0800
Message-ID: <464AAE37.6070405@tw.ibm.com>
References: <464AACDF.1030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:43599 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbXEPHJu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 03:09:50 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l4G76ATf002909
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:06:10 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4G79kZd192432
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:09:46 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4G79j4k032536
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:09:45 -0600
In-Reply-To: <464AACDF.1030903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

patch 1/8:
In ata_hsm_qc_complete():
Calling ata_altstatus() after the qc completed looks unsafe.
Move it to be before completing the qc.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Don't know what the ata_altstatus() is doing here?
Anyway, move it to be before ata_qc_complete().

diff -Nrup 00_libata-dev/drivers/ata/libata-core.c 01_flush_fix/drivers/ata/libata-core.c
--- 00_libata-dev/drivers/ata/libata-core.c	2007-05-14 12:18:45.000000000 +0800
+++ 01_flush_fix/drivers/ata/libata-core.c	2007-05-15 10:05:33.000000000 +0800
@@ -4740,6 +4740,8 @@ static void ata_hsm_qc_complete(struct a
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
 
+	ata_altstatus(ap); /* flush */
+
 	if (ap->ops->error_handler) {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
@@ -4772,8 +4774,6 @@ static void ata_hsm_qc_complete(struct a
 		} else
 			ata_qc_complete(qc);
 	}
-
-	ata_altstatus(ap); /* flush */
 }
 
 /**


