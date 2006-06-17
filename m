From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/6] sata_nv: simplify constants
Date: Sat, 17 Jun 2006 15:49:55 +0900
Message-ID: <11505269952297-git-send-email-htejun@gmail.com>
References: <11505269953650-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:64100 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932387AbWFQGuA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 02:50:00 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1303343nze
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2006 23:49:59 -0700 (PDT)
In-Reply-To: <11505269953650-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Simplify interrupt constants and make NFORCE3 equal to NFORCE2.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

412ebe5f623d51ffe81190a49223ceaf2b28836d
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index e9c4547..1cb7b44 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -54,28 +54,21 @@ enum {
 	NV_PORT0_SCR_REG_OFFSET		= 0x00,
 	NV_PORT1_SCR_REG_OFFSET		= 0x40,
 
+	/* INT_STATUS/ENABLE */
 	NV_INT_STATUS			= 0x10,
-	NV_INT_STATUS_CK804		= 0x440,
-	NV_INT_STATUS_PDEV_INT		= 0x01,
-	NV_INT_STATUS_PDEV_PM		= 0x02,
-	NV_INT_STATUS_PDEV_ADDED	= 0x04,
-	NV_INT_STATUS_PDEV_REMOVED	= 0x08,
-	NV_INT_STATUS_SDEV_INT		= 0x10,
-	NV_INT_STATUS_SDEV_PM		= 0x20,
-	NV_INT_STATUS_SDEV_ADDED	= 0x40,
-	NV_INT_STATUS_SDEV_REMOVED	= 0x80,
-
 	NV_INT_ENABLE			= 0x11,
+	NV_INT_STATUS_CK804		= 0x440,
 	NV_INT_ENABLE_CK804		= 0x441,
-	NV_INT_ENABLE_PDEV_MASK		= 0x01,
-	NV_INT_ENABLE_PDEV_PM		= 0x02,
-	NV_INT_ENABLE_PDEV_ADDED	= 0x04,
-	NV_INT_ENABLE_PDEV_REMOVED	= 0x08,
-	NV_INT_ENABLE_SDEV_MASK		= 0x10,
-	NV_INT_ENABLE_SDEV_PM		= 0x20,
-	NV_INT_ENABLE_SDEV_ADDED	= 0x40,
-	NV_INT_ENABLE_SDEV_REMOVED	= 0x80,
 
+	/* INT_STATUS/ENABLE bits */
+	NV_INT_DEV			= 0x01,
+	NV_INT_PM			= 0x02,
+	NV_INT_ADDED			= 0x04,
+	NV_INT_REMOVED			= 0x08,
+
+	NV_INT_PORT_SHIFT		= 4,	/* each port occupies 4 bits */
+
+	/* INT_CONFIG */
 	NV_INT_CONFIG			= 0x12,
 	NV_INT_CONFIG_METHD		= 0x01, // 0 = INT, 1 = SMI
 
@@ -94,7 +87,7 @@ enum nv_host_type
 {
 	GENERIC,
 	NFORCE2,
-	NFORCE3,
+	NFORCE3 = NFORCE2,	/* NF2 == NF3 as far as sata_nv is concerned */
 	CK804
 };
 
-- 
1.3.2


