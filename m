From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] libata: replace strict_strtol() with kstrtol()
Date: Fri, 19 Jul 2013 15:56:41 +0900
Message-ID: <000901ce844d$1fa1aac0$5ee50040$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44034 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab3GSG4n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jul 2013 02:56:43 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQ60032C8MG3LL0@mailout2.samsung.com> for
 linux-ide@vger.kernel.org; Fri, 19 Jul 2013 15:56:42 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

The usage of strict_strtol() is not preferred, because
strict_strtol() is obsolete. Thus, kstrtol() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/libata-scsi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 83c0890..b1e880a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -206,8 +206,10 @@ static ssize_t ata_scsi_park_store(struct device *device,
 	unsigned long flags;
 	int rc;
 
-	rc = strict_strtol(buf, 10, &input);
-	if (rc || input < -2)
+	rc = kstrtol(buf, 10, &input);
+	if (rc)
+		return rc;
+	if (input < -2)
 		return -EINVAL;
 	if (input > ATA_TMOUT_MAX_PARK) {
 		rc = -EOVERFLOW;
-- 
1.7.10.4


