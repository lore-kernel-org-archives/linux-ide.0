From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix SCSI/ATA device association during hotplug, take 2
Date: Tue, 12 Dec 2006 13:24:31 +0900
Message-ID: <20061212042431.GD18947@htj.dyndns.org>
References: <20061120092534.GP2184@htj.dyndns.org> <456C43BF.4060807@rtr.ca> <456C6E93.9040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:17927 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbWLLEYo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 23:24:44 -0500
Received: by an-out-0708.google.com with SMTP id b33so351513ana
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 20:24:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <456C6E93.9040203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Two subtle hotplug related bugs are found.

* SCSI didn't use to issue commands to devices in SDEV_CANCEL state
  but now it does.  For ATA devices, it means that SYNCHRONIZE_CACHE
  is issued even after libata tells SCSI midlayer that the SCSI device
  is offline now.  When devices are swapped, SYNCHRONIZE_CACHE for the
  previous device can be issued to the later device.

* Devices can be swapped while SCSI probing is in progress.  SCSI
  device used to get associated with ATA device only after probing is
  complete, which means that SCSI device detaching is not performed
  while probing.  This can result in mismatch between SCSI device and
  ATA device (e.g. sd attached to ATAPI device) if devices are
  swapped after INQUIRY but before probing is complete.

This patch makes libata associate new SCSI device with ATA device
before INQUIRY is issued and check whether SCSI device issuing a
command matches dev->sdev on each command.  Both bugs are fixed by
this tighter coupling between SCSI device and ATA device.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>
---

scsi_dev <-> ata_dev association is moved to ->slave_alloc as Mark
suggested.

 drivers/ata/ahci.c              |    1 
 drivers/ata/ata_generic.c       |    1 
 drivers/ata/ata_piix.c          |    1 
 drivers/ata/libata-core.c       |    1 
 drivers/ata/libata-scsi.c       |   71 +++++++++++++++++++++++++++++++++-------
 drivers/ata/pata_ali.c          |    1 
 drivers/ata/pata_amd.c          |    1 
 drivers/ata/pata_artop.c        |    1 
 drivers/ata/pata_atiixp.c       |    1 
 drivers/ata/pata_cmd64x.c       |    1 
 drivers/ata/pata_cs5520.c       |    1 
 drivers/ata/pata_cs5530.c       |    1 
 drivers/ata/pata_cs5535.c       |    1 
 drivers/ata/pata_cypress.c      |    1 
 drivers/ata/pata_efar.c         |    1 
 drivers/ata/pata_hpt366.c       |    1 
 drivers/ata/pata_hpt37x.c       |    1 
 drivers/ata/pata_hpt3x2n.c      |    1 
 drivers/ata/pata_hpt3x3.c       |    1 
 drivers/ata/pata_isapnp.c       |    1 
 drivers/ata/pata_it821x.c       |    1 
 drivers/ata/pata_ixp4xx_cf.c    |    1 
 drivers/ata/pata_jmicron.c      |    1 
 drivers/ata/pata_legacy.c       |    1 
 drivers/ata/pata_marvell.c      |    1 
 drivers/ata/pata_mpiix.c        |    1 
 drivers/ata/pata_netcell.c      |    1 
 drivers/ata/pata_ns87410.c      |    1 
 drivers/ata/pata_oldpiix.c      |    1 
 drivers/ata/pata_opti.c         |    1 
 drivers/ata/pata_optidma.c      |    1 
 drivers/ata/pata_pcmcia.c       |    1 
 drivers/ata/pata_pdc2027x.c     |    1 
 drivers/ata/pata_pdc202xx_old.c |    1 
 drivers/ata/pata_platform.c     |    1 
 drivers/ata/pata_qdi.c          |    1 
 drivers/ata/pata_radisys.c      |    1 
 drivers/ata/pata_rz1000.c       |    1 
 drivers/ata/pata_sc1200.c       |    1 
 drivers/ata/pata_serverworks.c  |    1 
 drivers/ata/pata_sil680.c       |    1 
 drivers/ata/pata_sis.c          |    1 
 drivers/ata/pata_sl82c105.c     |    1 
 drivers/ata/pata_triflex.c      |    1 
 drivers/ata/pata_via.c          |    1 
 drivers/ata/pata_winbond.c      |    1 
 drivers/ata/pdc_adma.c          |    1 
 drivers/ata/sata_mv.c           |    1 
 drivers/ata/sata_nv.c           |    1 
 drivers/ata/sata_promise.c      |    1 
 drivers/ata/sata_qstor.c        |    1 
 drivers/ata/sata_sil.c          |    1 
 drivers/ata/sata_sil24.c        |    1 
 drivers/ata/sata_sis.c          |    1 
 drivers/ata/sata_svw.c          |    1 
 drivers/ata/sata_sx4.c          |    1 
 drivers/ata/sata_uli.c          |    1 
 drivers/ata/sata_via.c          |    1 
 drivers/ata/sata_vsc.c          |    1 
 include/linux/libata.h          |    1 
 60 files changed, 118 insertions(+), 12 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -240,6 +240,7 @@ static struct scsi_host_template ahci_sh
 	.use_clustering		= AHCI_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/ata_generic.c
