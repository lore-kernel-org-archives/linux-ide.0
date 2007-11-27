From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/13] libata: implement ATAPI drain buffer
Date: Wed, 28 Nov 2007 00:13:57 +0900
Message-ID: <11961764414036-git-send-email-htejun@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.178]:54869 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232AbXK0POR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:14:17 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1688062roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 07:14:16 -0800 (PST)
In-Reply-To: <11961764391983-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

Misc ATAPI commands may try to transfer more bytes than requested.
For PIO which is performed by libata HSM, this is worked around by
draining extra bytes from __atapi_pio_bytes().

This patch implements drain buffer to perform draining for DMA and
PIO-over-DMA cases.  One page is allocated w/ GFP_DMA32 during libata
core layer initialization.  On host registration, this drain page is
DMA mapped and ATAPI_MAX_DRAIN_PAGES sg entries are reserved.

ata_sg_setup_extra() uses these extra sg entries to map the drain page
ATAPI_MAX_DRAIN_PAGES times, extending sg list by ATAPI_MAX_DRAIN
bytes.  This allows both DMA and PIO-over-DMA misc ATAPI commands to
overflow by ATAPI_MAX_DRAIN bytes just like PIO commands.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |  139 ++++++++++++++++++++++++++++++++++++++------
 drivers/ata/libata-scsi.c |   14 +++-
 include/linux/libata.h    |    4 +-
 3 files changed, 133 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 148a11e..a7789d5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -83,8 +83,8 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
 unsigned int ata_print_id = 1;
 static struct workqueue_struct *ata_wq;
-
 struct workqueue_struct *ata_aux_wq;
+static void *ata_drain_page;
 
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
@@ -4756,6 +4756,60 @@ void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 	qc->cursg = qc->sg;
 }
 
+/**
+ *	ata_sg_setup_extra - Setup extra sg entries
+ *	@qc: Command to setup extra sg entries for
+ *	@n_elem_extra: Out parameter for the number of extra sg entries
+ *	@nbytes_extra: Out parameter for the number of extra bytes
+ *
+ *	Extra sg entries are used to deal with ATAPI peculiarities.
+ *	First, the content to be transferred can be of any size but
+ *	transfer length should be aligned to 4 bytes, so if data size
+ *	isn't aligned, it needs to be padded.
+ *
+ *	Second, for commands whose repsonse can be variable, due to
+ *	userland bugs (more likely) and hardware bugs, devices can try
+ *	to transfer more bytes than requested.  This can be worked
+ *	around by appending drain buffers at the end.
+ *
+ *	This function sets up both padding and draining sg entries.
+ *	For this purpose, each qc has 2 + ATAPI_MAX_DRAIN_PAGES extra
+ *	sg entries.  Each extra sg has assigned function.
+ *
+ *	   e[0]  |   e[1]  |   e[2]  | ... | e[2 + ATAPI_MAX_DRAIN_PAGES - 1]
+ *	----------------------------------------------------------------------
+ *	   link  | padding | draining  ...
+ *		   or link
+ *
+ *	After sg setup is complete, sg list looks like the following.
+ *
+ *	1. Padding necessary, padding doesn't replace the last sg
+ *
+ *	o[0][1][2]...[last]   e[0][1]([2]... if draining is necessary)
+ *	               |        ^
+ *                      \------/
+ *	   e[0] carries the original content of o[last].
+ *
+ *	2. Padding necessary, padding replaces the last sg
+ *
+ *	o[0][1][2]...[last]   e[0][1]([2]... if draining is necessary)
+ *	               |           ^
+ *                      \---------/
+ *	   e[1] completely includes what o[last] used to point to.
+ *
+ *	3. Only draining is necessary.
+ *
+ *	[0][1][2]...[last]   e[0][1][2]...
+ *	              |           ^
+ *                     \---------/
+ *	   e[1] carries the original conetent of o[last].
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	Adjusted n_elem which should be mapped.
+ */
 static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
 				       unsigned int *n_elem_extra,
 				       unsigned int *nbytes_extra)
