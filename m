From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 5/6] libata: support ATAPI devices
Date: Thu, 07 Jun 2007 15:59:05 +0800
Message-ID: <4667BAC9.2090406@tw.ibm.com>
References: <4667B767.5060601@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:46738 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbXFGH7L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 03:59:11 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l577xAQT012218
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 03:59:10 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l577xAFA218610
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:59:10 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l577x91f020552
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:59:10 -0600
In-Reply-To: <4667B767.5060601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>

Patch 5/6:
 Support ATA passthru to ATAPI devices.
Revised based on Mark's patch and Jeff's comments.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Mark Lord <mlord@pobox.com> 
---
After reading Mark's patch, I guess we can safely by-pass the 
cdb_len check: the ATA_12/ATA_16 are for the libata SATL and
get unwrapped to ATA taskfiles before the devices ever see them.

diff -Nrup 04_dev_bit/drivers/ata/libata-scsi.c 05_supp_atapi/drivers/ata/libata-scsi.c
--- 04_dev_bit/drivers/ata/libata-scsi.c	2007-06-07 14:44:27.000000000 +0800
+++ 05_supp_atapi/drivers/ata/libata-scsi.c	2007-06-07 14:44:30.000000000 +0800
@@ -2701,10 +2701,6 @@ static inline ata_xlat_func_t ata_get_xl
 	case VERIFY_16:
 		return ata_scsi_verify_xlat;
 
-	case ATA_12:
-	case ATA_16:
-		return ata_scsi_pass_thru;
-
 	case START_STOP:
 		return ata_scsi_start_stop_xlat;
 	}
@@ -2740,8 +2736,14 @@ static inline int __ata_scsi_queuecmd(st
 				      void (*done)(struct scsi_cmnd *),
 				      struct ata_device *dev)
 {
+	u8 cmd = scmd->cmnd[0];
 	int rc = 0;
 
+	if (unlikely(cmd == ATA_12 || cmd == ATA_16)) {
+		rc = ata_scsi_translate(dev, scmd, done, ata_scsi_pass_thru);
+		return rc;
+	}
+
 	if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len)) {
 		DPRINTK("bad CDB len=%u, max=%u\n",
 			scmd->cmd_len, dev->cdb_len);
@@ -2751,8 +2753,7 @@ static inline int __ata_scsi_queuecmd(st
 	}
 
 	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      scmd->cmnd[0]);
+		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev, cmd);
 
 		if (xlat_func)
 			rc = ata_scsi_translate(dev, scmd, done, xlat_func);


