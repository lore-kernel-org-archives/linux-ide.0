From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH] libata: Remove unneeded __le32 in ata_tf_to_fis
Date: Sat, 31 Aug 2013 09:20:33 -0700
Message-ID: <1377966033-12256-2-git-send-email-marc.ceeeee@gmail.com>
References: <1377966033-12256-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:48027 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab3HaQVP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Aug 2013 12:21:15 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so3623034oah.37
        for <linux-ide@vger.kernel.org>; Sat, 31 Aug 2013 09:21:14 -0700 (PDT)
In-Reply-To: <1377966033-12256-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

The endianness attribute on the 'aux' local variable wasn't
necessary, so remove it.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 drivers/ata/libata-core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a044be9..83b1a9f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -546,8 +546,6 @@ int atapi_cmd_type(u8 opcode)
  */
 void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 {
-	const __le32 aux = cpu_to_le32(tf->auxiliary);
-
 	fis[0] = 0x27;			/* Register - Host to Device FIS */
 	fis[1] = pmp & 0xf;		/* Port multiplier number*/
 	if (is_cmd)
@@ -571,10 +569,10 @@ void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 	fis[14] = 0;
 	fis[15] = tf->ctl;
 
-	fis[16] = aux & 0xff;
-	fis[17] = (aux >> 8) & 0xff;
-	fis[18] = (aux >> 16) & 0xff;
-	fis[19] = (aux >> 24) & 0xff;
+	fis[16] = tf->auxiliary & 0xff;
+	fis[17] = (tf->auxiliary >> 8) & 0xff;
+	fis[18] = (tf->auxiliary >> 16) & 0xff;
+	fis[19] = (tf->auxiliary >> 24) & 0xff;
 }
 
 /**
-- 
1.8.1.2