@@ -4763,6 +4817,7 @@ static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
 	struct ata_port *ap = qc->ap;
 	unsigned int n_elem = qc->n_elem;
 	struct scatterlist *lsg, *copy_lsg = NULL, *tsg = NULL, *esg = NULL;
+	int drain;
 
 	*n_elem_extra = 0;
 	*nbytes_extra = 0;
@@ -4770,7 +4825,10 @@ static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
 	/* needs padding? */
 	qc->pad_len = qc->nbytes & 3;
 
-	if (likely(!qc->pad_len))
+	/* needs drain? */
+	drain = atapi_qc_may_overflow(qc);
+
+	if (likely(!qc->pad_len && !drain))
 		return n_elem;
 
 	/* locate last sg and save it */
@@ -4832,6 +4890,29 @@ static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
 		(*nbytes_extra) += 4 - qc->pad_len;
 	}
 
+	if (drain) {
+		struct scatterlist *dsg = qc->extra_sg + 2;
+		int i;
+
+		for (i = 0; i < ATAPI_MAX_DRAIN_PAGES; i++) {
+			sg_set_page(dsg, virt_to_page(ata_drain_page),
+				    PAGE_SIZE, 0);
+			sg_dma_address(dsg) = ap->host->drain_page_dma;
+			sg_dma_len(dsg) = PAGE_SIZE;
+			dsg++;
+		}
+
+		if (!tsg) {
+			copy_lsg = &qc->extra_sg[1];
+			tsg = &qc->extra_sg[1];
+		}
+
+		esg = dsg - 1;
+
+		(*n_elem_extra) += ATAPI_MAX_DRAIN_PAGES;
+		(*nbytes_extra) += ATAPI_MAX_DRAIN_PAGES * PAGE_SIZE;
+	}
+
 	if (copy_lsg)
 		sg_set_page(copy_lsg, sg_page(lsg), lsg->length, lsg->offset);
 
@@ -6862,6 +6943,9 @@ static void ata_host_stop(struct device *gendev, void *res)
 			ap->ops->port_stop(ap);
 	}
 
+	dma_unmap_single(host->dev, host->drain_page_dma, PAGE_SIZE,
+			 DMA_FROM_DEVICE);
+
 	if (host->ops->host_stop)
 		host->ops->host_stop(host);
 }
@@ -6884,8 +6968,8 @@ static void ata_host_stop(struct device *gendev, void *res)
  */
 int ata_host_start(struct ata_host *host)
 {
-	int have_stop = 0;
 	void *start_dr = NULL;
+	dma_addr_t dma;
 	int i, rc;
 
 	if (host->flags & ATA_HOST_STARTED)
@@ -6896,20 +6980,23 @@ int ata_host_start(struct ata_host *host)
 
 		if (!host->ops && !ata_port_is_dummy(ap))
 			host->ops = ap->ops;
-
-		if (ap->ops->port_stop)
-			have_stop = 1;
 	}
 
-	if (host->ops->host_stop)
-		have_stop = 1;
+	start_dr = devres_alloc(ata_host_stop, 0, GFP_KERNEL);
+	if (!start_dr)
+		return -ENOMEM;
 
-	if (have_stop) {
-		start_dr = devres_alloc(ata_host_stop, 0, GFP_KERNEL);
-		if (!start_dr)
-			return -ENOMEM;
+	/* map drain page */
+	dma = dma_map_single(host->dev, ata_drain_page, PAGE_SIZE,
+			     DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma)) {
+		dev_printk(KERN_ERR, host->dev, "failed to map drain page\n");
+		rc = -ENOMEM;
+		goto err_map;
 	}
+	host->drain_page_dma = dma;
 
+	/* start ports */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
@@ -6918,7 +7005,7 @@ int ata_host_start(struct ata_host *host)
 			if (rc) {
 				ata_port_printk(ap, KERN_ERR, "failed to "
 						"start port (errno=%d)\n", rc);
-				goto err_out;
+				goto err_start;
 			}
 		}
 
