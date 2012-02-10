From: Cong Wang <amwang@redhat.com>
Subject: [PATCH 10/60] ata: remove the second argument of k[un]map_atomic()
Date: Fri, 10 Feb 2012 13:39:31 +0800
Message-ID: <1328852421-19678-11-git-send-email-amwang@redhat.com>
References: <1328852421-19678-1-git-send-email-amwang@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328852421-19678-1-git-send-email-amwang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Cong Wang <amwang@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Acked-by: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Cong Wang <amwang@redhat.com>
---
 drivers/ata/libata-sff.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9691dd0..d8af325 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -720,13 +720,13 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 
 		/* FIXME: use a bounce buffer */
 		local_irq_save(flags);
-		buf = kmap_atomic(page, KM_IRQ0);
+		buf = kmap_atomic(page);
 
 		/* do the actual data transfer */
 		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
 				       do_write);
 
-		kunmap_atomic(buf, KM_IRQ0);
+		kunmap_atomic(buf);
 		local_irq_restore(flags);
 	} else {
 		buf = page_address(page);
@@ -865,13 +865,13 @@ next_sg:
 
 		/* FIXME: use bounce buffer */
 		local_irq_save(flags);
-		buf = kmap_atomic(page, KM_IRQ0);
+		buf = kmap_atomic(page);
 
 		/* do the actual data transfer */
 		consumed = ap->ops->sff_data_xfer(dev,  buf + offset,
 								count, rw);
 
-		kunmap_atomic(buf, KM_IRQ0);
+		kunmap_atomic(buf);
 		local_irq_restore(flags);
 	} else {
 		buf = page_address(page);
-- 
1.7.7.6
