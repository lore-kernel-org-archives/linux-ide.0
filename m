From: Jeff Garzik <jgarzik@pobox.com>
Subject: [git patches] 2.6.x libata fix
Date: Sat, 5 Nov 2005 14:51:19 -0500
Message-ID: <20051105195119.GA1039@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932312AbVKETvV@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following fix:

 drivers/scsi/libata-core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

Tejun Heo:
      [libata] restore sg on DMA mapping failure

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e1346cd..1c1a7ca 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2622,8 +2622,11 @@ static int ata_sg_setup_one(struct ata_q
 
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
 				     sg->length, dir);
-	if (dma_mapping_error(dma_address))
+	if (dma_mapping_error(dma_address)) {
+		/* restore sg */
+		sg->length += qc->pad_len;
 		return -1;
+	}
 
 	sg_dma_address(sg) = dma_address;
 	sg_dma_len(sg) = sg->length;
@@ -2694,8 +2697,11 @@ static int ata_sg_setup(struct ata_queue
 
 	dir = qc->dma_dir;
 	n_elem = dma_map_sg(ap->host_set->dev, sg, qc->n_elem, dir);
-	if (n_elem < 1)
+	if (n_elem < 1) {
+		/* restore last sg */
+		lsg->length += qc->pad_len;
 		return -1;
+	}
 
 	DPRINTK("%d sg elements mapped\n", n_elem);
 
