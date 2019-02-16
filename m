From: Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ata: fix a race condition when internal cmd time out
Date: Sat, 16 Feb 2019 11:42:57 +0800
Message-ID: <20190216034257.30226-1-yanaijie@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>
List-Id: linux-ide@vger.kernel.org

For internal cmds, we will unmap DMA memory associated with the cmd
before we abort the cmd. If DMA transfering data before the aborting,
bus error will occured.

ata_exec_internal_sg
  ->ata_port_freeze if timeout
    ->ata_qc_complete
      ->ata_sg_clean
                                      dma transfering data = bus error
  ->ap->ops->post_internal_cmd
    ->sas_ata_post_internal
      ->sas_ata_internal_abort
        ->abort the cmd

Fix this by move post_internal_cmd() before unmapping the DMA memory
when time out. Notice that we have to set ATA_QCFLAG_FAILED flag before
calling post_internal_cmd() so that the aborting will work.

Reported-by: luojian <luojian5@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/ata/libata-core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index adf28788cab5..d0ff5711e805 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1665,6 +1665,13 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 		 */
 		if (qc->flags & ATA_QCFLAG_ACTIVE) {
 			qc->err_mask |= AC_ERR_TIMEOUT;
+			qc->flags |= ATA_QCFLAG_FAILED;
+
+			spin_unlock_irqrestore(ap->lock, flags);
+			/* do post_internal_cmd */
+			if (ap->ops->post_internal_cmd)
+				ap->ops->post_internal_cmd(qc);
+			spin_lock_irqsave(ap->lock, flags);
 
 			if (ap->ops->error_handler)
 				ata_port_freeze(ap);
@@ -1679,9 +1686,10 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 		spin_unlock_irqrestore(ap->lock, flags);
 	}
 
-	/* do post_internal_cmd */
-	if (ap->ops->post_internal_cmd)
-		ap->ops->post_internal_cmd(qc);
+	if (!(qc->err_mask & AC_ERR_TIMEOUT))
+		/* do post_internal_cmd */
+		if (ap->ops->post_internal_cmd)
+			ap->ops->post_internal_cmd(qc);
 
 	/* perform minimal error analysis */
 	if (qc->flags & ATA_QCFLAG_FAILED) {
-- 
2.14.4
