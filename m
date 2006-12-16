From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: implement max_segment_size
Date: Sat, 16 Dec 2006 19:48:44 +0900
Message-ID: <20061216104844.GD5400@htj.dyndns.org>
References: <20061216104805.GC5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:12760 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965421AbWLPKs6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 05:48:58 -0500
Received: by wx-out-0506.google.com with SMTP id h27so905632wxd
        for <linux-ide@vger.kernel.org>; Sat, 16 Dec 2006 02:48:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061216104805.GC5400@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, alan@lxorguk.ukuu.org.uk, matthias@urlichs.de, romieu@fr.zoreil.com

libata depeneded on sht->dma_boundary for demtermining maximum segment
size.  This is good enough for most controllers but inic1622 just had
to be different and it locks up if segement size is 65536 while
dma_boundary is 0xffff.

This patch implements ap->max_segment_size which can be initialized
via probe_ent (or port_info) and used in ->slave_config to configure
maximum segment size.  LLDs without braindamage can leave this alone.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 +++
 drivers/ata/libata-scsi.c |    9 +++++++++
 include/linux/libata.h    |    3 +++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a496d0..b28a313 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5620,12 +5620,14 @@ void ata_port_init(struct ata_port *ap, struct ata_host *host,
 		ap->pio_mask = ent->pinfo2->pio_mask;
 		ap->mwdma_mask = ent->pinfo2->mwdma_mask;
 		ap->udma_mask = ent->pinfo2->udma_mask;
+		ap->max_segment_size = ent->max_segment_size;
 		ap->flags |= ent->pinfo2->flags;
 		ap->ops = ent->pinfo2->port_ops;
 	} else {
 		ap->pio_mask = ent->pio_mask;
 		ap->mwdma_mask = ent->mwdma_mask;
 		ap->udma_mask = ent->udma_mask;
+		ap->max_segment_size = ent->max_segment_size;
 		ap->flags |= ent->port_flags;
 		ap->ops = ent->port_ops;
 	}
@@ -6110,6 +6112,7 @@ ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
 	probe_ent->pio_mask = port->pio_mask;
 	probe_ent->mwdma_mask = port->mwdma_mask;
 	probe_ent->udma_mask = port->udma_mask;
+	probe_ent->max_segment_size = port->max_segment_size;
 	probe_ent->port_ops = port->port_ops;
 	probe_ent->private_data = port->private_data;
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e8a352d..f817d13 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -823,6 +823,15 @@ static void ata_scsi_dev_config(struct scsi_device *sdev,
 		depth = min(ATA_MAX_QUEUE - 1, depth);
 		scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, depth);
 	}
+
+	/* max_segment_size setting is usually not necessary as it's
+	 * automatically determined from sht->dma_boundary, but some
+	 * controllers need smaller max_segement_size than the value
+	 * determined by sht->dma_boundary.
+	 */
+	if (dev->ap->max_segment_size)
+		blk_queue_max_segment_size(sdev->request_queue,
+					   dev->ap->max_segment_size);
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b7c86b4..bdf7fc5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -379,6 +379,7 @@ struct ata_probe_ent {
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
+	size_t			max_segment_size;	/* optional */
 	unsigned long		irq;
 	unsigned long		irq2;
 	unsigned int		irq_flags;
@@ -550,6 +551,7 @@ struct ata_port {
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
+	size_t			max_segment_size; /* optional */
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
@@ -658,6 +660,7 @@ struct ata_port_info {
 	unsigned long		pio_mask;
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
+	size_t			max_segment_size;	/* optional */
 	const struct ata_port_operations *port_ops;
 	void 			*private_data;
 };
-- 
1.4.4.2

