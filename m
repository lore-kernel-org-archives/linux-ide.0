From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/4] libata: determine the err_mask directly in atapi_packet_task()
Date: Mon, 05 Dec 2005 15:42:17 +0800
Message-ID: <4393EF59.8080805@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com> <4372FD45.8080404@tw.ibm.com> <43924E11.60500@pobox.com> <4393E513.5070203@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:49309 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751323AbVLEHmU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Dec 2005 02:42:20 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jB57gEDl029555
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 02:42:14 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jB57faaN067530
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 00:41:36 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jB57gEOv026275
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 00:42:14 -0700
In-Reply-To: <4393E513.5070203@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 4/4:
  determine the err_mask directly in atapi_packet_task()

Changes:
  - set qc->err_mask directly when we found the error
  - remove the code to determine err_mask from device status

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============

--- err_mask3/drivers/scsi/libata-core.c	2005-12-05 12:42:06.000000000 +0800
+++ err_mask4/drivers/scsi/libata-core.c	2005-12-05 12:44:28.000000000 +0800
@@ -4083,13 +4083,17 @@ static void atapi_packet_task(void *_dat
 
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
-	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
-		goto err_out_status;
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
+		qc->err_mask |= AC_ERR_ATA_BUS;
+		goto err_out;
+	}
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
-	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
+	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
+		qc->err_mask |= AC_ERR_ATA_BUS;
 		goto err_out;
+	}
 
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
@@ -4121,10 +4125,7 @@ static void atapi_packet_task(void *_dat
 
 	return;
 
-err_out_status:
-	status = ata_chk_status(ap);
 err_out:
-	qc->err_mask |= __ac_err_mask(status);
 	ata_poll_qc_complete(qc);
 }
 


