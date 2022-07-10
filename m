Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A81C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 10 Jul 2022 05:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGJFYO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 10 Jul 2022 01:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiGJFYN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jul 2022 01:24:13 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Jul 2022 22:24:09 PDT
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19162DEB4
        for <linux-ide@vger.kernel.org>; Sat,  9 Jul 2022 22:24:08 -0700 (PDT)
X-QQ-mid: bizesmtp70t1657430532tp5o2ad8
Received: from localhost.localdomain ( [182.148.15.109])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 10 Jul 2022 13:22:10 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000C00A0000000
X-QQ-FEAT: ZV0TXTFgbZrkC9xy9YkeyHYe7Dkfq+HIAAQqzTuyxcEOLTITMxy8Cu8G9tjc2
        qyD5opLZJ5FMpsDwdyB11FEMPX7//J0Tw9dJrbIbuuCjbmj1PNz+W/g6yIjHbC3wWj4cpXD
        yy7EgxbF19jEqeVQ0nUSFF4AvLWjuZFB2e07pAo2+sJeGa3ubLPsJ6Fo4+Q8CXfbOH0fZVP
        hWCyipsVu7D9nw81GB7RaiTpEPtkq6kha49UFMcONtFs4dJgszHQ6nAvzBtWxXTZXoUp5gM
        13n9zjggWbMSuUVOIQGCAmfbo9PNSuVTkoKW1Xv4lTgss3fARHByiHggw9TqAYJoF+Q3W9K
        +jXpMlb01Hn2OD4AnG7FYFPyuuL5u7ykGurjbkl1F4h6cxMmNpr0eR6swOu2Q==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/ata: fix repeated words in comments
Date:   Sun, 10 Jul 2022 13:22:03 +0800
Message-Id: <20220710052203.12349-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

 Delete the redundant word 'in'.
 Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/ata/libata-eh.c        | 2 +-
 drivers/ata/libata-transport.c | 2 +-
 drivers/ata/pata_macio.c       | 2 +-
 drivers/ata/sata_dwc_460ex.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3307ed45fe4d..f2ac8340e769 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -863,7 +863,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
  *
  *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
  *	is non-zero and EH wasn't pending before.  Fast drain ensures
- *	that EH kicks in in timely manner.
+ *	that EH kicks in timely manner.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index ca129854a88c..3a71107169ae 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -9,7 +9,7 @@
  * and various sysfs attributes to expose these topologies and management
  * interfaces to user-space.
  *
- * There are 3 objects defined in in this class:
+ * There are 3 objects defined in this class:
  * - ata_port
  * - ata_link
  * - ata_device
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 42798402cf63..e7b03e8a9357 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -666,7 +666,7 @@ static u8 pata_macio_bmdma_status(struct ata_port *ap)
 	 * a multi-block transfer.
 	 *
 	 * - The dbdma fifo hasn't yet finished flushing to
-	 * to system memory when the disk interrupt occurs.
+	 * system memory when the disk interrupt occurs.
 	 *
 	 */
 
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e3263e961045..a4c83a6e5631 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1087,7 +1087,7 @@ static struct scsi_host_template sata_dwc_sht = {
 	/*
 	 * test-only: Currently this driver doesn't handle NCQ
 	 * correctly. We enable NCQ but set the queue depth to a
-	 * max of 1. This will get fixed in in a future release.
+	 * max of 1. This will get fixed in a future release.
 	 */
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	/* .can_queue		= ATA_MAX_QUEUE, */
-- 
2.36.1

