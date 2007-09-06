From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Asynchronous scan support for libata
Date: Thu, 6 Sep 2007 15:05:05 -0600
Message-ID: <20070906210505.GF27404@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:47059 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbXIFVFH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 17:05:07 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org


Last December, I posted this: http://lwn.net/Articles/213635/

Here's an updated version.  It shaves 5 seconds off boot time on my
configuration (qla2xxx, emulex, two ata_piix, dual fusion), but could
save more or less on other setups.

I think I can remove the 'sync' argument and code from
ata_scsi_scan_host() now, but wanted to send out this update today.

---

Some of the drivers (AHCI was mentioned to me as a culprit) take a long
time to discover all the devices attached to them.  Even for ones which
are relatively quick, if you put a lot of them in a machine, it will
take a long time in aggregate.  This can be fixed by adding support for
asynchronous scsi scans, which causes the time-consuming portions of
initialisation to take place in threads.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 60e78be..43298c0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6321,6 +6321,53 @@ void ata_host_init(struct ata_host *host, struct device *dev,
 	host->ops = ops;
 }
 
+void ata_scsi_scan_start(struct Scsi_Host *shost)
+{
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	if (ap->ops->error_handler) {
+		struct ata_eh_info *ehi = &ap->eh_info;
+		unsigned long flags;
+
+		ata_port_probe(ap);
+
+		/* kick EH for boot probing */
+		spin_lock_irqsave(ap->lock, flags);
+
+		ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
+		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
+
+		ap->pflags &= ~ATA_PFLAG_INITIALIZING;
+		ap->pflags |= ATA_PFLAG_LOADING;
+		ata_port_schedule_eh(ap);
+
+		spin_unlock_irqrestore(ap->lock, flags);
+
+		/* wait for EH to finish */
+		ata_port_wait_eh(ap);
+	} else {
+		int rc;
+		DPRINTK("ata%u: bus probe begin\n", ap->print_id);
+		rc = ata_bus_probe(ap);
+		DPRINTK("ata%u: bus probe end\n", ap->print_id);
+
+		if (rc) {
+			/*
+			 * FIXME: do something useful here?
+			 * Current libata behavior will tear down everything
+			 * when the module is removed or the h/w is unplugged.
+			 */
+		}
+	}
+}
+
+int ata_scsi_scan_finished(struct Scsi_Host *shost, unsigned long time)
+{
+	ata_scsi_scan_host(ata_shost_to_port(shost), 1);
+	return 1;
+}
+
 /**
  *	ata_host_register - register initialized ATA host
  *	@host: ATA host to register
@@ -6408,56 +6455,10 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 			ata_port_printk(ap, KERN_INFO, "DUMMY\n");
 	}
 
-	/* perform each probe synchronously */
 	DPRINTK("probe begin\n");
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-		int rc;
-
-		/* probe */
-		if (ap->ops->error_handler) {
-			struct ata_eh_info *ehi = &ap->eh_info;
-			unsigned long flags;
-
-			ata_port_probe(ap);
-
-			/* kick EH for boot probing */
-			spin_lock_irqsave(ap->lock, flags);
-
-			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
-			ehi->action |= ATA_EH_SOFTRESET;
-			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
-
-			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
-			ap->pflags |= ATA_PFLAG_LOADING;
-			ata_port_schedule_eh(ap);
-
-			spin_unlock_irqrestore(ap->lock, flags);
-
-			/* wait for EH to finish */
-			ata_port_wait_eh(ap);
-		} else {
-			DPRINTK("ata%u: bus probe begin\n", ap->print_id);
-			rc = ata_bus_probe(ap);
-			DPRINTK("ata%u: bus probe end\n", ap->print_id);
-
-			if (rc) {
-				/* FIXME: do something useful here?
-				 * Current libata behavior will
-				 * tear down everything when
-				 * the module is removed
-				 * or the h/w is unplugged.
-				 */
-			}
-		}
-	}
-
-	/* probes are done, now scan each port's disk(s) */
-	DPRINTK("host probe begin\n");
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		ata_scsi_scan_host(ap, 1);
+		scsi_scan_host(ap->scsi_host);
 	}
 
 	return 0;
