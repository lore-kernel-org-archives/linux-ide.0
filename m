From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] libata-zpodd: must use ata_tf_init()
Date: Sun, 23 Jun 2013 23:25:04 +0400
Message-ID: <201306232325.04732.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:51805 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab3FWTZI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jun 2013 15:25:08 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so9428572lab.0
        for <linux-ide@vger.kernel.org>; Sun, 23 Jun 2013 12:25:06 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: aaron.lu@intel.com

There are  some SATA controllers which have both devices 0 and 1 but this module
just zeroes out taskfile and sets then ATA_TFLAG_DEVICE (not sure that's needed)
which could  lead to a wrong device being selected just before issuing command.
Thus we should  call ata_tf_init()  which sets  up the device register value
properly, like  all other users of ata_exec_internal() do...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The  patch is against the 'for-3.10-fixes' branch of Tejun Heo's 'libata.git'
repository. 

 drivers/ata/libata-zpodd.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: libata/drivers/ata/libata-zpodd.c
===================================================================
--- libata.orig/drivers/ata/libata-zpodd.c
+++ libata/drivers/ata/libata-zpodd.c
@@ -32,13 +32,14 @@ struct zpodd {
 
 static int eject_tray(struct ata_device *dev)
 {
-	struct ata_taskfile tf = {};
+	struct ata_taskfile tf;
 	const char cdb[] = {  GPCMD_START_STOP_UNIT,
 		0, 0, 0,
 		0x02,     /* LoEj */
 		0, 0, 0, 0, 0, 0, 0,
 	};
 
+	ata_tf_init(dev, &tf);
 	tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 	tf.protocol = ATAPI_PROT_NODATA;
@@ -52,8 +53,7 @@ static enum odd_mech_type zpodd_get_mech
 	char buf[16];
 	unsigned int ret;
 	struct rm_feature_desc *desc = (void *)(buf + 8);
-	struct ata_taskfile tf = {};
-
+	struct ata_taskfile tf;
 	char cdb[] = {  GPCMD_GET_CONFIGURATION,
 			2,      /* only 1 feature descriptor requested */
 			0, 3,   /* 3, removable medium feature */
@@ -62,6 +62,7 @@ static enum odd_mech_type zpodd_get_mech
 			0, 0, 0,
 	};
 
+	ata_tf_init(dev, &tf);
 	tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 	tf.protocol = ATAPI_PROT_PIO;
