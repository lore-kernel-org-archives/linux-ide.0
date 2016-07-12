From: tom.ty89@gmail.com
Subject: [PATCH resend 2/2] libata-scsi: correct SPC version descriptor
Date: Tue, 12 Jul 2016 21:29:35 +0800
Message-ID: <5784f0c7.8469620a.ab9e4.ffff999d@mx.google.com>
References: <20160712132935.1811-1-me>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20160712132935.1811-1-me>
Sender: linux-scsi-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
List-Id: linux-ide@vger.kernel.org

From: Tom Yan <tom.ty89@gmail.com>

The comment suggests we should be having an SPC-3 version descriptor
but the 0260h is the code for "SPC-2 (no version claimed)". Correct
it to 0300h so that it has the "SPC-3 (no version claimed)" descriptor.

Note that we are claiming SPC-3 version compatibility in the VERSION
field of the standard INQUIRY data. Therefore, I assume the typo was
on the code but not on the comment.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0a35164..8221800 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2075,8 +2075,8 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		0x03,
 		0x20,	/* SBC-2 (no version claimed) */
 
-		0x02,
-		0x60	/* SPC-3 (no version claimed) */
+		0x03,
+		0x00	/* SPC-3 (no version claimed) */
 	};
 	const u8 versions_zbc[] = {
 		0x00,
-- 
2.9.0