@@ -6927,6 +6928,8 @@ EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
+EXPORT_SYMBOL_GPL(ata_scsi_scan_start);
+EXPORT_SYMBOL_GPL(ata_scsi_scan_finished);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(sata_scr_valid);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e836476..faf01ba 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2909,6 +2909,13 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 {
 	int i, rc;
 
+	if (!sht->scan_start) {
+		printk(KERN_WARNING "Overriding NULL scan_start in %s host "
+			"template\n", sht->name);
+		sht->scan_start = ata_scsi_scan_start;
+		sht->scan_finished = ata_scsi_scan_finished;
+	}
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 		struct Scsi_Host *shost;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 41978a5..4526a26 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -826,6 +826,8 @@ extern int ata_std_bios_param(struct scsi_device *sdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
+extern void ata_scsi_scan_start(struct Scsi_Host *shost);
+extern int ata_scsi_scan_finished(struct Scsi_Host *shost, unsigned long time);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 06f212f..d1561e4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -258,6 +258,8 @@ static struct scsi_host_template ahci_sht = {
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 430fcf4..881bbd4 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -89,6 +89,8 @@ static struct scsi_host_template generic_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a78832e..dc551d7 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -283,6 +283,8 @@ static struct scsi_host_template piix_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index e8a28e9..6771a5e 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -290,6 +290,8 @@ static struct scsi_host_template ali_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index b09faca..daacc6c 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -323,6 +323,8 @@ static struct scsi_host_template amd_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index ce589d9..846bcbe 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -325,6 +325,8 @@ static struct scsi_host_template artop_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 80509be..7547c62 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -228,6 +228,8 @@ static struct scsi_host_template atiixp_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 0feb5ae..ae19f9d 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -180,6 +180,8 @@ static struct scsi_host_template cmd640_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index e34b632..f1a3c9b 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -265,6 +265,8 @@ static struct scsi_host_template cmd64x_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 7dc76e7..f2a0d7c 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -154,6 +154,8 @@ static struct scsi_host_template cs5520_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 68f150a..e39bbba 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -175,6 +175,8 @@ static struct scsi_host_template cs5530_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 360b6f3..a0b1917 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -172,6 +172,8 @@ static struct scsi_host_template cs5535_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index 6cbc877..5a95757 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -124,6 +124,8 @@ static struct scsi_host_template cy82c693_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index c8ba59c..9d91bac 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -246,6 +246,8 @@ static struct scsi_host_template efar_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 6f7d34a..c316380 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -304,6 +304,8 @@ static struct scsi_host_template hpt36x_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 84d9c55..f58b9d5 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -636,6 +636,8 @@ static struct scsi_host_template hpt37x_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index aa29cde..f920b0e 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -352,6 +352,8 @@ static struct scsi_host_template hpt3x2n_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index be0f05e..3fa9900 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -116,6 +116,8 @@ static struct scsi_host_template hpt3x3_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 64a7117..611568d 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -322,6 +322,8 @@ static struct scsi_host_template pata_icside_sht = {
 	.dma_boundary		= ~0, /* no dma boundaries */
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 5525518..5d206ae 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -34,6 +34,8 @@ static struct scsi_host_template isapnp_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index b8af55e..742ed2f 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -256,6 +256,8 @@ static struct scsi_host_template it8213_sht = {
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 430673b..a7a342e 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -612,6 +612,8 @@ static struct scsi_host_template it821x_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 4ca7fd6..a437e7c 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -101,6 +101,8 @@ static struct scsi_host_template ixp4xx_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 4d67f23..e4922be 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -136,6 +136,8 @@ static struct scsi_host_template jmicron_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
 };
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index edffc25..1fdad67 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -139,6 +139,8 @@ static struct scsi_host_template legacy_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 87594c0..692c390 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -105,6 +105,8 @@ static struct scsi_host_template marvell_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
 };
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 182e83c..a2d170e 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -279,6 +279,8 @@ static struct scsi_host_template mpc52xx_ata_sht = {
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 4ea4283..f6cc787 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -164,6 +164,8 @@ static struct scsi_host_template mpiix_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 40eb574..e0ceb81 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -35,6 +35,8 @@ static struct scsi_host_template netcell_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
 };
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 2f5d714..c052da9 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -157,6 +157,8 @@ static struct scsi_host_template ns87410_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 091a70a..3489b3c 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -233,6 +233,8 @@ static struct scsi_host_template oldpiix_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 458bf67..f278b96 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -178,6 +178,8 @@ static struct scsi_host_template opti_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index f89bdfd..095e7b9 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -362,6 +362,8 @@ static struct scsi_host_template optidma_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 6da23fe..9f9908b 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -102,6 +102,8 @@ static struct scsi_host_template pcmcia_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 69a5aa4..cf55a5a 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -143,6 +143,8 @@ static struct scsi_host_template pdc2027x_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 92447be..c296545 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -243,6 +243,8 @@ static struct scsi_host_template pdc202xx_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index a909f79..1ff0413 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -65,6 +65,8 @@ static struct scsi_host_template pata_platform_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 1998c19..90c30d9 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -166,6 +166,8 @@ static struct scsi_host_template qdi_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 7d1aabe..b7068de 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -199,6 +199,8 @@ static struct scsi_host_template radisys_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 7632fcb..761f37a 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -68,6 +68,8 @@ static struct scsi_host_template rz1000_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index b8b2d11..e6710d9 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -193,6 +193,8 @@ static struct scsi_host_template sc1200_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 36cdbd2..df3f0e7 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -1016,6 +1016,8 @@ static struct scsi_host_template scc_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 8969154..d121985 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -314,6 +314,8 @@ static struct scsi_host_template serverworks_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index b0cd52d..21c9f75 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -233,6 +233,8 @@ static struct scsi_host_template sil680_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 66bd0e8..371eb0d 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -524,6 +524,8 @@ static struct scsi_host_template sis_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 8c2813a..3efa4a8 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -220,6 +220,8 @@ static struct scsi_host_template sl82c105_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index af21f44..2d88935 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -193,6 +193,8 @@ static struct scsi_host_template triflex_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index f645fe2..9e527d0 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -329,6 +329,8 @@ static struct scsi_host_template via_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 83abfec..4be34bc 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -134,6 +134,8 @@ static struct scsi_host_template winbond_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index bec1de5..f17819d 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -147,6 +147,8 @@ static struct scsi_host_template adma_ata_sht = {
 	.queuecommand		= ata_scsi_queuecmd,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 	.proc_name		= DRV_NAME,
 	.can_queue		= ATA_DEF_QUEUE,
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index a9c948d..5a91e2f 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -134,6 +134,8 @@ static struct scsi_host_template inic_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= inic_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 8ec5208..369bfbb 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -456,6 +456,8 @@ static struct scsi_host_template mv5_sht = {
 	.dma_boundary		= MV_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
@@ -474,6 +476,8 @@ static struct scsi_host_template mv6_sht = {
 	.dma_boundary		= MV_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 0b58c4d..9c3010c 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -317,6 +317,8 @@ static struct scsi_host_template nv_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
@@ -336,6 +338,8 @@ static struct scsi_host_template nv_adma_sht = {
 	.dma_boundary		= NV_ADMA_DMA_BOUNDARY,
 	.slave_configure	= nv_adma_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index d39ebc2..556fc31 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -163,6 +163,8 @@ static struct scsi_host_template pdc_ata_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index c8f9242..08c766e 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -141,6 +141,8 @@ static struct scsi_host_template qs_ata_sht = {
 	.dma_boundary		= QS_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index db67637..5137243 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -181,6 +181,8 @@ static struct scsi_host_template sil_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 46fbbe7..d246d23 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -380,6 +380,8 @@ static struct scsi_host_template sil24_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 31a2f55..d6c4d4b 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -100,6 +100,8 @@ static struct scsi_host_template sis_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 92e8770..8815506 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -321,6 +321,8 @@ static struct scsi_host_template k2_sata_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 #ifdef CONFIG_PPC_OF
 	.proc_info		= k2_sata_proc_info,
 #endif
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 5193bd8..b1fba1e 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -250,6 +250,8 @@ static struct scsi_host_template pdc_sata_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 78c2851..e4a56fe 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -90,6 +90,8 @@ static struct scsi_host_template uli_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 86b7bfc..288a11f 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -118,6 +118,8 @@ static struct scsi_host_template svia_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 24344d0..91ebbbf 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -312,6 +312,8 @@ static struct scsi_host_template vsc_sata_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
+	.scan_start		= ata_scsi_scan_start,
+	.scan_finished		= ata_scsi_scan_finished,
 	.bios_param		= ata_std_bios_param,
 };
 

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
