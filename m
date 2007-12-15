From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/10] libata-acpi: implement and use ata_acpi_init_gtm()
Date: Sat, 15 Dec 2007 15:05:02 +0900
Message-ID: <1197698707349-git-send-email-htejun@gmail.com>
References: <11976987063011-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:53113 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002AbXLOGFV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 01:05:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1193517rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 22:05:19 -0800 (PST)
In-Reply-To: <11976987063011-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

_GTM fetches currently configured transfer mode while _STM configures
controller according to _GTM parameter and prepares transfer mode
configuration TFs for _GTF.  In many cases _GTM and _STM
implementations are quite brittle and can't cope with configuration
changed by libata.

libata does not depend on ATA ACPI to configure devices.  The only
reason libata performs _GTM and _STM are to make _GTF evaluation
succeed and libata also doesn't care about how _GTF TFs configure
transfer mode.  It overrides that configuration anyway, so from
libata's POV, it doesn't matter what value is feeded to _STM as long
as evaluation succeeds for _STM and following _GTF.

This patch adds dev->__acpi_init_gtm and store initial _GTM values on
host initialization before modified by reset and mode configuration.
If the field is valid, ata_acpi_init_gtm() returns pointer to the
saved _GTM structure; otherwise, NULL.

This saved value is used for _STM during resume and peek at
BIOS/firmware programmed initial timing for later use.  The accessor
is there to make building w/o ACPI easy as dev->__acpi_init doesn't
exist if ACPI is not enabled.

On driver detach, the initial BIOS configuration is restored by
executing _STM with the initial _GTM values such that the next driver
can also use the initial BIOS configured values.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   62 +++++++++++++++++++-------------------------
 include/linux/libata.h    |   14 ++++++++-
 2 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9e5fc5d..b3aeca3 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -94,6 +94,9 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
 
 		dev->acpi_handle = acpi_get_child(ap->acpi_handle, i);
 	}
+
+	if (ata_acpi_gtm(ap, &ap->__acpi_init_gtm) == 0)
+		ap->pflags |= ATA_PFLAG_INIT_GTM_VALID;
 }
 
 static void ata_acpi_handle_hotplug(struct ata_port *ap, struct kobject *kobj,
@@ -199,7 +202,18 @@ void ata_acpi_associate(struct ata_host *host)
  */
 void ata_acpi_dissociate(struct ata_host *host)
 {
-	/* nada */
+	int i;
+
+	/* Restore initial _GTM values so that driver which attaches
+	 * afterward can use them too.
+	 */
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		const struct ata_acpi_gtm *gtm = ata_acpi_init_gtm(ap);
+
+		if (ap->acpi_handle && gtm)
+			ata_acpi_stm(ap, gtm);
+	}
 }
 
 /**
@@ -409,22 +423,21 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 
 int ata_acpi_cbl_80wire(struct ata_port *ap)
 {
-	struct ata_acpi_gtm gtm;
+	const struct ata_acpi_gtm *gtm = ata_acpi_init_gtm(ap);
 	int valid = 0;
 
-	/* No _GTM data, no information */
-	if (ata_acpi_gtm(ap, &gtm) < 0)
+	if (!gtm)
 		return 0;
 
 	/* Split timing, DMA enabled */
-	if ((gtm.flags & 0x11) == 0x11 && gtm.drive[0].dma < 55)
+	if ((gtm->flags & 0x11) == 0x11 && gtm->drive[0].dma < 55)
 		valid |= 1;
-	if ((gtm.flags & 0x14) == 0x14 && gtm.drive[1].dma < 55)
+	if ((gtm->flags & 0x14) == 0x14 && gtm->drive[1].dma < 55)
 		valid |= 2;
 	/* Shared timing, DMA enabled */
-	if ((gtm.flags & 0x11) == 0x01 && gtm.drive[0].dma < 55)
+	if ((gtm->flags & 0x11) == 0x01 && gtm->drive[0].dma < 55)
 		valid |= 1;
-	if ((gtm.flags & 0x14) == 0x04 && gtm.drive[0].dma < 55)
+	if ((gtm->flags & 0x14) == 0x04 && gtm->drive[0].dma < 55)
 		valid |= 2;
 
 	/* Drive check */
@@ -612,27 +625,8 @@ static int ata_acpi_push_id(struct ata_device *dev)
  */
 int ata_acpi_on_suspend(struct ata_port *ap)
 {
-	unsigned long flags;
-	int rc;
-
-	/* proceed iff per-port acpi_handle is valid */
-	if (!ap->acpi_handle)
-		return 0;
-	BUG_ON(ap->flags & ATA_FLAG_ACPI_SATA);
-
-	/* store timing parameters */
-	rc = ata_acpi_gtm(ap, &ap->acpi_gtm);
-
-	spin_lock_irqsave(ap->lock, flags);
-	if (rc == 0)
-		ap->pflags |= ATA_PFLAG_GTM_VALID;
-	else
-		ap->pflags &= ~ATA_PFLAG_GTM_VALID;
-	spin_unlock_irqrestore(ap->lock, flags);
-
-	if (rc == -ENOENT)
-		rc = 0;
-	return rc;
+	/* nada */
+	return 0;
 }
 
 /**
@@ -647,14 +641,12 @@ int ata_acpi_on_suspend(struct ata_port *ap)
  */
 void ata_acpi_on_resume(struct ata_port *ap)
 {
+	const struct ata_acpi_gtm *gtm = ata_acpi_init_gtm(ap);
 	struct ata_device *dev;
 
-	if (ap->acpi_handle && (ap->pflags & ATA_PFLAG_GTM_VALID)) {
-		BUG_ON(ap->flags & ATA_FLAG_ACPI_SATA);
-
-		/* restore timing parameters */
-		ata_acpi_stm(ap, &ap->acpi_gtm);
-	}
+	/* restore timing parameters */
+	if (ap->acpi_handle && gtm)
+		ata_acpi_stm(ap, gtm);
 
 	/* schedule _GTF */
 	ata_link_for_each_dev(dev, &ap->link)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3784af3..ba84d8a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -211,7 +211,7 @@ enum {
 
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
-	ATA_PFLAG_GTM_VALID	= (1 << 19), /* acpi_gtm data valid */
+	ATA_PFLAG_INIT_GTM_VALID = (1 << 19), /* initial gtm data valid */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -653,7 +653,7 @@ struct ata_port {
 
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
-	struct ata_acpi_gtm	acpi_gtm;
+	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
@@ -939,10 +939,20 @@ enum {
 
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
+static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
+{
+	if (ap->pflags & ATA_PFLAG_INIT_GTM_VALID)
+		return &ap->__acpi_init_gtm;
+	return NULL;
+}
 extern int ata_acpi_cbl_80wire(struct ata_port *ap);
 int ata_acpi_stm(struct ata_port *ap, const struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *stm);
 #else
+static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
+{
+	return NULL;
+}
 static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
 #endif
 
-- 
1.5.2.4

