From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 6/6] libata: update cached device paramters
Date: Thu, 07 Jun 2007 16:01:17 +0800
Message-ID: <4667BB4D.3090101@tw.ibm.com>
References: <4667B767.5060601@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:49913 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbXFGIBY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 04:01:24 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5781LqS030524
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 04:01:21 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5781Lqg208990
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 02:01:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5781KuA024610
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 02:01:21 -0600
In-Reply-To: <4667B767.5060601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 6/6:
INIT_DEV_PARAMS and SET_MULTI_MODE change the device parameters cached by libata.
Re-read IDENTIFY DEVICE info and update the cached device paramters when seeing these commands.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 05_supp_atapi/drivers/ata/libata-scsi.c 06_sync_param/drivers/ata/libata-scsi.c
--- 05_supp_atapi/drivers/ata/libata-scsi.c	2007-06-07 14:44:30.000000000 +0800
+++ 06_sync_param/drivers/ata/libata-scsi.c	2007-06-07 14:44:33.000000000 +0800
@@ -1363,12 +1363,22 @@ static void ata_scsi_qc_complete(struct 
 	 * schedule EH_REVALIDATE operation to update the IDENTIFY DEVICE
 	 * cache
 	 */
-	if (ap->ops->error_handler &&
-	    !need_sense && (qc->tf.command == ATA_CMD_SET_FEATURES) &&
-	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
-	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
-		ap->eh_info.action |= ATA_EH_REVALIDATE;
-		ata_port_schedule_eh(ap);
+	if (ap->ops->error_handler && !need_sense) {
+		switch (qc->tf.command) {
+		case ATA_CMD_SET_FEATURES:
+			if ((qc->tf.feature == SETFEATURES_WC_ON) ||
+			    (qc->tf.feature == SETFEATURES_WC_OFF)) {
+				ap->eh_info.action |= ATA_EH_REVALIDATE;
+				ata_port_schedule_eh(ap);
+			}
+			break;
+
+		case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
+		case ATA_CMD_SET_MULTI: /* multi_count changed */
+			ap->eh_info.action |= ATA_EH_REVALIDATE;
+			ata_port_schedule_eh(ap);
+			break;
+		}
 	}
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
diff -Nrup 05_supp_atapi/include/linux/ata.h 06_sync_param/include/linux/ata.h
--- 05_supp_atapi/include/linux/ata.h	2007-06-06 13:34:05.000000000 +0800
+++ 06_sync_param/include/linux/ata.h	2007-06-07 10:50:26.000000000 +0800
@@ -151,6 +151,7 @@ enum {
 	ATA_CMD_WRITE_MULTI_EXT	= 0x39,
 	ATA_CMD_WRITE_MULTI_FUA_EXT = 0xCE,
 	ATA_CMD_SET_FEATURES	= 0xEF,
+	ATA_CMD_SET_MULTI	= 0xC6,
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
 	ATA_CMD_VERIFY_EXT	= 0x42,


