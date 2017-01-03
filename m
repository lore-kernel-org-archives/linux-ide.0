From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/6] libata: Make ata_sg_clean() static again
Date: Tue,  3 Jan 2017 19:09:48 +0100
Message-ID: <1483466989-9091-6-git-send-email-geert@linux-m68k.org>
References: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:35004 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760139AbdACSKa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2017 13:10:30 -0500
In-Reply-To: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Commit 70e6ad0c6d1e6cb9 ("[PATCH] libata: prepare ata_sg_clean() for
invocation from EH") made ata_sg_clean() global, but no user outside
libata-core.c has ever materialized.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ata/libata-core.c | 2 +-
 drivers/ata/libata.h      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9cd0a2d4181699d9..a7e3df5abaa3124f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4822,7 +4822,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_sg_clean(struct ata_queued_cmd *qc)
+static void ata_sg_clean(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg = qc->sg;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 8f3a5596dd676b95..1133e9439f9c537e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -89,7 +89,6 @@ extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 enable, u8 feature);
-extern void ata_sg_clean(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-- 
1.9.1