===================================================================
--- work.orig/drivers/ata/ata_generic.c
+++ work/drivers/ata/ata_generic.c
@@ -114,6 +114,7 @@ static struct scsi_host_template generic
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/ata_piix.c
===================================================================
--- work.orig/drivers/ata/ata_piix.c
+++ work/drivers/ata/ata_piix.c
@@ -260,6 +260,7 @@ static struct scsi_host_template piix_sh
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -6446,6 +6446,7 @@ EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
+EXPORT_SYMBOL_GPL(ata_scsi_slave_alloc);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -53,10 +53,11 @@
 
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
 
+static struct ata_device * ata_find_dev(struct ata_port *ap, int id);
 static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
-					const struct scsi_device *scsidev);
+					       struct scsi_device *scsidev);
 static struct ata_device * ata_scsi_find_dev(struct ata_port *ap,
-					    const struct scsi_device *scsidev);
+					     struct scsi_device *scsidev);
 static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, unsigned int lun);
 
@@ -826,6 +827,33 @@ static void ata_scsi_dev_config(struct s
 }
 
 /**
+ *	ata_scsi_slave_alloc - Associate new SCSI device with ATA device
+ *	@sdev: SCSI device to examine
+ *
+ *	This is called right after a sdev is allocated.  Associate it
+ *	with respective ATA device.
+ *
+ *	LOCKING:
+ *	Defined by SCSI layer.  We don't really care.
+ */
+int ata_scsi_slave_alloc(struct scsi_device *sdev)
+{
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *dev;
+
+	/* this shouldn't happen, make SCSI complain */
+	if (sdev->channel || sdev->lun)
+		return -EINVAL;
+
+	dev = ata_find_dev(ap, sdev->id);
+	if (dev->sdev != NULL)
+		return -EBUSY;
+	dev->sdev = sdev;
+
+	return 0;
+}
+
+/**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
  *
@@ -877,7 +905,7 @@ void ata_scsi_slave_destroy(struct scsi_
 
 	spin_lock_irqsave(ap->lock, flags);
 	dev = __ata_scsi_find_dev(ap, sdev);
-	if (dev && dev->sdev) {
+	if (dev) {
 		/* SCSI device already in CANCEL state, no need to offline it */
 		dev->sdev = NULL;
 		dev->flags |= ATA_DFLAG_DETACH;
@@ -2410,13 +2438,22 @@ static struct ata_device * ata_find_dev(
 }
 
 static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
-					const struct scsi_device *scsidev)
+					       struct scsi_device *scsidev)
 {
+	struct ata_device *dev;
+
 	/* skip commands not addressed to targets we simulate */
 	if (unlikely(scsidev->channel || scsidev->lun))
 		return NULL;
 
-	return ata_find_dev(ap, scsidev->id);
+	dev = ata_find_dev(ap, scsidev->id);
+
+	/* SCSI issues commands to off-line devices.  Make sure we're
+	 * looking at the right device.
+	 */
+	if (likely(dev && dev->sdev == scsidev))
+		return dev;
+	return NULL;
 }
 
 /**
@@ -2466,7 +2503,7 @@ static int ata_scsi_dev_enabled(struct a
  *	Associated ATA device, or %NULL if not found.
  */
 static struct ata_device *
-ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
+ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
 {
 	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
 
@@ -2865,16 +2902,26 @@ void ata_scsi_scan_host(struct ata_port 
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		struct scsi_device *sdev;
 
 		if (!ata_dev_enabled(dev) || dev->sdev)
 			continue;
 
-		sdev = __scsi_add_device(ap->scsi_host, 0, i, 0, NULL);
-		if (!IS_ERR(sdev)) {
-			dev->sdev = sdev;
-			scsi_device_put(sdev);
-		}
+		/* Try to attach new SCSI device.  SCSI midlayer
+		 * doesn't supply separate interfaces for allocating
+		 * and probing, so in this function, we can associate
+		 * new SCSI device with its target ATA device only
+		 * after probing is complete.
+		 *
+		 * However, hotplug event may occur during probing and
+		 * we might have to detach a SCSI device which is in
+		 * the middle of probing.  So, we need to associate
+		 * new SCSI device with its target ATA device before
+		 * the first INQUIRY is complete.
+		 *
+		 * This is achieved by attaching the device in
+		 * ->slave_alloc().
+		 */
+		scsi_add_device(ap->scsi_host, 0, i, 0);
 	}
 }
 
Index: work/drivers/ata/pata_ali.c
===================================================================
--- work.orig/drivers/ata/pata_ali.c
+++ work/drivers/ata/pata_ali.c
@@ -342,6 +342,7 @@ static struct scsi_host_template ali_sht
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_amd.c
===================================================================
--- work.orig/drivers/ata/pata_amd.c
+++ work/drivers/ata/pata_amd.c
@@ -331,6 +331,7 @@ static struct scsi_host_template amd_sht
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_artop.c
===================================================================
--- work.orig/drivers/ata/pata_artop.c
+++ work/drivers/ata/pata_artop.c
@@ -312,6 +312,7 @@ static struct scsi_host_template artop_s
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_atiixp.c
===================================================================
--- work.orig/drivers/ata/pata_atiixp.c
+++ work/drivers/ata/pata_atiixp.c
@@ -214,6 +214,7 @@ static struct scsi_host_template atiixp_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_cmd64x.c
===================================================================
--- work.orig/drivers/ata/pata_cmd64x.c
+++ work/drivers/ata/pata_cmd64x.c
@@ -273,6 +273,7 @@ static struct scsi_host_template cmd64x_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_cs5520.c
===================================================================
--- work.orig/drivers/ata/pata_cs5520.c
+++ work/drivers/ata/pata_cs5520.c
@@ -164,6 +164,7 @@ static struct scsi_host_template cs5520_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_cs5530.c
===================================================================
--- work.orig/drivers/ata/pata_cs5530.c
+++ work/drivers/ata/pata_cs5530.c
@@ -178,6 +178,7 @@ static struct scsi_host_template cs5530_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_cs5535.c
===================================================================
--- work.orig/drivers/ata/pata_cs5535.c
+++ work/drivers/ata/pata_cs5535.c
@@ -182,6 +182,7 @@ static struct scsi_host_template cs5535_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_cypress.c
===================================================================
--- work.orig/drivers/ata/pata_cypress.c
+++ work/drivers/ata/pata_cypress.c
@@ -133,6 +133,7 @@ static struct scsi_host_template cy82c69
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_efar.c
===================================================================
--- work.orig/drivers/ata/pata_efar.c
+++ work/drivers/ata/pata_efar.c
@@ -231,6 +231,7 @@ static struct scsi_host_template efar_sh
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -335,6 +335,7 @@ static struct scsi_host_template hpt36x_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_hpt37x.c
===================================================================
--- work.orig/drivers/ata/pata_hpt37x.c
+++ work/drivers/ata/pata_hpt37x.c
@@ -773,6 +773,7 @@ static struct scsi_host_template hpt37x_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_hpt3x2n.c
===================================================================
--- work.orig/drivers/ata/pata_hpt3x2n.c
+++ work/drivers/ata/pata_hpt3x2n.c
@@ -339,6 +339,7 @@ static struct scsi_host_template hpt3x2n
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_hpt3x3.c
===================================================================
--- work.orig/drivers/ata/pata_hpt3x3.c
+++ work/drivers/ata/pata_hpt3x3.c
@@ -116,6 +116,7 @@ static struct scsi_host_template hpt3x3_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_isapnp.c
===================================================================
--- work.orig/drivers/ata/pata_isapnp.c
+++ work/drivers/ata/pata_isapnp.c
@@ -32,6 +32,7 @@ static struct scsi_host_template isapnp_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_it821x.c
===================================================================
--- work.orig/drivers/ata/pata_it821x.c
+++ work/drivers/ata/pata_it821x.c
@@ -671,6 +671,7 @@ static struct scsi_host_template it821x_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_ixp4xx_cf.c
===================================================================
--- work.orig/drivers/ata/pata_ixp4xx_cf.c
+++ work/drivers/ata/pata_ixp4xx_cf.c
@@ -115,6 +115,7 @@ static struct scsi_host_template ixp4xx_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_jmicron.c
===================================================================
--- work.orig/drivers/ata/pata_jmicron.c
+++ work/drivers/ata/pata_jmicron.c
@@ -133,6 +133,7 @@ static struct scsi_host_template jmicron
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
Index: work/drivers/ata/pata_legacy.c
===================================================================
--- work.orig/drivers/ata/pata_legacy.c
+++ work/drivers/ata/pata_legacy.c
@@ -133,6 +133,7 @@ static struct scsi_host_template legacy_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_marvell.c
===================================================================
--- work.orig/drivers/ata/pata_marvell.c
+++ work/drivers/ata/pata_marvell.c
@@ -99,6 +99,7 @@ static struct scsi_host_template marvell
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
Index: work/drivers/ata/pata_mpiix.c
===================================================================
--- work.orig/drivers/ata/pata_mpiix.c
+++ work/drivers/ata/pata_mpiix.c
@@ -164,6 +164,7 @@ static struct scsi_host_template mpiix_s
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_netcell.c
===================================================================
--- work.orig/drivers/ata/pata_netcell.c
+++ work/drivers/ata/pata_netcell.c
@@ -59,6 +59,7 @@ static struct scsi_host_template netcell
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
Index: work/drivers/ata/pata_ns87410.c
===================================================================
--- work.orig/drivers/ata/pata_ns87410.c
+++ work/drivers/ata/pata_ns87410.c
@@ -154,6 +154,7 @@ static struct scsi_host_template ns87410
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_oldpiix.c
===================================================================
--- work.orig/drivers/ata/pata_oldpiix.c
+++ work/drivers/ata/pata_oldpiix.c
@@ -229,6 +229,7 @@ static struct scsi_host_template oldpiix
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_opti.c
===================================================================
--- work.orig/drivers/ata/pata_opti.c
+++ work/drivers/ata/pata_opti.c
@@ -176,6 +176,7 @@ static struct scsi_host_template opti_sh
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_optidma.c
===================================================================
--- work.orig/drivers/ata/pata_optidma.c
+++ work/drivers/ata/pata_optidma.c
@@ -357,6 +357,7 @@ static struct scsi_host_template optidma
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_pcmcia.c
===================================================================
--- work.orig/drivers/ata/pata_pcmcia.c
+++ work/drivers/ata/pata_pcmcia.c
@@ -67,6 +67,7 @@ static struct scsi_host_template pcmcia_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_pdc2027x.c
===================================================================
--- work.orig/drivers/ata/pata_pdc2027x.c
+++ work/drivers/ata/pata_pdc2027x.c
@@ -139,6 +139,7 @@ static struct scsi_host_template pdc2027
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_pdc202xx_old.c
===================================================================
--- work.orig/drivers/ata/pata_pdc202xx_old.c
+++ work/drivers/ata/pata_pdc202xx_old.c
@@ -267,6 +267,7 @@ static struct scsi_host_template pdc202x
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_platform.c
===================================================================
--- work.orig/drivers/ata/pata_platform.c
+++ work/drivers/ata/pata_platform.c
@@ -76,6 +76,7 @@ static struct scsi_host_template pata_pl
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_qdi.c
===================================================================
--- work.orig/drivers/ata/pata_qdi.c
+++ work/drivers/ata/pata_qdi.c
@@ -162,6 +162,7 @@ static struct scsi_host_template qdi_sht
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_radisys.c
===================================================================
--- work.orig/drivers/ata/pata_radisys.c
+++ work/drivers/ata/pata_radisys.c
@@ -225,6 +225,7 @@ static struct scsi_host_template radisys
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_rz1000.c
===================================================================
--- work.orig/drivers/ata/pata_rz1000.c
+++ work/drivers/ata/pata_rz1000.c
@@ -88,6 +88,7 @@ static struct scsi_host_template rz1000_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_sc1200.c
===================================================================
--- work.orig/drivers/ata/pata_sc1200.c
+++ work/drivers/ata/pata_sc1200.c
@@ -191,6 +191,7 @@ static struct scsi_host_template sc1200_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_serverworks.c
===================================================================
--- work.orig/drivers/ata/pata_serverworks.c
+++ work/drivers/ata/pata_serverworks.c
@@ -323,6 +323,7 @@ static struct scsi_host_template serverw
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_sil680.c
===================================================================
--- work.orig/drivers/ata/pata_sil680.c
+++ work/drivers/ata/pata_sil680.c
@@ -223,6 +223,7 @@ static struct scsi_host_template sil680_
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_sis.c
===================================================================
--- work.orig/drivers/ata/pata_sis.c
+++ work/drivers/ata/pata_sis.c
@@ -543,6 +543,7 @@ static struct scsi_host_template sis_sht
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_sl82c105.c
===================================================================
--- work.orig/drivers/ata/pata_sl82c105.c
+++ work/drivers/ata/pata_sl82c105.c
@@ -235,6 +235,7 @@ static struct scsi_host_template sl82c10
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_triflex.c
===================================================================
--- work.orig/drivers/ata/pata_triflex.c
+++ work/drivers/ata/pata_triflex.c
@@ -190,6 +190,7 @@ static struct scsi_host_template triflex
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_via.c
===================================================================
--- work.orig/drivers/ata/pata_via.c
+++ work/drivers/ata/pata_via.c
@@ -295,6 +295,7 @@ static struct scsi_host_template via_sht
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pata_winbond.c
===================================================================
--- work.orig/drivers/ata/pata_winbond.c
+++ work/drivers/ata/pata_winbond.c
@@ -131,6 +131,7 @@ static struct scsi_host_template winbond
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/pdc_adma.c
===================================================================
--- work.orig/drivers/ata/pdc_adma.c
+++ work/drivers/ata/pdc_adma.c
@@ -150,6 +150,7 @@ static struct scsi_host_template adma_at
 	.use_clustering		= ENABLE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ADMA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_mv.c
