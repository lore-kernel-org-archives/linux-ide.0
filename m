From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: print device model and firmware revision for
 ATAPI devices
Date: Tue, 05 Jun 2007 13:01:33 +0800
Message-ID: <4664EE2D.5040607@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:45385 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXFEFCE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jun 2007 01:02:04 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l55520kF015813
	for <linux-ide@vger.kernel.org>; Tue, 5 Jun 2007 01:02:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5551wE9256410
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 23:02:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5551v91014988
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 23:01:58 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

  For ATA/CFA devices, libata prints out the device model and firmware revision.
Do the same for ATAPI devices.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Sometimes the error happens after identify but before the
SCSI messages. Knowing the device model and firmware revision
could also help.

Dmesg looks like below after the patch.
ata1.00: ATA-6: WDC WD2000JB-00KFA0, 08.05J08, max UDMA/100
ata1.00: 390721968 sectors, multi 16: LBA48 
ata5.00: ATAPI: LITE-ON CD-RW SOHR-5238S, 4S07, max UDMA/33
For your review, thanks.

diff -Nrup 00_libata-dev/drivers/ata/libata-core.c 01_atapi_dmesg/drivers/ata/libata-core.c
--- 00_libata-dev/drivers/ata/libata-core.c	2007-06-01 12:08:21.000000000 +0800
+++ 01_atapi_dmesg/drivers/ata/libata-core.c	2007-06-04 15:33:19.000000000 +0800
@@ -1900,6 +1900,13 @@ int ata_dev_configure(struct ata_device 
 	if (ata_msg_probe(ap))
 		ata_dump_id(id);
 
+	/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
+	ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
+			sizeof(fwrevbuf));
+
+	ata_id_c_string(dev->id, modelbuf, ATA_ID_PROD,
+			sizeof(modelbuf));
+
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
 		if (ata_id_is_cfa(id)) {
@@ -1914,13 +1921,6 @@ int ata_dev_configure(struct ata_device 
 
 		dev->n_sectors = ata_id_n_sectors(id);
 
-		/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
-		ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
-				sizeof(fwrevbuf));
-
-		ata_id_c_string(dev->id, modelbuf, ATA_ID_PROD,
-				sizeof(modelbuf));
-
 		if (dev->id[59] & 0x100)
 			dev->multi_count = dev->id[59] & 0xff;
 
@@ -2009,7 +2009,9 @@ int ata_dev_configure(struct ata_device 
 
 		/* print device info to dmesg */
 		if (ata_msg_drv(ap) && print_info)
-			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
+			ata_dev_printk(dev, KERN_INFO,
+				       "ATAPI: %s, %s, max %s%s\n",
+				       modelbuf, fwrevbuf,
 				       ata_mode_string(xfer_mask),
 				       cdb_intr_string);
 	}


