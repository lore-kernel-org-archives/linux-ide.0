From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 17/27] libata: clear SError after link resume
Date: Tue, 25 Mar 2008 22:16:55 +0900
Message-ID: <1206451028535-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:63310 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504AbYCYNRv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755554rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:48 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

SError used to be cleared in ->postreset.  This has small hotplug race
condition.  If a device is plugged in after reset is complete but
postreset hasn't run yet, its hotplug event gets lost when SError is
cleared.  This patch makes sata_link_resume() clear SError.  This
kills the race condition and makes a lot of sense as some PMP and host
PHYs don't work properly without SError cleared.

This change makes sata_pmp_std_{pre|post}_reset()'s unnecessary as
they become identical to ata_std counterparts.  It also simplifies
sata_pmp_hardreset() and ahci_vt8251_hardreset().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    5 --
 drivers/ata/libata-core.c |   35 +++++++++++------
 drivers/ata/libata-pmp.c  |   93 +--------------------------------------------
 include/linux/libata.h    |    2 -
 4 files changed, 23 insertions(+), 112 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0f553aa..a69bcca 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1377,7 +1377,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
-	u32 serror;
 	bool online;
 	int rc;
 
@@ -1388,10 +1387,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
 				 deadline, &online, NULL);
 
-	/* vt8251 needs SError cleared for the port to operate */
-	ahci_scr_read(ap, SCR_ERROR, &serror);
-	ahci_scr_write(ap, SCR_ERROR, serror);
-
 	ahci_start_engine(ap);
 
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1a32dea..2637733 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -90,9 +90,9 @@ const struct ata_port_operations sata_port_ops = {
 const struct ata_port_operations sata_pmp_port_ops = {
 	.inherits		= &sata_port_ops,
 
-	.pmp_prereset		= sata_pmp_std_prereset,
+	.pmp_prereset		= ata_std_prereset,
 	.pmp_hardreset		= sata_pmp_std_hardreset,
-	.pmp_postreset		= sata_pmp_std_postreset,
+	.pmp_postreset		= ata_std_postreset,
 	.error_handler		= sata_pmp_error_handler,
 };
 
@@ -3455,7 +3455,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		     unsigned long deadline)
 {
-	u32 scontrol;
+	u32 scontrol, serror;
 	int rc;
 
 	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
@@ -3471,7 +3471,25 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 	 */
 	msleep(200);
 
-	return sata_link_debounce(link, params, deadline);
+	if ((rc = sata_link_debounce(link, params, deadline)))
+		return rc;
+
+	/* Clear SError.  PMP and some host PHYs require this to
+	 * operate and clearing should be done before checking PHY
+	 * online status to avoid race condition (hotplugging between
+	 * link resume and status check).
+	 */
+	if (!(rc = sata_scr_read(link, SCR_ERROR, &serror)))
+		rc = sata_scr_write(link, SCR_ERROR, serror);
+	if (rc == 0 || rc == -EINVAL) {
+		unsigned long flags;
+
+		spin_lock_irqsave(link->ap->lock, flags);
+		link->eh_info.serror = 0;
+		spin_unlock_irqrestore(link->ap->lock, flags);
+		rc = 0;
+	}
+	return rc;
 }
 
 /**
@@ -3663,18 +3681,11 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
  */
 void ata_std_postreset(struct ata_link *link, unsigned int *classes)
 {
-	u32 serror;
-
 	DPRINTK("ENTER\n");
 
 	/* print link status */
 	sata_print_link_status(link);
 
-	/* clear SError */
-	if (sata_scr_read(link, SCR_ERROR, &serror) == 0)
-		sata_scr_write(link, SCR_ERROR, serror);
-	link->eh_info.serror = 0;
-
 	DPRINTK("EXIT\n");
 }
 
@@ -6243,9 +6254,7 @@ EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 #endif /* CONFIG_PCI */
 
 EXPORT_SYMBOL_GPL(sata_pmp_qc_defer_cmd_switch);
-EXPORT_SYMBOL_GPL(sata_pmp_std_prereset);
 EXPORT_SYMBOL_GPL(sata_pmp_std_hardreset);
