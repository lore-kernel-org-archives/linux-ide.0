Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FDACCA473
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jun 2022 19:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiFOTij (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349680AbiFOTi2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 15:38:28 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2566546B1
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 12:38:24 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru D4F5F20C2B71
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v2 1/2] ata: libata-core: make ata_exec_internal_sg() *static*
Date:   Wed, 15 Jun 2022 22:38:20 +0300
Message-ID: <20220615193821.9235-2-s.shtylyov@omp.ru>
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

ata_exec_internal_sg() is only called by ata_exec_internal() further in
the same file, so we can make it *static* and remove its prototype from
drivers/ata/libata.h...

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Changes in version 2:
- new patch.

 drivers/ata/libata-core.c | 8 ++++----
 drivers/ata/libata.h      | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 980328a4b896..3cc1312a2622 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1467,10 +1467,10 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	Zero on success, AC_ERR_* mask on failure
  */
-unsigned ata_exec_internal_sg(struct ata_device *dev,
-			      struct ata_taskfile *tf, const u8 *cdb,
-			      int dma_dir, struct scatterlist *sgl,
-			      unsigned int n_elem, unsigned long timeout)
+static unsigned ata_exec_internal_sg(struct ata_device *dev,
+				     struct ata_taskfile *tf, const u8 *cdb,
+				     int dma_dir, struct scatterlist *sgl,
+				     unsigned int n_elem, unsigned long timeout)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 926a7f41303d..1446a482835d 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -53,10 +53,6 @@ extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen,
 				  unsigned long timeout);
-extern unsigned ata_exec_internal_sg(struct ata_device *dev,
-				     struct ata_taskfile *tf, const u8 *cdb,
-				     int dma_dir, struct scatterlist *sg,
-				     unsigned int n_elem, unsigned long timeout);
 extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 			  int (*check_ready)(struct ata_link *link));
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-- 
2.26.3
