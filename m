Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2426DC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jun 2022 19:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350056AbiFOTii (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349696AbiFOTi2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 15:38:28 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B2C546B2
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 12:38:24 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 224D320F22F4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v2 2/2] ata: libata-core: fix sloppy parameter type in ata_exec_internal[_sg]()
Date:   Wed, 15 Jun 2022 22:38:21 +0300
Message-ID: <20220615193821.9235-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220615193821.9235-1-s.shtylyov@omp.ru>
References: <20220615193821.9235-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1902.lancloud.ru (fd00:f066::72)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Make the 'timeout' parameter to ata_exec_internal_sg() *unsigned int* as
msecs_to_jiffies() that it calls takes just *unsigned int* for the time in
milliseconds. Then follow the suit with ata_exec_internal(), its only
caller; also fix up ata_dev_set_feature(), the only ata_exec_internal()'s
caller  that explicitly passes *unsigned long* variable for timeout...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Changes in version 2:
- rebased atop of the new patch #1.

 drivers/ata/libata-core.c | 6 +++---
 drivers/ata/libata.h      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3cc1312a2622..03a08d1e666a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1470,7 +1470,7 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 static unsigned ata_exec_internal_sg(struct ata_device *dev,
 				     struct ata_taskfile *tf, const u8 *cdb,
 				     int dma_dir, struct scatterlist *sgl,
-				     unsigned int n_elem, unsigned long timeout)
+				     unsigned int n_elem, unsigned int timeout)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
@@ -1645,7 +1645,7 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen,
-			   unsigned long timeout)
+			   unsigned int timeout)
 {
 	struct scatterlist *psg = NULL, sg;
 	unsigned int n_elem = 0;
@@ -4342,7 +4342,7 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
-	unsigned long timeout = 0;
+	unsigned int timeout = 0;
 
 	/* set up set-features taskfile */
 	ata_dev_dbg(dev, "set features - SATA features\n");
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 1446a482835d..8292d4cdc22b 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -52,7 +52,7 @@ extern u64 ata_tf_read_block(const struct ata_taskfile *tf,
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen,
-				  unsigned long timeout);
+				  unsigned int timeout);
 extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 			  int (*check_ready)(struct ata_link *link));
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-- 
2.26.3
