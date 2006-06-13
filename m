From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/7] sata_nv: simplify interrupt constants
Date: Wed, 14 Jun 2006 06:31:03 +0900
Message-ID: <11502342632169-git-send-email-htejun@gmail.com>
References: <11502342632913-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:36805 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932309AbWFMVbH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 17:31:07 -0400
Received: by wr-out-0506.google.com with SMTP id 67so134788wri
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 14:31:06 -0700 (PDT)
In-Reply-To: <11502342632913-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Simplify interrupt constants.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)

fde0e7bc19e463c9c1eb2f331ea9744388752c59
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index ee674dd..f370044 100644
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
 
-- 
1.3.2


