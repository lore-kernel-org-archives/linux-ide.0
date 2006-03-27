From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: ata_dev_init_params() fixes
Date: Mon, 27 Mar 2006 16:39:18 +0800
Message-ID: <4427A4B6.4090504@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:27344 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750712AbWC0Ijv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2006 03:39:51 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2R8dZEb022078
	for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 03:39:35 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2R8aHGO258464
	for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 01:36:17 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2R8dOWb016941
	for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 01:39:24 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

ata_dev_init_params() fixes:
- Get the "heads" and "sectors" parameters from caller instead of implicitly from dev->id[].
- Return AC_ERR_INVALID instead of 0 if an invalid parameter is found

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
When testing an old CHS drive, ata_dev_init_params() hit null pointer deference
during boot when accessing dev->id[].
(dev->id is not yet initialized when ata_dev_init_params() is called.)

Patch against upstream (600511e86babe3727264a0883a3a264f6fb6caf5).
For your review, thanks.


--- upstream0/drivers/scsi/libata-core.c	2006-03-27 13:55:23.000000000 +0800
+++ init_params/drivers/scsi/libata-core.c	2006-03-27 13:57:55.000000000 +0800
@@ -62,7 +62,9 @@
 #include "libata.h"
 
 static unsigned int ata_dev_init_params(struct ata_port *ap,
-					struct ata_device *dev);
+					struct ata_device *dev,
+					u16 heads,
+					u16 sectors);
 static void ata_set_mode(struct ata_port *ap);
 static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
 					 struct ata_device *dev);
@@ -1156,7 +1158,7 @@ static int ata_dev_read_id(struct ata_po
 		 * Some drives were very specific about that exact sequence.
 		 */
 		if (ata_id_major_version(id) < 4 || !ata_id_has_lba(id)) {
-			err_mask = ata_dev_init_params(ap, dev);
+			err_mask = ata_dev_init_params(ap, dev, id[3], id[6]);
 			if (err_mask) {
 				rc = -EIO;
 				reason = "INIT_DEV_PARAMS failed";
@@ -2718,16 +2720,16 @@ static unsigned int ata_dev_set_xfermode
  */
 
 static unsigned int ata_dev_init_params(struct ata_port *ap,
-					struct ata_device *dev)
+					struct ata_device *dev,
+					u16 heads,
+					u16 sectors)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
-	u16 sectors = dev->id[6];
-	u16 heads   = dev->id[3];
 
 	/* Number of sectors per track 1-255. Number of heads 1-16 */
 	if (sectors < 1 || sectors > 255 || heads < 1 || heads > 16)
-		return 0;
+		return AC_ERR_INVALID;
 
 	/* set up init dev params taskfile */
 	DPRINTK("init dev params \n");