-EXPORT_SYMBOL_GPL(sata_pmp_std_postreset);
 EXPORT_SYMBOL_GPL(sata_pmp_error_handler);
 
 EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 7f1a87f..2f8a957 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -176,49 +176,6 @@ int sata_pmp_scr_write(struct ata_link *link, int reg, u32 val)
 }
 
 /**
- *	sata_pmp_std_prereset - prepare PMP link for reset
- *	@link: link to be reset
- *	@deadline: deadline jiffies for the operation
- *
- *	@link is about to be reset.  Initialize it.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int sata_pmp_std_prereset(struct ata_link *link, unsigned long deadline)
-{
-	struct ata_eh_context *ehc = &link->eh_context;
-	const unsigned long *timing = sata_ehc_deb_timing(ehc);
-	int rc;
-
-	/* if we're about to do hardreset, nothing more to do */
-	if (ehc->i.action & ATA_EH_HARDRESET)
-		return 0;
-
-	/* resume link */
-	rc = sata_link_resume(link, timing, deadline);
-	if (rc) {
-		/* phy resume failed */
-		ata_link_printk(link, KERN_WARNING, "failed to resume link "
-				"for reset (errno=%d)\n", rc);
-		return rc;
-	}
-
-	/* clear SError bits including .X which blocks the port when set */
-	rc = sata_scr_write(link, SCR_ERROR, 0xffffffff);
-	if (rc) {
-		ata_link_printk(link, KERN_ERR,
-				"failed to clear SError (errno=%d)\n", rc);
-		return rc;
-	}
-
-	return 0;
-}
-
-/**
  *	sata_pmp_std_hardreset - standard hardreset method for PMP link
  *	@link: link to be reset
  *	@class: resulting class of attached device
@@ -238,33 +195,13 @@ int sata_pmp_std_prereset(struct ata_link *link, unsigned long deadline)
 int sata_pmp_std_hardreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline)
 {
-	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
-	bool online;
 	u32 tmp;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	/* do hardreset */
-	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
-	if (rc) {
-		ata_link_printk(link, KERN_ERR,
-				"COMRESET failed (errno=%d)\n", rc);
-		goto out;
-	}
-
-	/* clear SError bits including .X which blocks the port when set */
-	rc = sata_scr_write(link, SCR_ERROR, 0xffffffff);
-	if (rc) {
-		ata_link_printk(link, KERN_ERR, "failed to clear SError "
-				"during hardreset (errno=%d)\n", rc);
-		goto out;
-	}
+	rc = sata_std_hardreset(link, class, deadline);
 
-	/* if device is present, follow up with srst to wait for !BSY */
-	if (online)
-		rc = -EAGAIN;
- out:
 	/* if SCR isn't accessible, we need to reset the PMP */
 	if (rc && rc != -EAGAIN && sata_scr_read(link, SCR_STATUS, &tmp))
 		rc = -ERESTART;
@@ -274,34 +211,6 @@ int sata_pmp_std_hardreset(struct ata_link *link, unsigned int *class,
 }
 
 /**
- *	ata_std_postreset - standard postreset method for PMP link
- *	@link: the target ata_link
- *	@classes: classes of attached devices
- *
- *	This function is invoked after a successful reset.  Note that
- *	the device might have been reset more than once using
- *	different reset methods before postreset is invoked.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- */
-void sata_pmp_std_postreset(struct ata_link *link, unsigned int *class)
-{
-	u32 serror;
-
-	DPRINTK("ENTER\n");
-
-	/* clear SError */
-	if (sata_scr_read(link, SCR_ERROR, &serror) == 0)
-		sata_scr_write(link, SCR_ERROR, serror);
-
-	/* print link status */
-	sata_print_link_status(link);
-
-	DPRINTK("EXIT\n");
-}
-
-/**
  *	sata_pmp_read_gscr - read GSCR block of SATA PMP
  *	@dev: PMP device
  *	@gscr: buffer to read GSCR block into
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6c5bd23..20b2612 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1022,10 +1022,8 @@ static inline int ata_acpi_cbl_80wire(struct ata_port *ap,
  * PMP - drivers/ata/libata-pmp.c
  */
 extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
-extern int sata_pmp_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int sata_pmp_std_hardreset(struct ata_link *link, unsigned int *class,
 				  unsigned long deadline);
-extern void sata_pmp_std_postreset(struct ata_link *link, unsigned int *class);
 extern void sata_pmp_error_handler(struct ata_port *ap);
 
 /*
-- 
1.5.2.4

