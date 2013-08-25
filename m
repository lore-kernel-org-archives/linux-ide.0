From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v5 1/4] libata: Populate host-to-device FIS "auxiliary" field
Date: Sat, 24 Aug 2013 23:22:48 -0700
Message-ID: <1377411771-3733-2-git-send-email-marc.ceeeee@gmail.com>
References: <1377411771-3733-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:33036 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859Ab3HYGXS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Aug 2013 02:23:18 -0400
Received: by mail-oa0-f41.google.com with SMTP id j20so139834oag.0
        for <linux-ide@vger.kernel.org>; Sat, 24 Aug 2013 23:23:17 -0700 (PDT)
In-Reply-To: <1377411771-3733-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

SATA 3.1 added an "auxiliary" field to the host-to-device FIS.
Populate the host-to-device FIS with the new field via the
taskfile struct.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 drivers/ata/libata-core.c | 10 ++++++----
 include/linux/libata.h    |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c24354d..9062aa0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -546,6 +546,8 @@ int atapi_cmd_type(u8 opcode)
  */
 void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 {
+	const __le32 aux = cpu_to_le32(tf->auxiliary);
+
 	fis[0] = 0x27;			/* Register - Host to Device FIS */
 	fis[1] = pmp & 0xf;		/* Port multiplier number*/
 	if (is_cmd)
@@ -569,10 +571,10 @@ void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 	fis[14] = 0;
 	fis[15] = tf->ctl;
 
-	fis[16] = 0;
-	fis[17] = 0;
-	fis[18] = 0;
-	fis[19] = 0;
+	fis[16] = aux & 0xff;
+	fis[17] = (aux >> 8) & 0xff;
+	fis[18] = (aux >> 16) & 0xff;
+	fis[19] = (aux >> 24) & 0xff;
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 283d66b..47122f4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -555,6 +555,10 @@ struct ata_taskfile {
 	u8			device;
 
 	u8			command;	/* IO operation */
+
+	u32			auxiliary;	/* auxiliary field */
+						/* from SATA 3.1 and */
+						/* ATA-8 ACS-3 */
 };
 
 #ifdef CONFIG_ATA_SFF
-- 
1.8.1.2

