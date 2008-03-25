From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 27/27] libata: make SFF support optional
Date: Tue, 25 Mar 2008 22:17:05 +0900
Message-ID: <12064510292617-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.183]:23108 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbYCYNRr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:47 -0400
Received: by el-out-1112.google.com with SMTP id v27so1723848ele.17
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:46 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Now that SFF support is completely separated out from the core layer,
it can be made optional.  Add CONFIG_ATA_SFF and let SFF drivers
depend on it.  If CONFIG_ATA_SFF isn't set, all codes in libata-sff.c
and data structures for SFF support are disabled.  This saves good
number of bytes for small systems.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/Kconfig       |   44 +++++++++++++++++++++++++++-----------------
 drivers/ata/Makefile      |    4 ++--
 drivers/ata/libata-core.c |    2 ++
 drivers/ata/libata-scsi.c |    2 ++
 drivers/ata/libata.h      |    4 ++++
 include/linux/libata.h    |    9 +++++++++
 6 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 25aba69..a3fcc4b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -49,6 +49,32 @@ config SATA_AHCI
 
 	  If unsure, say N.
 
+config SATA_SIL24
+	tristate "Silicon Image 3124/3132 SATA support"
+	depends on PCI
+	help
+	  This option enables support for Silicon Image 3124/3132 Serial ATA.
+
+	  If unsure, say N.
+
+config SATA_FSL
+	tristate "Freescale 3.0Gbps SATA support"
+	depends on FSL_SOC
+	help
+	  This option enables support for Freescale 3.0Gbps SATA controller.
+	  It can be found on MPC837x and MPC8315.
+
+	  If unsure, say N.
+
+config ATA_SFF
+	bool "ATA SFF support"
+	default y
+	help
+	  This option adds support for ATA controllers with SFF
+	  compliant or similar programming interface.
+
+if ATA_SFF
+
 config SATA_SVW
 	tristate "ServerWorks Frodo / Apple K2 SATA support"
 	depends on PCI
@@ -125,14 +151,6 @@ config SATA_SIL
 
 	  If unsure, say N.
 
-config SATA_SIL24
-	tristate "Silicon Image 3124/3132 SATA support"
-	depends on PCI
-	help
-	  This option enables support for Silicon Image 3124/3132 Serial ATA.
-
-	  If unsure, say N.
-
 config SATA_SIS
 	tristate "SiS 964/965/966/180 SATA support"
 	depends on PCI
@@ -183,15 +201,6 @@ config PATA_ACPI
 	  firmware in the BIOS. This driver can sometimes handle
 	  otherwise unsupported hardware.
 
-config SATA_FSL
-	tristate "Freescale 3.0Gbps SATA support"
-	depends on FSL_SOC
-	help
-	  This option enables support for Freescale 3.0Gbps SATA controller.
-	  It can be found on MPC837x and MPC8315.
-
-	  If unsure, say N.
-
 config PATA_ALI
 	tristate "ALi PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
@@ -679,4 +688,5 @@ config PATA_BF54X
 
 	  If unsure, say N.
 
+endif # ATA_SFF
 endif # ATA
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 0511e6f..e6e41b2 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -78,6 +78,6 @@ obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
 # Should be last libata driver
 obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
-libata-objs	:= libata-core.o libata-scsi.o libata-sff.o libata-eh.o \
-		   libata-pmp.o
+libata-objs	:= libata-core.o libata-scsi.o libata-eh.o libata-pmp.o
+libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0ffe61d..22f3140 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5143,7 +5143,9 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
 #endif
 
+#ifdef CONFIG_ATA_SFF
 	INIT_DELAYED_WORK(&ap->port_task, ata_pio_task);
+#endif
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
 	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
 	INIT_LIST_HEAD(&ap->eh_done_q);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f8be928..a70881c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2393,7 +2393,9 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	/* FIXME: is this needed? */
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 
+#ifdef CONFIG_ATA_SFF
 	ap->ops->sff_tf_read(ap, &qc->tf);
+#endif
 
 	/* fill these in, for the case where they are -not- overwritten */
 	cmd->sense_buffer[0] = 0x70;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 87e7c5b..45e1786 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -42,8 +42,10 @@ static inline int ata_is_builtin_hardreset(ata_reset_fn_t reset)
 {
 	if (reset == sata_std_hardreset)
 		return 1;
+#ifdef CONFIG_ATA_SFF
 	if (reset == sata_sff_hardreset)
 		return 1;
+#endif
 	return 0;
 }
 
@@ -205,9 +207,11 @@ extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 extern void ata_eh_finish(struct ata_port *ap);
 
 /* libata-sff.c */
+#ifdef CONFIG_ATA_SFF
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern u8 ata_irq_on(struct ata_port *ap);
 extern void ata_pio_task(struct work_struct *work);
+#endif /* CONFIG_ATA_SFF */
 
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4584180..817ecd5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -443,6 +443,7 @@ enum link_pm {
 };
 extern struct class_device_attribute class_device_attr_link_power_management_policy;
 
+#ifdef CONFIG_ATA_SFF
 struct ata_ioports {
 	void __iomem		*cmd_addr;
 	void __iomem		*data_addr;
@@ -460,6 +461,7 @@ struct ata_ioports {
 	void __iomem		*bmdma_addr;
 	void __iomem		*scr_addr;
 };
+#endif /* CONFIG_ATA_SFF */
 
 struct ata_host {
 	spinlock_t		lock;
@@ -646,7 +648,9 @@ struct ata_port {
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
 
+#ifdef CONFIG_ATA_SFF
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
+#endif /* CONFIG_ATA_SFF */
 
 	u8			ctl;	/* cache of ATA control register */
 	u8			last_ctl;	/* Cache last written value */
@@ -758,6 +762,7 @@ struct ata_port_operations {
 	void (*port_stop)(struct ata_port *ap);
 	void (*host_stop)(struct ata_host *host);
 
+#ifdef CONFIG_ATA_SFF
 	/*
 	 * SFF / taskfile oriented ops
 	 */
@@ -777,6 +782,7 @@ struct ata_port_operations {
 	void (*bmdma_start)(struct ata_queued_cmd *qc);
 	void (*bmdma_stop)(struct ata_queued_cmd *qc);
 	u8   (*bmdma_status)(struct ata_port *ap);
+#endif /* CONFIG_ATA_SFF */
 
 	/*
 	 * Obsolete
@@ -1367,6 +1373,8 @@ static inline struct ata_port *ata_shost_to_port(struct Scsi_Host *host)
 /**************************************************************************
  * SFF - drivers/ata/libata-sff.c
  */
+#ifdef CONFIG_ATA_SFF
+
 extern const struct ata_port_operations ata_sff_port_ops;
 extern const struct ata_port_operations ata_bmdma_port_ops;
 
@@ -1507,5 +1515,6 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
 
 	return status;
 }
+#endif /* CONFIG_ATA_SFF */
 
 #endif /* __LINUX_LIBATA_H__ */
-- 
1.5.2.4