===================================================================
--- work.orig/drivers/ata/sata_mv.c
+++ work/drivers/ata/sata_mv.c
@@ -388,6 +388,7 @@ static struct scsi_host_template mv_sht 
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= MV_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_nv.c
===================================================================
--- work.orig/drivers/ata/sata_nv.c
+++ work/drivers/ata/sata_nv.c
@@ -308,6 +308,7 @@ static struct scsi_host_template nv_sht 
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_promise.c
===================================================================
--- work.orig/drivers/ata/sata_promise.c
+++ work/drivers/ata/sata_promise.c
@@ -127,6 +127,7 @@ static struct scsi_host_template pdc_ata
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_qstor.c
===================================================================
--- work.orig/drivers/ata/sata_qstor.c
+++ work/drivers/ata/sata_qstor.c
@@ -141,6 +141,7 @@ static struct scsi_host_template qs_ata_
 	.use_clustering		= ENABLE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= QS_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -178,6 +178,7 @@ static struct scsi_host_template sil_sht
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -383,6 +383,7 @@ static struct scsi_host_template sil24_s
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_sis.c
===================================================================
--- work.orig/drivers/ata/sata_sis.c
+++ work/drivers/ata/sata_sis.c
@@ -94,6 +94,7 @@ static struct scsi_host_template sis_sht
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_svw.c
===================================================================
--- work.orig/drivers/ata/sata_svw.c
+++ work/drivers/ata/sata_svw.c
@@ -297,6 +297,7 @@ static struct scsi_host_template k2_sata
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 #ifdef CONFIG_PPC_OF
Index: work/drivers/ata/sata_sx4.c
===================================================================
--- work.orig/drivers/ata/sata_sx4.c
+++ work/drivers/ata/sata_sx4.c
@@ -190,6 +190,7 @@ static struct scsi_host_template pdc_sat
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_uli.c
===================================================================
--- work.orig/drivers/ata/sata_uli.c
+++ work/drivers/ata/sata_uli.c
@@ -88,6 +88,7 @@ static struct scsi_host_template uli_sht
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_via.c
===================================================================
--- work.orig/drivers/ata/sata_via.c
+++ work/drivers/ata/sata_via.c
@@ -104,6 +104,7 @@ static struct scsi_host_template svia_sh
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/drivers/ata/sata_vsc.c
===================================================================
--- work.orig/drivers/ata/sata_vsc.c
+++ work/drivers/ata/sata_vsc.c
@@ -277,6 +277,7 @@ static struct scsi_host_template vsc_sat
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_alloc		= ata_scsi_slave_alloc,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -820,6 +820,7 @@ extern void ata_scsi_simulate(struct ata
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
+extern int ata_scsi_slave_alloc(struct scsi_device *sdev);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
