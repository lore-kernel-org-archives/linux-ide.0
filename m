From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/6] libata: always enforce correct DEV bit
Date: Thu, 07 Jun 2007 15:52:07 +0800
Message-ID: <4667B927.3080003@tw.ibm.com>
References: <4667B767.5060601@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:38053 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbXFGHwM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 03:52:12 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l577qBZI032029
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 03:52:11 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l577qB1a267076
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:52:11 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l577qAGI013266
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:52:11 -0600
In-Reply-To: <4667B767.5060601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 4/6:
 Always enforce correct DEV bit since we know which drive the command
is targeted. SAT demands to ignore the DEV bit, too.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 03_udma_supp/drivers/ata/libata-scsi.c 04_dev_bit/drivers/ata/libata-scsi.c
--- 03_udma_supp/drivers/ata/libata-scsi.c	2007-06-07 11:41:30.000000000 +0800
+++ 04_dev_bit/drivers/ata/libata-scsi.c	2007-06-07 14:44:27.000000000 +0800
@@ -2595,12 +2595,10 @@ static unsigned int ata_scsi_pass_thru(s
 		tf->device = cdb[8];
 		tf->command = cdb[9];
 	}
-	/*
-	 * If slave is possible, enforce correct master/slave bit
-	*/
-	if (qc->ap->flags & ATA_FLAG_SLAVE_POSS)
-		tf->device = qc->dev->devno ?
-			tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;
+
+	/* enforce correct master/slave bit */
+	tf->device = dev->devno ?
+		tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;
 
 	/* sanity check for pio multi commands */
 	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf))


