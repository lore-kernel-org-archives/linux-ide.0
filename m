From: Brian King <brking@us.ibm.com>
Subject: [PATCH 3/3] libata: Remove dependence on host_set->dev for SAS
Date: Thu, 23 Mar 2006 17:30:15 -0600
Message-ID: <200603232330.k2NNUFu7003979@d01av04.pok.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:57815 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932558AbWCWXaW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2006 18:30:22 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2NNULul022976
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:30:21 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2NNUGYw220130
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:30:16 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2NNUFdw004003
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:30:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


Remove some of the dependence on the host_set struct
in preparation for supporting SAS HBAs. Adds a struct device
pointer to the ata_port struct.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/scsi/libata-core.c |   13 +++++++------
 libata-dev-bjking1/include/linux/libata.h     |    1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff -puN include/linux/libata.h~libata_host_set_dev include/linux/libata.h
--- libata-dev/include/linux/libata.h~libata_host_set_dev	2006-03-23 17:12:41.000000000 -0600
+++ libata-dev-bjking1/include/linux/libata.h	2006-03-23 17:12:41.000000000 -0600
@@ -395,6 +395,7 @@ struct ata_port {
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
+	struct device 		*dev;
 
 	struct work_struct	port_task;
 
diff -puN drivers/scsi/libata-core.c~libata_host_set_dev drivers/scsi/libata-core.c
--- libata-dev/drivers/scsi/libata-core.c~libata_host_set_dev	2006-03-23 17:12:41.000000000 -0600
+++ libata-dev-bjking1/drivers/scsi/libata-core.c	2006-03-23 17:12:41.000000000 -0600
@@ -2775,7 +2775,7 @@ static void ata_sg_clean(struct ata_queu
 
 	if (qc->flags & ATA_QCFLAG_SG) {
 		if (qc->n_elem)
-			dma_unmap_sg(ap->host_set->dev, sg, qc->n_elem, dir);
+			dma_unmap_sg(ap->dev, sg, qc->n_elem, dir);
 		/* restore last sg */
 		sg[qc->orig_n_elem - 1].length += qc->pad_len;
 		if (pad_buf) {
@@ -2786,7 +2786,7 @@ static void ata_sg_clean(struct ata_queu
 		}
 	} else {
 		if (qc->n_elem)
-			dma_unmap_single(ap->host_set->dev,
+			dma_unmap_single(ap->dev,
 				sg_dma_address(&sg[0]), sg_dma_len(&sg[0]),
 				dir);
 		/* restore sg */
@@ -2997,7 +2997,7 @@ static int ata_sg_setup_one(struct ata_q
 		goto skip_map;
 	}
 
-	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
+	dma_address = dma_map_single(ap->dev, qc->buf_virt,
 				     sg->length, dir);
 	if (dma_mapping_error(dma_address)) {
 		/* restore sg */
@@ -3085,7 +3085,7 @@ static int ata_sg_setup(struct ata_queue
 	}
 
 	dir = qc->dma_dir;
-	n_elem = dma_map_sg(ap->host_set->dev, sg, pre_n_elem, dir);
+	n_elem = dma_map_sg(ap->dev, sg, pre_n_elem, dir);
 	if (n_elem < 1) {
 		/* restore last sg */
 		lsg->length += qc->pad_len;
@@ -4299,7 +4299,7 @@ int ata_device_suspend(struct ata_port *
 
 int ata_port_start (struct ata_port *ap)
 {
-	struct device *dev = ap->host_set->dev;
+	struct device *dev = ap->dev;
 	int rc;
 
 	ap->prd = dma_alloc_coherent(dev, ATA_PRD_TBL_SZ, &ap->prd_dma, GFP_KERNEL);
@@ -4332,7 +4332,7 @@ int ata_port_start (struct ata_port *ap)
 
 void ata_port_stop (struct ata_port *ap)
 {
-	struct device *dev = ap->host_set->dev;
+	struct device *dev = ap->dev;
 
 	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 	ata_pad_free(ap, dev);
@@ -4398,6 +4398,7 @@ static void ata_host_init(struct ata_por
 	ap->host = host;
 	ap->ctl = ATA_DEVCTL_OBS;
 	ap->host_set = host_set;
+	ap->dev = ent->dev;
 	ap->port_no = port_no;
 	ap->hard_port_no =
 		ent->legacy_mode ? ent->hard_port_no : port_no;
_