@@ -6930,13 +7017,16 @@ int ata_host_start(struct ata_host *host)
 	host->flags |= ATA_HOST_STARTED;
 	return 0;
 
- err_out:
+ err_start:
 	while (--i >= 0) {
 		struct ata_port *ap = host->ports[i];
 
 		if (ap->ops->port_stop)
 			ap->ops->port_stop(ap);
 	}
+ err_map:
+	dma_unmap_single(host->dev, host->drain_page_dma, PAGE_SIZE,
+			 DMA_FROM_DEVICE);
 	devres_free(start_dr);
 	return rc;
 }
@@ -7361,24 +7451,35 @@ int ata_pci_device_resume(struct pci_dev *pdev)
 static int __init ata_init(void)
 {
 	ata_probe_timeout *= HZ;
+
+	ata_drain_page = (void *)__get_free_page(GFP_DMA32);
+	if (!ata_drain_page)
+		goto err_drain_page;
+
 	ata_wq = create_workqueue("ata");
 	if (!ata_wq)
-		return -ENOMEM;
+		goto err_ata_wq;
 
 	ata_aux_wq = create_singlethread_workqueue("ata_aux");
-	if (!ata_aux_wq) {
-		destroy_workqueue(ata_wq);
-		return -ENOMEM;
-	}
+	if (!ata_aux_wq)
+		goto err_ata_aux_wq;
 
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
+
+ err_ata_aux_wq:
+	destroy_workqueue(ata_wq);
+ err_ata_wq:
+	free_page((unsigned long)ata_drain_page);
+ err_drain_page:
+	return -ENOMEM;
 }
 
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
 	destroy_workqueue(ata_aux_wq);
+	free_page((unsigned long)ata_drain_page);
 }
 
 subsys_initcall(ata_init);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f523e66..f07704c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -832,13 +832,19 @@ static void ata_scsi_dev_config(struct scsi_device *sdev,
 	/* configure max sectors */
 	blk_queue_max_sectors(sdev->request_queue, dev->max_sectors);
 
-	/* SATA DMA transfers must be multiples of 4 byte, so
-	 * we need to pad ATAPI transfers using an extra sg.
-	 * Decrement max hw segments accordingly.
+	/* SATA DMA transfers must be multiples of 4 byte, so we need
+	 * to pad ATAPI transfers using an extra sg.  Also, ATAPI
+	 * commands with variable length reponse needs draining of
+	 * extra data.  Decrement max hw segments accordingly.
 	 */
 	if (dev->class == ATA_DEV_ATAPI) {
 		struct request_queue *q = sdev->request_queue;
-		blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
+		unsigned short hw_segments = q->max_hw_segments;
+
+		BUG_ON(hw_segments <= 1 + ATAPI_MAX_DRAIN_PAGES);
+		hw_segments -= 1 + ATAPI_MAX_DRAIN_PAGES;
+
+		blk_queue_max_hw_segments(q, hw_segments);
 	}
 
 	if (dev->flags & ATA_DFLAG_AN)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 62af1eb..02ab12b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -121,6 +121,7 @@ enum {
 	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,
 
 	ATAPI_MAX_DRAIN		= 16 << 10,
+	ATAPI_MAX_DRAIN_PAGES	= ATAPI_MAX_DRAIN >> PAGE_SHIFT,
 
 	ATA_SHT_EMULATED	= 1,
 	ATA_SHT_CMD_PER_LUN	= 1,
@@ -438,6 +439,7 @@ struct ata_host {
 	void			*private_data;
 	const struct ata_port_operations *ops;
 	unsigned long		flags;
+	dma_addr_t		drain_page_dma;
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
 #endif
@@ -476,7 +478,7 @@ struct ata_queued_cmd {
 	struct scatterlist	*last_sg;
 	struct scatterlist	saved_last_sg;
 	struct scatterlist	sgent;
-	struct scatterlist	extra_sg[2];
+	struct scatterlist	extra_sg[2 + ATAPI_MAX_DRAIN_PAGES];
 
 	struct scatterlist	*sg;
 
-- 
1.5.2.4

