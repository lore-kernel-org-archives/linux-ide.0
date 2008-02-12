From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/10] libata: make reset related methods proper port operations
Date: Tue, 12 Feb 2008 17:43:21 +0900
Message-ID: <1202805803468-git-send-email-htejun@gmail.com>
References: <1202805801343-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:10917 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbYBLIns (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 03:43:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3595172rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 00:43:48 -0800 (PST)
In-Reply-To: <1202805801343-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech
Cc: Tejun Heo <htejun@gmail.com>

Currently reset methods are not specified directly in the
ata_port_operations table.  If a LLD wants to use custom reset
methods, it should construct and use a error_handler which uses those
reset methods.  It's done this way for two reasons.

First, the ops table already contained too many methods and adding
four more of them would noticeably increase the amount of necessary
boilerplate code all over low level drivers.

Second, as ->error_handler uses those reset methods, it can get
confusing.  ie. By overriding ->error_handler, those reset ops can be
made useless making layering a bit hazy.

Now that ops table uses inheritance, the first problem doesn't exist
anymore.  The second isn't completely solved but is relieved by
providing default values - most drivers can just override what it has
implemented and don't have to concern itself about higher level
callbacks.  In fact, there currently is no driver which actually
modifies error handling behavior.  Drivers which override
->error_handler just wraps the standard error handler only to prepare
the controller for EH.  I don't think making ops layering strict has
any noticeable benefit.

This patch makes ->prereset, ->softreset, ->hardreset, ->postreset and
their PMP counterparts propoer ops.  Default ops are provided in the
base ops tables and drivers are converted to override individual reset
methods instead of creating custom error_handler.

* ata_std_error_handler() doesn't use sata_std_hardreset() if SCRs
  aren't accessible.  sata_promise doesn't need to use separate
  error_handlers for PATA and SATA anymore.

* softreset is broken for sata_inic162x and sata_sx4.  As libata now
  always prefers hardreset, this doesn't really matter but the ops are
  forced to NULL using ATA_OP_NULL for documentation purpose.

* pata_hpt374 needs to use different prereset for the first and second
  PCI functions.  This used to be done by branching from
  hpt374_error_handler().  The proper way to do this is to use
  separate ops and port_info tables for each function.  Converted.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c          |   53 ++++++++++++------------------------
 drivers/ata/ata_piix.c      |   21 +++-----------
 drivers/ata/libata-core.c   |   15 ++++++++--
 drivers/ata/libata-eh.c     |   25 ++++++++++-------
 drivers/ata/libata-pmp.c    |   47 ++++++++-------------------------
 drivers/ata/libata-sff.c    |   38 +++------------------------
 drivers/ata/pata_acpi.c     |   16 +----------
 drivers/ata/pata_amd.c      |   18 +-----------
 drivers/ata/pata_artop.c    |   34 +----------------------
 drivers/ata/pata_atiixp.c   |    7 +----
 drivers/ata/pata_bf54x.c    |   14 +--------
 drivers/ata/pata_efar.c     |   15 +----------
 drivers/ata/pata_hpt37x.c   |   61 ++++++++++++++-----------------------------
 drivers/ata/pata_hpt3x2n.c  |   16 +----------
 drivers/ata/pata_icside.c   |    8 +-----
 drivers/ata/pata_it8213.c   |   15 +----------
 drivers/ata/pata_jmicron.c  |   15 +----------
 drivers/ata/pata_marvell.c  |   16 +----------
 drivers/ata/pata_mpc52xx.c  |   10 -------
 drivers/ata/pata_mpiix.c    |   16 +----------
 drivers/ata/pata_ns87410.c  |   16 +----------
 drivers/ata/pata_oldpiix.c  |   16 +----------
 drivers/ata/pata_opti.c     |   17 +-----------
 drivers/ata/pata_optidma.c  |   17 +-----------
 drivers/ata/pata_pdc2027x.c |   19 +------------
 drivers/ata/pata_scc.c      |   15 ++--------
 drivers/ata/pata_sis.c      |   15 +----------
 drivers/ata/pata_sl82c105.c |    8 +-----
 drivers/ata/pata_triflex.c  |    7 +----
 drivers/ata/pata_via.c      |   14 +---------
 drivers/ata/pdc_adma.c      |   11 ++-----
 drivers/ata/sata_fsl.c      |   12 +--------
 drivers/ata/sata_inic162x.c |    5 ++-
 drivers/ata/sata_mv.c       |   16 +++++-----
 drivers/ata/sata_nv.c       |   17 +++--------
 drivers/ata/sata_promise.c  |   22 +++------------
 drivers/ata/sata_qstor.c    |    6 +++-
 drivers/ata/sata_sil24.c    |   18 +++++++++---
 drivers/ata/sata_via.c      |   10 +-----
 drivers/scsi/ipr.c          |    3 +-
 include/linux/libata.h      |   22 +++++++--------
 41 files changed, 169 insertions(+), 577 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 81bdc0b..eb61092 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -246,9 +246,18 @@ static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_pmp_attach(struct ata_port *ap);
 static void ahci_pmp_detach(struct ata_port *ap);
+static int ahci_softreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline);
+static int ahci_hardreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline);
+static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
+				 unsigned long deadline);
+static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline);
+static void ahci_postreset(struct ata_link *link, unsigned int *class);
+static int ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
+			      unsigned long deadline);
 static void ahci_error_handler(struct ata_port *ap);
-static void ahci_vt8251_error_handler(struct ata_port *ap);
-static void ahci_p5wdh_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_port_resume(struct ata_port *ap);
 static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl);
@@ -285,6 +294,10 @@ static struct ata_port_operations ahci_ops = {
 
 	.freeze			= ahci_freeze,
 	.thaw			= ahci_thaw,
+	.softreset		= ahci_softreset,
+	.hardreset		= ahci_hardreset,
+	.postreset		= ahci_postreset,
+	.pmp_softreset		= ahci_pmp_softreset,
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
@@ -305,12 +318,12 @@ static struct ata_port_operations ahci_ops = {
 
 static struct ata_port_operations ahci_vt8251_ops = {
 	.inherits		= &ahci_ops,
-	.error_handler		= ahci_vt8251_error_handler,
+	.hardreset		= ahci_vt8251_hardreset,
 };
 
 static struct ata_port_operations ahci_p5wdh_ops = {
 	.inherits		= &ahci_ops,
-	.error_handler		= ahci_p5wdh_error_handler,
+	.hardreset		= ahci_p5wdh_hardreset,
 };
 
 #define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
@@ -1737,37 +1750,7 @@ static void ahci_error_handler(struct ata_port *ap)
 		ahci_start_engine(ap);
 	}
 
-	/* perform recovery */
-	sata_pmp_do_eh(ap, ata_std_prereset, ahci_softreset,
-		       ahci_hardreset, ahci_postreset,
-		       sata_pmp_std_prereset, ahci_pmp_softreset,
-		       sata_pmp_std_hardreset, sata_pmp_std_postreset);
-}
-
-static void ahci_vt8251_error_handler(struct ata_port *ap)
-{
-	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
-		/* restart engine */
-		ahci_stop_engine(ap);
-		ahci_start_engine(ap);
-	}
-
-	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_vt8251_hardreset,
-		  ahci_postreset);
-}
-
-static void ahci_p5wdh_error_handler(struct ata_port *ap)
-{
-	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
-		/* restart engine */
-		ahci_stop_engine(ap);
-		ahci_start_engine(ap);
-	}
-
-	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_p5wdh_hardreset,
-		  ahci_postreset);
+	sata_pmp_error_handler(ap);
 }
 
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index abdc714..99e7d89 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -162,15 +162,16 @@ struct piix_host_priv {
 
 static int piix_init_one(struct pci_dev *pdev,
 			 const struct pci_device_id *ent);
-static void piix_pata_error_handler(struct ata_port *ap);
+static int piix_pata_prereset(struct ata_link *link, unsigned long deadline);
 static void piix_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static void ich_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int ich_pata_cable_detect(struct ata_port *ap);
 static u8 piix_vmw_bmdma_status(struct ata_port *ap);
+static int piix_sidpr_hardreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline);
 static int piix_sidpr_scr_read(struct ata_port *ap, unsigned int reg, u32 *val);
 static int piix_sidpr_scr_write(struct ata_port *ap, unsigned int reg, u32 val);
-static void piix_sidpr_error_handler(struct ata_port *ap);
 #ifdef CONFIG_PM
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int piix_pci_device_resume(struct pci_dev *pdev);
@@ -299,7 +300,7 @@ static struct ata_port_operations piix_pata_ops = {
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= piix_set_piomode,
 	.set_dmamode		= piix_set_dmamode,
-	.error_handler		= piix_pata_error_handler,
+	.prereset		= piix_pata_prereset,
 };
 
 static struct ata_port_operations piix_vmw_ops = {
@@ -319,9 +320,9 @@ static struct ata_port_operations piix_sata_ops = {
 
 static struct ata_port_operations piix_sidpr_sata_ops = {
 	.inherits		= &piix_sata_ops,
+	.hardreset		= piix_sidpr_hardreset,
 	.scr_read		= piix_sidpr_scr_read,
 	.scr_write		= piix_sidpr_scr_write,
-	.error_handler		= piix_sidpr_error_handler,
 };
 
 static const struct piix_map_db ich5_map_db = {
@@ -645,12 +646,6 @@ static int piix_pata_prereset(struct ata_link *link, unsigned long deadline)
 	return ata_std_prereset(link, deadline);
 }
 
-static void piix_pata_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, piix_pata_prereset, ata_std_softreset, NULL,
-			   ata_std_postreset);
-}
-
 /**
  *	piix_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
@@ -1057,12 +1052,6 @@ static int piix_sidpr_hardreset(struct ata_link *link, unsigned int *class,
 	return -EAGAIN;
 }
 
-static void piix_sidpr_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
-			   piix_sidpr_hardreset, ata_std_postreset);
-}
-
 #ifdef CONFIG_PM
 static int piix_broken_suspend(void)
 {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 685e3c7..e6d7f16 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -76,6 +76,10 @@ const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 const struct ata_port_operations ata_base_port_ops = {
 	.irq_clear		= ata_noop_irq_clear,
+	.prereset		= ata_std_prereset,
+	.hardreset		= sata_std_hardreset,
+	.postreset		= ata_std_postreset,
+	.error_handler		= ata_std_error_handler,
 };
 
 const struct ata_port_operations sata_port_ops = {
@@ -83,6 +87,11 @@ const struct ata_port_operations sata_port_ops = {
 
 	.qc_defer		= ata_std_qc_defer,
 	.dev_select		= ata_noop_dev_select,
+
+	.pmp_prereset		= sata_pmp_std_prereset,
+	.pmp_hardreset		= sata_pmp_std_hardreset,
+	.pmp_postreset		= sata_pmp_std_postreset,
+	.error_handler		= sata_pmp_error_handler,
 };
 
 const struct ata_port_operations sata_pmp_port_ops = {
@@ -97,6 +106,7 @@ const struct ata_port_operations ata_sff_port_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.softreset		= ata_std_softreset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
@@ -7666,7 +7676,6 @@ EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
 EXPORT_SYMBOL_GPL(ata_bmdma_freeze);
 EXPORT_SYMBOL_GPL(ata_bmdma_thaw);
-EXPORT_SYMBOL_GPL(ata_bmdma_drive_eh);
 EXPORT_SYMBOL_GPL(ata_bmdma_error_handler);
 EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
 EXPORT_SYMBOL_GPL(ata_port_probe);
@@ -7736,7 +7745,7 @@ EXPORT_SYMBOL_GPL(sata_pmp_qc_defer_cmd_switch);
 EXPORT_SYMBOL_GPL(sata_pmp_std_prereset);
 EXPORT_SYMBOL_GPL(sata_pmp_std_hardreset);
 EXPORT_SYMBOL_GPL(sata_pmp_std_postreset);
-EXPORT_SYMBOL_GPL(sata_pmp_do_eh);
+EXPORT_SYMBOL_GPL(sata_pmp_error_handler);
 
 EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
 EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
@@ -7754,7 +7763,7 @@ EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
 EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
-EXPORT_SYMBOL_GPL(ata_do_eh);
+EXPORT_SYMBOL_GPL(ata_std_error_handler);
 EXPORT_SYMBOL_GPL(ata_irq_on);
 EXPORT_SYMBOL_GPL(ata_dev_try_classify);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8d82b06..95e5513 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2805,30 +2805,35 @@ void ata_eh_finish(struct ata_port *ap)
 }
 
 /**
- *	ata_do_eh - do standard error handling
+ *	ata_std_error_handler - do standard error handling
  *	@ap: host port to handle error for
- *	@prereset: prereset method (can be NULL)
- *	@softreset: softreset method (can be NULL)
- *	@hardreset: hardreset method (can be NULL)
- *	@postreset: postreset method (can be NULL)
  *
  *	Perform standard error handling sequence.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
-	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-	       ata_postreset_fn_t postreset)
+void ata_std_error_handler(struct ata_port *ap)
 {
+	struct ata_port_operations *ops = ap->ops;
+	ata_reset_fn_t hardreset = ops->hardreset;
 	struct ata_device *dev;
 	int rc;
 
+	/* sata_std_hardreset is inherited to all drivers from
+	 * ata_base_port_ops.  Ignore it if SCR access is not
+	 * available.  Returning -EAGAIN from hardreset when SCR
+	 * access is unavailable achieves about the same effect but
+	 * that causes the wrong message to be printed.
+	 */
+	if (hardreset == sata_std_hardreset && !sata_scr_valid(&ap->link))
+		hardreset = NULL;
+
 	ata_eh_autopsy(ap);
 	ata_eh_report(ap);
 
-	rc = ata_eh_recover(ap, prereset, softreset, hardreset, postreset,
-			    NULL);
+	rc = ata_eh_recover(ap, ops->prereset, ops->softreset, hardreset,
+			    ops->postreset, NULL);
 	if (rc) {
 		ata_link_for_each_dev(dev, &ap->link)
 			ata_dev_disable(dev);
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 2e9eea8..19e57a7 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -962,14 +962,6 @@ static int sata_pmp_handle_link_fail(struct ata_link *link, int *link_tries)
 /**
  *	sata_pmp_eh_recover - recover PMP-enabled port
  *	@ap: ATA port to recover
- *	@prereset: prereset method (can be NULL)
- *	@softreset: softreset method
- *	@hardreset: hardreset method
- *	@postreset: postreset method (can be NULL)
- *	@pmp_prereset: PMP prereset method (can be NULL)
- *	@pmp_softreset: PMP softreset method (can be NULL)
- *	@pmp_hardreset: PMP hardreset method (can be NULL)
- *	@pmp_postreset: PMP postreset method (can be NULL)
  *
  *	Drive EH recovery operation for PMP enabled port @ap.  This
  *	function recovers host and PMP ports with proper retrials and
@@ -982,12 +974,9 @@ static int sata_pmp_handle_link_fail(struct ata_link *link, int *link_tries)
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-static int sata_pmp_eh_recover(struct ata_port *ap,
-		ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
-		ata_reset_fn_t hardreset, ata_postreset_fn_t postreset,
-		ata_prereset_fn_t pmp_prereset, ata_reset_fn_t pmp_softreset,
-		ata_reset_fn_t pmp_hardreset, ata_postreset_fn_t pmp_postreset)
+static int sata_pmp_eh_recover(struct ata_port *ap)
 {
+	struct ata_port_operations *ops = ap->ops;
 	int pmp_tries, link_tries[SATA_PMP_MAX_PORTS];
 	struct ata_link *pmp_link = &ap->link;
 	struct ata_device *pmp_dev = pmp_link->device;
@@ -1005,8 +994,8 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
  retry:
 	/* PMP attached? */
 	if (!ap->nr_pmp_links) {
-		rc = ata_eh_recover(ap, prereset, softreset, hardreset,
-				    postreset, NULL);
+		rc = ata_eh_recover(ap, ops->prereset, ops->softreset,
+				    ops->hardreset, ops->postreset, NULL);
 		if (rc) {
 			ata_link_for_each_dev(dev, &ap->link)
 				ata_dev_disable(dev);
@@ -1024,8 +1013,8 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
 	}
 
 	/* recover pmp */
-	rc = sata_pmp_eh_recover_pmp(ap, prereset, softreset, hardreset,
-				     postreset);
+	rc = sata_pmp_eh_recover_pmp(ap, ops->prereset, ops->softreset,
+				     ops->hardreset, ops->postreset);
 	if (rc)
 		goto pmp_fail;
 
@@ -1035,8 +1024,8 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
 		goto pmp_fail;
 
 	/* recover links */
-	rc = ata_eh_recover(ap, pmp_prereset, pmp_softreset, pmp_hardreset,
-			    pmp_postreset, &link);
+	rc = ata_eh_recover(ap, ops->pmp_prereset, ops->pmp_softreset,
+			    ops->pmp_hardreset, ops->pmp_postreset, &link);
 	if (rc)
 		goto link_fail;
 
@@ -1132,16 +1121,8 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
 }
 
 /**
- *	sata_pmp_do_eh - do standard error handling for PMP-enabled host
+ *	sata_pmp_error_handler - do standard error handling for PMP-enabled host
  *	@ap: host port to handle error for
- *	@prereset: prereset method (can be NULL)
- *	@softreset: softreset method
- *	@hardreset: hardreset method
- *	@postreset: postreset method (can be NULL)
- *	@pmp_prereset: PMP prereset method (can be NULL)
- *	@pmp_softreset: PMP softreset method (can be NULL)
- *	@pmp_hardreset: PMP hardreset method (can be NULL)
- *	@pmp_postreset: PMP postreset method (can be NULL)
  *
  *	Perform standard error handling sequence for PMP-enabled host
  *	@ap.
@@ -1149,16 +1130,10 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void sata_pmp_do_eh(struct ata_port *ap,
-		ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
-		ata_reset_fn_t hardreset, ata_postreset_fn_t postreset,
-		ata_prereset_fn_t pmp_prereset, ata_reset_fn_t pmp_softreset,
-		ata_reset_fn_t pmp_hardreset, ata_postreset_fn_t pmp_postreset)
+void sata_pmp_error_handler(struct ata_port *ap)
 {
 	ata_eh_autopsy(ap);
 	ata_eh_report(ap);
-	sata_pmp_eh_recover(ap, prereset, softreset, hardreset, postreset,
-			    pmp_prereset, pmp_softreset, pmp_hardreset,
-			    pmp_postreset);
+	sata_pmp_eh_recover(ap);
 	ata_eh_finish(ap);
 }
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 538b4af..4132667 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -389,27 +389,18 @@ void ata_bmdma_thaw(struct ata_port *ap)
 }
 
 /**
- *	ata_bmdma_drive_eh - Perform EH with given methods for BMDMA controller
+ *	ata_bmdma_error_handler - Stock error handler for BMDMA controller
  *	@ap: port to handle error for
- *	@prereset: prereset method (can be NULL)
- *	@softreset: softreset method (can be NULL)
- *	@hardreset: hardreset method (can be NULL)
- *	@postreset: postreset method (can be NULL)
  *
- *	Handle error for ATA BMDMA controller.  It can handle both
+ *	Stock error handler for BMDMA controller.  It can handle both
  *	PATA and SATA controllers.  Many controllers should be able to
  *	use this EH as-is or with some added handling before and
  *	after.
  *
- *	This function is intended to be used for constructing
- *	->error_handler callback by low level drivers.
- *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
-			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-			ata_postreset_fn_t postreset)
+void ata_bmdma_error_handler(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
@@ -453,28 +444,7 @@ void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		ata_eh_thaw_port(ap);
 
 	/* PIO and DMA engines have been stopped, perform recovery */
-	ata_do_eh(ap, prereset, softreset, hardreset, postreset);
-}
-
-/**
- *	ata_bmdma_error_handler - Stock error handler for BMDMA controller
- *	@ap: port to handle error for
- *
- *	Stock error handler for BMDMA controller.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- */
-void ata_bmdma_error_handler(struct ata_port *ap)
-{
-	ata_reset_fn_t hardreset;
-
-	hardreset = NULL;
-	if (sata_scr_valid(&ap->link))
-		hardreset = sata_std_hardreset;
-
-	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
-			   ata_std_postreset);
+	ata_std_error_handler(ap);
 }
 
 /**
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 7dd28fd..d337f32 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -68,20 +68,6 @@ static int pacpi_cable_detect(struct ata_port *ap)
 }
 
 /**
- *	pacpi_error_handler - Setup and error handler
- *	@ap: Port to handle
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void pacpi_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, pacpi_pre_reset, ata_std_softreset,
-				  NULL, ata_std_postreset);
-}
-
-/**
  *	pacpi_discover_modes	-	filter non ACPI modes
  *	@adev: ATA device
  *	@mask: proposed modes
@@ -242,7 +228,7 @@ static struct ata_port_operations pacpi_ops = {
 	.mode_filter		= pacpi_mode_filter,
 	.set_piomode		= pacpi_set_piomode,
 	.set_dmamode		= pacpi_set_dmamode,
-	.error_handler		= pacpi_error_handler,
+	.prereset		= pacpi_pre_reset,
 	.port_start		= pacpi_port_start,
 };
 
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index a7013c9..24fb14d 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -144,13 +144,6 @@ static int amd_pre_reset(struct ata_link *link, unsigned long deadline)
 	return ata_std_prereset(link, deadline);
 }
 
-static void amd_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, amd_pre_reset,
-				      ata_std_softreset, NULL,
-				      ata_std_postreset);
-}
-
 static int amd_cable_detect(struct ata_port *ap)
 {
 	static const u32 bitmask[2] = {0x03, 0x0C};
@@ -301,13 +294,6 @@ static int nv_pre_reset(struct ata_link *link, unsigned long deadline)
 	return ata_std_prereset(link, deadline);
 }
 
-static void nv_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, nv_pre_reset,
-			       ata_std_softreset, NULL,
-			       ata_std_postreset);
-}
-
 /**
  *	nv100_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -359,7 +345,7 @@ static struct scsi_host_template amd_sht = {
 
 static const struct ata_port_operations amd_base_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
-	.error_handler	= amd_error_handler,
+	.prereset	= amd_pre_reset,
 };
 
 static struct ata_port_operations amd33_port_ops = {
@@ -394,7 +380,7 @@ static const struct ata_port_operations nv_base_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 	.cable_detect	= ata_cable_ignore,
 	.mode_filter	= nv_mode_filter,
-	.error_handler	= nv_error_handler,
+	.prereset	= nv_pre_reset,
 	.host_stop	= nv_host_stop,
 };
 
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index ebd15ca..b6d8c4d 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -56,21 +56,6 @@ static int artop6210_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	artop6210_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void artop6210_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, artop6210_pre_reset,
-				    ata_std_softreset, NULL,
-				    ata_std_postreset);
-}
-
-/**
  *	artop6260_pre_reset	-	check for 40/80 pin
  *	@link: link
  *	@deadline: deadline jiffies for the operation
@@ -114,21 +99,6 @@ static int artop6260_cable_detect(struct ata_port *ap)
 }
 
 /**
- *	artop6260_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void artop6260_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, artop6260_pre_reset,
-				    ata_std_softreset, NULL,
-				    ata_std_postreset);
-}
-
-/**
  *	artop6210_load_piomode - Load a set of PATA PIO timings
  *	@ap: Port whose timings we are configuring
  *	@adev: Device
@@ -322,7 +292,7 @@ static struct ata_port_operations artop6210_ops = {
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= artop6210_set_piomode,
 	.set_dmamode		= artop6210_set_dmamode,
-	.error_handler		= artop6210_error_handler,
+	.prereset		= artop6210_pre_reset,
 };
 
 static struct ata_port_operations artop6260_ops = {
@@ -330,7 +300,7 @@ static struct ata_port_operations artop6260_ops = {
 	.cable_detect		= artop6260_cable_detect,
 	.set_piomode		= artop6260_set_piomode,
 	.set_dmamode		= artop6260_set_dmamode,
-	.error_handler		= artop6260_error_handler,
+	.prereset		= artop6260_pre_reset,
 };
 
 
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index ac6c79d..4e1f545 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -48,11 +48,6 @@ static int atiixp_pre_reset(struct ata_link *link, unsigned long deadline)
 	return ata_std_prereset(link, deadline);
 }
 
-static void atiixp_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, atiixp_pre_reset, ata_std_softreset, NULL,   ata_std_postreset);
-}
-
 static int atiixp_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
@@ -233,7 +228,7 @@ static struct ata_port_operations atiixp_port_ops = {
 	.cable_detect	= atiixp_cable_detect,
 	.set_piomode	= atiixp_set_piomode,
 	.set_dmamode	= atiixp_set_dmamode,
-	.error_handler	= atiixp_error_handler,
+	.prereset	= atiixp_pre_reset,
 };
 
 static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 7a22ef4..eea275a 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1314,17 +1314,6 @@ static void bfin_std_postreset(struct ata_link *link, unsigned int *classes)
 	write_atapi_register(base, ATA_REG_CTRL, ap->ctl);
 }
 
-/**
- *	bfin_error_handler - Stock error handler for DMA controller
- *	@ap: port to handle error for
- */
-
-static void bfin_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ata_std_prereset, bfin_std_softreset, NULL,
-			   bfin_std_postreset);
-}
-
 static void bfin_port_stop(struct ata_port *ap)
 {
 	dev_dbg(ap->dev, "in atapi port stop\n");
@@ -1385,7 +1374,8 @@ static const struct ata_port_operations bfin_pata_ops = {
 
 	.freeze			= bfin_bmdma_freeze,
 	.thaw			= bfin_bmdma_thaw,
-	.error_handler		= bfin_error_handler,
+	.softreset		= bfin_std_softreset,
+	.postreset		= bfin_std_postreset,
 	.post_internal_cmd	= bfin_bmdma_stop,
 
 	.irq_clear		= bfin_irq_clear,
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index 2f5b484..1d839a5 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -49,19 +49,6 @@ static int efar_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	efar_probe_reset - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void efar_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, efar_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	efar_cable_detect	-	check for 40/80 pin
  *	@ap: Port
  *
@@ -241,7 +228,7 @@ static struct ata_port_operations efar_ops = {
 	.cable_detect		= efar_cable_detect,
 	.set_piomode		= efar_set_piomode,
 	.set_dmamode		= efar_set_dmamode,
-	.error_handler		= efar_error_handler,
+	.prereset		= efar_pre_reset,
 };
 
 
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 591726a..ff48936 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -341,19 +341,7 @@ static int hpt37x_pre_reset(struct ata_link *link, unsigned long deadline)
 	return ata_std_prereset(link, deadline);
 }
 
-/**
- *	hpt37x_error_handler	-	reset the hpt374
- *	@ap: ATA port to reset
- *
- *	Perform probe for HPT37x, except for HPT374 channel 2
- */
-
-static void hpt37x_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, hpt37x_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-static int hpt374_pre_reset(struct ata_link *link, unsigned long deadline)
+static int hpt374_fn1_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	static const struct pci_bits hpt37x_enable_bits[] = {
 		{ 0x50, 1, 0x04, 0x04 },
@@ -390,25 +378,6 @@ static int hpt374_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	hpt374_error_handler	-	reset the hpt374
- *	@classes:
- *
- *	The 374 cable detect is a little different due to the extra
- *	channels. The function 0 channels work like usual but function 1
- *	is special
- */
-
-static void hpt374_error_handler(struct ata_port *ap)
-{
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-
-	if (!(PCI_FUNC(pdev->devfn) & 1))
-		hpt37x_error_handler(ap);
-	else
-		ata_bmdma_drive_eh(ap, hpt374_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	hpt370_set_piomode		-	PIO setup
  *	@ap: ATA interface
  *	@adev: device on the interface
@@ -635,7 +604,7 @@ static struct ata_port_operations hpt370_port_ops = {
 	.mode_filter	= hpt370_filter,
 	.set_piomode	= hpt370_set_piomode,
 	.set_dmamode	= hpt370_set_dmamode,
-	.error_handler	= hpt37x_error_handler,
+	.prereset	= hpt37x_pre_reset,
 };
 
 /*
@@ -659,17 +628,17 @@ static struct ata_port_operations hpt372_port_ops = {
 
 	.set_piomode	= hpt372_set_piomode,
 	.set_dmamode	= hpt372_set_dmamode,
-	.error_handler	= hpt37x_error_handler,
+	.prereset	= hpt37x_pre_reset,
 };
 
 /*
  *	Configuration for HPT374. Mode setting works like 372 and friends
- *	but we have a different cable detection procedure.
+ *	but we have a different cable detection procedure for function 1.
  */
 
-static struct ata_port_operations hpt374_port_ops = {
+static struct ata_port_operations hpt374_fn1_port_ops = {
 	.inherits	= &hpt372_port_ops,
-	.error_handler	= hpt374_error_handler,
+	.prereset	= hpt374_fn1_pre_reset,
 };
 
 /**
@@ -821,13 +790,20 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.udma_mask = ATA_UDMA6,
 		.port_ops = &hpt372_port_ops
 	};
-	/* HPT374 - UDMA100 */
-	static const struct ata_port_info info_hpt374 = {
+	/* HPT374 - UDMA100, function 1 uses different prereset method */
+	static const struct ata_port_info info_hpt374_fn0 = {
+		.flags = ATA_FLAG_SLAVE_POSS,
+		.pio_mask = 0x1f,
+		.mwdma_mask = 0x07,
+		.udma_mask = ATA_UDMA5,
+		.port_ops = &hpt372_port_ops
+	};
+	static const struct ata_port_info info_hpt374_fn1 = {
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = ATA_UDMA5,
-		.port_ops = &hpt374_port_ops
+		.port_ops = &hpt374_fn1_port_ops
 	};
 
 	static const int MHz[4] = { 33, 40, 50, 66 };
@@ -912,7 +888,10 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 				break;
 			case PCI_DEVICE_ID_TTI_HPT374:
 				chip_table = &hpt374;
-				ppi[0] = &info_hpt374;
+				if (!(PCI_FUNC(dev->devfn) & 1))
+					*ppi = &info_hpt374_fn0;
+				else
+					*ppi = &info_hpt374_fn1;
 				break;
 			default:
 				printk(KERN_ERR "pata_hpt37x: PCI table is bogus please report (%d).\n", dev->device);
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index c774be9..cd44ee3 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -148,7 +148,7 @@ static int hpt3x2n_cable_detect(struct ata_port *ap)
  *	Reset the hardware and state machine,
  */
 
-static int hpt3xn_pre_reset(struct ata_link *link, unsigned long deadline)
+static int hpt3x2n_pre_reset(struct ata_link *link, unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
@@ -160,18 +160,6 @@ static int hpt3xn_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	hpt3x2n_error_handler	-	probe the hpt3x2n bus
- *	@ap: ATA port to reset
- *
- *	Perform the probe reset handling for the 3x2N
- */
-
-static void hpt3x2n_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, hpt3xn_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	hpt3x2n_set_piomode		-	PIO setup
  *	@ap: ATA interface
  *	@adev: device on the interface
@@ -355,7 +343,7 @@ static struct ata_port_operations hpt3x2n_port_ops = {
 	.cable_detect	= hpt3x2n_cable_detect,
 	.set_piomode	= hpt3x2n_set_piomode,
 	.set_dmamode	= hpt3x2n_set_dmamode,
-	.error_handler	= hpt3x2n_error_handler,
+	.prereset	= hpt3x2n_pre_reset,
 };
 
 /**
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index f0ec997..340d86a 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -338,12 +338,6 @@ static void pata_icside_postreset(struct ata_link *link, unsigned int *classes)
 	}
 }
 
-static void pata_icside_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL,
-			   pata_icside_postreset);
-}
-
 static struct ata_port_operations pata_icside_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 	/* no need to build any PRD tables for DMA */
@@ -356,7 +350,7 @@ static struct ata_port_operations pata_icside_port_ops = {
 
 	.cable_detect		= ata_cable_40wire,
 	.set_dmamode		= pata_icside_set_dmamode,
-	.error_handler		= pata_icside_error_handler,
+	.postreset		= pata_icside_postreset,
 	.post_internal_cmd	= pata_icside_bmdma_stop,
 
 	.port_start		= pata_icside_port_start,
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index d23a46b..84ab89e 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -44,19 +44,6 @@ static int it8213_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	it8213_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void it8213_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, it8213_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	it8213_cable_detect	-	check for 40/80 pin
  *	@ap: Port
  *
@@ -252,7 +239,7 @@ static struct ata_port_operations it8213_ops = {
 	.cable_detect		= it8213_cable_detect,
 	.set_piomode		= it8213_set_piomode,
 	.set_dmamode		= it8213_set_dmamode,
-	.error_handler		= it8213_error_handler,
+	.prereset		= it8213_pre_reset,
 };
 
 
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 530eef9..317f347 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -105,19 +105,6 @@ static int jmicron_pre_reset(struct ata_link *link, unsigned long deadline)
 	return ata_std_prereset(link, deadline);
 }
 
-/**
- *	jmicron_error_handler - Setup and error handler
- *	@ap: Port to handle
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void jmicron_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, jmicron_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 /* No PIO or DMA methods needed for this device */
 
 static struct scsi_host_template jmicron_sht = {
@@ -126,7 +113,7 @@ static struct scsi_host_template jmicron_sht = {
 
 static struct ata_port_operations jmicron_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.error_handler		= jmicron_error_handler,
+	.prereset		= jmicron_pre_reset,
 };
 
 
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 9a51a97..d38e64c 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -75,20 +75,6 @@ static int marvell_cable_detect(struct ata_port *ap)
 	return 0;	/* Our BUG macro needs the right markup */
 }
 
-/**
- *	marvell_error_handler - Setup and error handler
- *	@ap: Port to handle
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void marvell_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, marvell_pre_reset, ata_std_softreset,
-				  NULL, ata_std_postreset);
-}
-
 /* No PIO or DMA methods needed for this device */
 
 static struct scsi_host_template marvell_sht = {
@@ -98,7 +84,7 @@ static struct scsi_host_template marvell_sht = {
 static struct ata_port_operations marvell_ops = {
 	.inherits		= &ata_bmdma_port_ops,
 	.cable_detect		= marvell_cable_detect,
-	.error_handler		= marvell_error_handler,
+	.prereset		= marvell_pre_reset,
 };
 
 
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index ac7c082..fec9319 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -255,15 +255,6 @@ mpc52xx_ata_dev_select(struct ata_port *ap, unsigned int device)
 	ata_std_dev_select(ap,device);
 }
 
-static void
-mpc52xx_ata_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL,
-			ata_std_postreset);
-}
-
-
-
 static struct scsi_host_template mpc52xx_ata_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
@@ -273,7 +264,6 @@ static struct ata_port_operations mpc52xx_ata_port_ops = {
 	.dev_select		= mpc52xx_ata_dev_select,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= mpc52xx_ata_set_piomode,
-	.error_handler		= mpc52xx_ata_error_handler,
 	.post_internal_cmd	= ATA_OP_NULL,
 };
 
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index dab54f8..1b9d0d4 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -59,20 +59,6 @@ static int mpiix_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	mpiix_error_handler		-	probe reset
- *	@ap: ATA port
- *
- *	Perform the ATA probe and bus reset sequence plus specific handling
- *	for this hardware. The MPIIX has the enable bits in a different place
- *	to PIIX4 and friends. As a pure PIO device it has no cable detect
- */
-
-static void mpiix_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, mpiix_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	mpiix_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
  *	@adev: ATA device
@@ -159,7 +145,7 @@ static struct ata_port_operations mpiix_port_ops = {
 	.qc_issue	= mpiix_qc_issue_prot,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= mpiix_set_piomode,
-	.error_handler	= mpiix_error_handler,
+	.prereset	= mpiix_pre_reset,
 };
 
 static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 5a043e4..4d2eefe 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -54,20 +54,6 @@ static int ns87410_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	ns87410_error_handler		-	probe reset
- *	@ap: ATA port
- *
- *	Perform the ATA probe and bus reset sequence plus specific handling
- *	for this hardware. The MPIIX has the enable bits in a different place
- *	to PIIX4 and friends. As a pure PIO device it has no cable detect
- */
-
-static void ns87410_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ns87410_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	ns87410_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
  *	@adev: ATA device
@@ -152,7 +138,7 @@ static struct ata_port_operations ns87410_port_ops = {
 	.qc_issue	= ns87410_qc_issue_prot,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= ns87410_set_piomode,
-	.error_handler	= ns87410_error_handler,
+	.prereset	= ns87410_pre_reset,
 };
 
 static int ns87410_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 7001b75..c1da79a 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -51,20 +51,6 @@ static int oldpiix_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	oldpiix_pata_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *	@classes:
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void oldpiix_pata_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, oldpiix_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	oldpiix_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
  *	@adev: Device whose timings we are configuring
@@ -229,7 +215,7 @@ static struct ata_port_operations oldpiix_pata_ops = {
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= oldpiix_set_piomode,
 	.set_dmamode		= oldpiix_set_dmamode,
-	.error_handler		= oldpiix_pata_error_handler,
+	.prereset		= oldpiix_pre_reset,
 };
 
 
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 5a5f20e..4ddd03a 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -68,21 +68,6 @@ static int opti_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	opti_probe_reset		-	probe reset
- *	@ap: ATA port
- *
- *	Perform the ATA probe and bus reset sequence plus specific handling
- *	for this hardware. The Opti needs little handling - we have no UDMA66
- *	capability that needs cable detection. All we must do is check the port
- *	is enabled.
- */
-
-static void opti_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, opti_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	opti_write_reg		-	control register setup
  *	@ap: ATA port
  *	@value: value
@@ -172,7 +157,7 @@ static struct ata_port_operations opti_port_ops = {
 	.inherits	= &ata_sff_port_ops,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= opti_set_piomode,
-	.error_handler	= opti_error_handler,
+	.prereset	= opti_pre_reset,
 };
 
 static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index ba2819f..36ac147 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -68,21 +68,6 @@ static int optidma_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	optidma_probe_reset		-	probe reset
- *	@ap: ATA port
- *
- *	Perform the ATA probe and bus reset sequence plus specific handling
- *	for this hardware. The Opti needs little handling - we have no UDMA66
- *	capability that needs cable detection. All we must do is check the port
- *	is enabled.
- */
-
-static void optidma_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, optidma_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	optidma_unlock		-	unlock control registers
  *	@ap: ATA port
  *
@@ -359,7 +344,7 @@ static struct ata_port_operations optidma_port_ops = {
 	.set_piomode	= optidma_set_pio_mode,
 	.set_dmamode	= optidma_set_dma_mode,
 	.set_mode	= optidma_set_mode,
-	.error_handler	= optidma_error_handler,
+	.prereset	= optidma_pre_reset,
 };
 
 static struct ata_port_operations optiplus_port_ops = {
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index baa9fa7..d591e21 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -63,7 +63,7 @@ enum {
 };
 
 static int pdc2027x_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-static void pdc2027x_error_handler(struct ata_port *ap);
+static int pdc2027x_prereset(struct ata_link *link, unsigned long deadline);
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);
@@ -136,7 +136,7 @@ static struct ata_port_operations pdc2027x_pata100_ops = {
 	.inherits		= &ata_bmdma_port_ops,
 	.check_atapi_dma	= pdc2027x_check_atapi_dma,
 	.cable_detect		= pdc2027x_cable_detect,
-	.error_handler		= pdc2027x_error_handler,
+	.prereset		= pdc2027x_prereset,
 };
 
 static struct ata_port_operations pdc2027x_pata133_ops = {
@@ -252,21 +252,6 @@ static int pdc2027x_prereset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	pdc2027x_error_handler - Perform reset on PATA port and classify
- *	@ap: Port to reset
- *
- *	Reset PATA phy and classify attached devices.
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void pdc2027x_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, pdc2027x_prereset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	pdc2720x_mode_filter	-	mode selection filter
  *	@adev: ATA device
  *	@mask: list of modes proposed
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index d643d49..7def1e0 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -905,17 +905,6 @@ static void scc_std_postreset(struct ata_link *link, unsigned int *classes)
 }
 
 /**
- *	scc_error_handler - Stock error handler for BMDMA controller
- *	@ap: port to handle error for
- */
-
-static void scc_error_handler (struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, scc_pata_prereset, scc_std_softreset, NULL,
-			   scc_std_postreset);
-}
-
-/**
  *	scc_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
  *	@ap: Port associated with this ATA transaction.
  *
@@ -993,7 +982,9 @@ static const struct ata_port_operations scc_pata_ops = {
 
 	.freeze			= scc_bmdma_freeze,
 	.thaw			= ATA_OP_NULL,
-	.error_handler		= scc_error_handler,
+	.prereset		= scc_pata_prereset,
+	.softreset		= scc_std_softreset,
+	.postreset		= scc_std_postreset,
 	.post_internal_cmd	= scc_bmdma_stop,
 
 	.irq_clear		= scc_bmdma_irq_clear,
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 28abfc2..793e671 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -161,19 +161,6 @@ static int sis_pre_reset(struct ata_link *link, unsigned long deadline)
 
 
 /**
- *	sis_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void sis_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, sis_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	sis_set_fifo	-	Set RWP fifo bits for this device
  *	@ap: Port
  *	@adev: Device
@@ -526,7 +513,7 @@ static struct ata_port_operations sis_133_for_sata_ops = {
 
 static struct ata_port_operations sis_base_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.error_handler		= sis_error_handler,
+	.prereset		= sis_pre_reset,
 };
 
 static struct ata_port_operations sis_133_ops = {
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 1d97f92..bee11ca 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -64,12 +64,6 @@ static int sl82c105_pre_reset(struct ata_link *link, unsigned long deadline)
 }
 
 
-static void sl82c105_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, sl82c105_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-
 /**
  *	sl82c105_configure_piomode	-	set chip PIO timing
  *	@ap: ATA interface
@@ -245,7 +239,7 @@ static struct ata_port_operations sl82c105_port_ops = {
 	.bmdma_stop	= sl82c105_bmdma_stop,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= sl82c105_set_piomode,
-	.error_handler	= sl82c105_error_handler,
+	.prereset	= sl82c105_pre_reset,
 };
 
 /**
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index f07b0e5..bd546a3 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -71,11 +71,6 @@ static int triflex_prereset(struct ata_link *link, unsigned long deadline)
 
 
 
-static void triflex_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, triflex_prereset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 /**
  *	triflex_load_timing		-	timing configuration
  *	@ap: ATA interface
@@ -189,7 +184,7 @@ static struct ata_port_operations triflex_port_ops = {
 	.bmdma_stop	= triflex_bmdma_stop,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= triflex_set_piomode,
-	.error_handler	= triflex_error_handler,
+	.prereset	= triflex_prereset,
 };
 
 static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 29612c9..e2d7fba 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -211,18 +211,6 @@ static int via_pre_reset(struct ata_link *link, unsigned long deadline)
 
 
 /**
- *	via_error_handler		-	reset for VIA chips
- *	@ap: ATA port
- *
- *	Handle the reset callback for the later chips with cable detect
- */
-
-static void via_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, via_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	via_do_set_mode	-	set initial PIO mode data
  *	@ap: ATA interface
  *	@adev: ATA device
@@ -339,7 +327,7 @@ static struct ata_port_operations via_port_ops = {
 	.cable_detect	= via_cable_detect,
 	.set_piomode	= via_set_piomode,
 	.set_dmamode	= via_set_dmamode,
-	.error_handler	= via_error_handler,
+	.prereset	= via_pre_reset,
 };
 
 static struct ata_port_operations via_port_ops_noirq = {
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index a570614..5ed065d 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -140,7 +140,7 @@ static void adma_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 adma_bmdma_status(struct ata_port *ap);
 static void adma_freeze(struct ata_port *ap);
 static void adma_thaw(struct ata_port *ap);
-static void adma_error_handler(struct ata_port *ap);
+static int adma_prereset(struct ata_link *link, unsigned long deadline);
 
 static struct scsi_host_template adma_ata_sht = {
 	ATA_BASE_SHT(DRV_NAME),
@@ -166,7 +166,8 @@ static struct ata_port_operations adma_ata_ops = {
 
 	.freeze			= adma_freeze,
 	.thaw			= adma_thaw,
-	.error_handler		= adma_error_handler,
+	.prereset		= adma_prereset,
+	.softreset		= ata_std_softreset,
 
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
@@ -292,12 +293,6 @@ static int adma_prereset(struct ata_link *link, unsigned long deadline)
 	return ata_std_prereset(link, deadline);
 }
 
-static void adma_error_handler(struct ata_port *ap)
-{
-	ata_do_eh(ap, adma_prereset, ata_std_softreset, NULL,
-		  ata_std_postreset);
-}
-
 static int adma_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg;
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index e1aec85..20048a0 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -923,16 +923,6 @@ err:
 	return -EIO;
 }
 
-static void sata_fsl_error_handler(struct ata_port *ap)
-{
-
-	DPRINTK("in xx_error_handler\n");
-
-	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, sata_fsl_softreset, sata_std_hardreset,
-		  ata_std_postreset);
-}
-
 static void sata_fsl_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	if (qc->flags & ATA_QCFLAG_FAILED)
@@ -1224,7 +1214,7 @@ static const struct ata_port_operations sata_fsl_ops = {
 
 	.freeze = sata_fsl_freeze,
 	.thaw = sata_fsl_thaw,
-	.error_handler = sata_fsl_error_handler,
+	.softreset = sata_fsl_softreset,
 	.post_internal_cmd = sata_fsl_post_internal_cmd,
 
 	.port_start = sata_fsl_port_start,
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 047f80f..ba1c099 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -452,8 +452,7 @@ static void inic_error_handler(struct ata_port *ap)
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	/* PIO and DMA engines have been stopped, perform recovery */
-	ata_do_eh(ap, ata_std_prereset, NULL, inic_hardreset,
-		  ata_std_postreset);
+	ata_std_error_handler(ap);
 }
 
 static void inic_post_internal_cmd(struct ata_queued_cmd *qc)
@@ -532,6 +531,8 @@ static struct ata_port_operations inic_port_ops = {
 
 	.freeze			= inic_freeze,
 	.thaw			= inic_thaw,
+	.softreset		= ATA_OP_NULL,	/* softreset is broken */
+	.hardreset		= inic_hardreset,
 	.error_handler		= inic_error_handler,
 	.post_internal_cmd	= inic_post_internal_cmd,
 	.dev_config		= inic_dev_config,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 2e6d368..b0fbab9 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -470,7 +470,10 @@ static void mv_port_stop(struct ata_port *ap);
 static void mv_qc_prep(struct ata_queued_cmd *qc);
 static void mv_qc_prep_iie(struct ata_queued_cmd *qc);
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
-static void mv_error_handler(struct ata_port *ap);
+static int mv_prereset(struct ata_link *link, unsigned long deadline);
+static int mv_hardreset(struct ata_link *link, unsigned int *class,
+			unsigned long deadline);
+static void mv_postreset(struct ata_link *link, unsigned int *classes);
 static void mv_eh_freeze(struct ata_port *ap);
 static void mv_eh_thaw(struct ata_port *ap);
 static void mv6_dev_config(struct ata_device *dev);
@@ -534,7 +537,10 @@ static struct ata_port_operations mv5_ops = {
 
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
-	.error_handler		= mv_error_handler,
+	.prereset		= mv_prereset,
+	.hardreset		= mv_hardreset,
+	.postreset		= mv_postreset,
+	.error_handler		= ata_std_error_handler, /* avoid SFF EH */
 	.post_internal_cmd	= ATA_OP_NULL,
 
 	.scr_read		= mv5_scr_read,
@@ -2417,12 +2423,6 @@ static void mv_postreset(struct ata_link *link, unsigned int *classes)
 	iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
 }
 
-static void mv_error_handler(struct ata_port *ap)
-{
-	ata_do_eh(ap, mv_prereset, ata_std_softreset,
-		  mv_hardreset, mv_postreset);
-}
-
 static void mv_eh_freeze(struct ata_port *ap)
 {
 	struct mv_host_priv *hpriv = ap->host->private_data;
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 5637b08..b2eb572 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -309,7 +309,8 @@ static void nv_nf2_freeze(struct ata_port *ap);
 static void nv_nf2_thaw(struct ata_port *ap);
 static void nv_ck804_freeze(struct ata_port *ap);
 static void nv_ck804_thaw(struct ata_port *ap);
-static void nv_error_handler(struct ata_port *ap);
+static int nv_hardreset(struct ata_link *link, unsigned int *class,
+			unsigned long deadline);
 static int nv_adma_slave_config(struct scsi_device *sdev);
 static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
@@ -406,7 +407,7 @@ static struct scsi_host_template nv_swncq_sht = {
 
 static struct ata_port_operations nv_generic_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.error_handler		= nv_error_handler,
+	.hardreset		= nv_hardreset,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 };
@@ -1599,12 +1600,6 @@ static int nv_hardreset(struct ata_link *link, unsigned int *class,
 	return sata_std_hardreset(link, &dummy, deadline);
 }
 
-static void nv_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
-			   nv_hardreset, ata_std_postreset);
-}
-
 static void nv_adma_error_handler(struct ata_port *ap)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
@@ -1658,8 +1653,7 @@ static void nv_adma_error_handler(struct ata_port *ap)
 		readw(mmio + NV_ADMA_CTL);	/* flush posted write */
 	}
 
-	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
-			   nv_hardreset, ata_std_postreset);
+	ata_bmdma_error_handler(ap);
 }
 
 static void nv_swncq_qc_to_dq(struct ata_port *ap, struct ata_queued_cmd *qc)
@@ -1785,8 +1779,7 @@ static void nv_swncq_error_handler(struct ata_port *ap)
 		ehc->i.action |= ATA_EH_RESET;
 	}
 
-	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
-			   nv_hardreset, ata_std_postreset);
+	ata_bmdma_error_handler(ap);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 71fddef..4dec8a1 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -146,8 +146,7 @@ static void pdc_irq_clear(struct ata_port *ap);
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 static void pdc_freeze(struct ata_port *ap);
 static void pdc_thaw(struct ata_port *ap);
-static void pdc_pata_error_handler(struct ata_port *ap);
-static void pdc_sata_error_handler(struct ata_port *ap);
+static void pdc_error_handler(struct ata_port *ap);
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
 static int pdc_pata_cable_detect(struct ata_port *ap);
 static int pdc_sata_cable_detect(struct ata_port *ap);
@@ -171,12 +170,12 @@ static const struct ata_port_operations pdc_common_ops = {
 	.freeze			= pdc_freeze,
 	.thaw			= pdc_thaw,
 	.post_internal_cmd	= pdc_post_internal_cmd,
+	.error_handler		= pdc_error_handler,
 };
 
 static struct ata_port_operations pdc_sata_ops = {
 	.inherits		= &pdc_common_ops,
 	.cable_detect		= pdc_sata_cable_detect,
-	.error_handler		= pdc_sata_error_handler,
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_sata_port_start,
@@ -191,7 +190,6 @@ static struct ata_port_operations pdc_old_sata_ops = {
 static struct ata_port_operations pdc_pata_ops = {
 	.inherits		= &pdc_common_ops,
 	.cable_detect		= pdc_pata_cable_detect,
-	.error_handler		= pdc_pata_error_handler,
 	.port_start		= pdc_common_port_start,
 };
 
@@ -612,24 +610,12 @@ static void pdc_thaw(struct ata_port *ap)
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }
 
-static void pdc_common_error_handler(struct ata_port *ap, ata_reset_fn_t hardreset)
+static void pdc_error_handler(struct ata_port *ap)
 {
 	if (!(ap->pflags & ATA_PFLAG_FROZEN))
 		pdc_reset_port(ap);
 
-	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
-		  ata_std_postreset);
-}
-
-static void pdc_pata_error_handler(struct ata_port *ap)
-{
-	pdc_common_error_handler(ap, NULL);
-}
-
-static void pdc_sata_error_handler(struct ata_port *ap)
-{
-	pdc_common_error_handler(ap, sata_std_hardreset);
+	ata_std_error_handler(ap);
 }
 
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 107ef09..2ceb099 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -123,6 +123,7 @@ static void qs_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 qs_bmdma_status(struct ata_port *ap);
 static void qs_freeze(struct ata_port *ap);
 static void qs_thaw(struct ata_port *ap);
+static int qs_prereset(struct ata_link *link, unsigned long deadline);
 static void qs_error_handler(struct ata_port *ap);
 
 static struct scsi_host_template qs_ata_sht = {
@@ -142,6 +143,8 @@ static struct ata_port_operations qs_ata_ops = {
 
 	.freeze			= qs_freeze,
 	.thaw			= qs_thaw,
+	.prereset		= qs_prereset,
+	.softreset		= ATA_OP_NULL,
 	.error_handler		= qs_error_handler,
 	.post_internal_cmd	= ATA_OP_NULL,
 
@@ -250,8 +253,7 @@ static int qs_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 static void qs_error_handler(struct ata_port *ap)
 {
 	qs_enter_reg_mode(ap);
-	ata_do_eh(ap, qs_prereset, NULL, sata_std_hardreset,
-		  ata_std_postreset);
+	ata_std_error_handler(ap);
 }
 
 static int qs_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index d90d328..f0bdf06 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -352,6 +352,14 @@ static void sil24_pmp_attach(struct ata_port *ap);
 static void sil24_pmp_detach(struct ata_port *ap);
 static void sil24_freeze(struct ata_port *ap);
 static void sil24_thaw(struct ata_port *ap);
+static int sil24_softreset(struct ata_link *link, unsigned int *class,
+			   unsigned long deadline);
+static int sil24_hardreset(struct ata_link *link, unsigned int *class,
+			   unsigned long deadline);
+static int sil24_pmp_softreset(struct ata_link *link, unsigned int *class,
+			       unsigned long deadline);
+static int sil24_pmp_hardreset(struct ata_link *link, unsigned int *class,
+			       unsigned long deadline);
 static void sil24_error_handler(struct ata_port *ap);
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
 static int sil24_port_start(struct ata_port *ap);
@@ -402,6 +410,10 @@ static struct ata_port_operations sil24_ops = {
 
 	.freeze			= sil24_freeze,
 	.thaw			= sil24_thaw,
+	.softreset		= sil24_softreset,
+	.hardreset		= sil24_hardreset,
+	.pmp_softreset		= sil24_pmp_softreset,
+	.pmp_hardreset		= sil24_pmp_hardreset,
 	.error_handler		= sil24_error_handler,
 	.post_internal_cmd	= sil24_post_internal_cmd,
 	.dev_config		= sil24_dev_config,
@@ -1181,11 +1193,7 @@ static void sil24_error_handler(struct ata_port *ap)
 	if (sil24_init_port(ap))
 		ata_eh_freeze_port(ap);
 
-	/* perform recovery */
-	sata_pmp_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
-		       ata_std_postreset, sata_pmp_std_prereset,
-		       sil24_pmp_softreset, sil24_pmp_hardreset,
-		       sata_pmp_std_postreset);
+	sata_pmp_error_handler(ap);
 
 	pp->do_port_rst = 0;
 }
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 57026fe..402fd73 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -71,7 +71,7 @@ static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int svia_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
 static int svia_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void svia_noop_freeze(struct ata_port *ap);
-static void vt6420_error_handler(struct ata_port *ap);
+static int vt6420_prereset(struct ata_link *link, unsigned long deadline);
 static int vt6421_pata_cable_detect(struct ata_port *ap);
 static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev);
 static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev);
@@ -106,7 +106,7 @@ static struct scsi_host_template svia_sht = {
 static struct ata_port_operations vt6420_sata_ops = {
 	.inherits		= &ata_bmdma_port_ops,
 	.freeze			= svia_noop_freeze,
-	.error_handler		= vt6420_error_handler,
+	.prereset		= vt6420_prereset,
 };
 
 static struct ata_port_operations vt6421_pata_ops = {
@@ -247,12 +247,6 @@ static int vt6420_prereset(struct ata_link *link, unsigned long deadline)
 	return 0;
 }
 
-static void vt6420_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
-				  NULL, ata_std_postreset);
-}
-
 static int vt6421_pata_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 2074701..054b93c 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3937,7 +3937,7 @@ static int __ipr_eh_dev_reset(struct scsi_cmnd * scsi_cmd)
 	if (ipr_is_gata(res) && res->sata_port) {
 		ap = res->sata_port->ap;
 		spin_unlock_irq(scsi_cmd->device->host->host_lock);
-		ata_do_eh(ap, NULL, NULL, ipr_sata_reset, NULL);
+		ata_std_error_handler(ap);
 		spin_lock_irq(scsi_cmd->device->host->host_lock);
 
 		list_for_each_entry(ipr_cmd, &ioa_cfg->pending_q, queue) {
@@ -5275,6 +5275,7 @@ static struct ata_port_operations ipr_sata_ops = {
 	.check_altstatus = ipr_ata_check_altstatus,
 	.dev_select = ata_noop_dev_select,
 	.phy_reset = ipr_ata_phy_reset,
+	.hardreset = ipr_sata_reset,
 	.post_internal_cmd = ipr_ata_post_internal,
 	.tf_read = ipr_tf_read,
 	.qc_prep = ata_noop_qc_prep,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4101dfe..900609b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -700,6 +700,14 @@ struct ata_port_operations {
 
 	void (*freeze)(struct ata_port *ap);
 	void (*thaw)(struct ata_port *ap);
+	ata_prereset_fn_t	prereset;
+	ata_reset_fn_t		softreset;
+	ata_reset_fn_t		hardreset;
+	ata_postreset_fn_t	postreset;
+	ata_prereset_fn_t	pmp_prereset;
+	ata_reset_fn_t		pmp_softreset;
+	ata_reset_fn_t		pmp_hardreset;
+	ata_postreset_fn_t	pmp_postreset;
 	void (*error_handler)(struct ata_port *ap);
 	void (*post_internal_cmd)(struct ata_queued_cmd *qc);
 
@@ -915,10 +923,6 @@ extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_noop_irq_clear(struct ata_port *ap);
 extern void ata_bmdma_freeze(struct ata_port *ap);
 extern void ata_bmdma_thaw(struct ata_port *ap);
-extern void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
-			       ata_reset_fn_t softreset,
-			       ata_reset_fn_t hardreset,
-			       ata_postreset_fn_t postreset);
 extern void ata_bmdma_error_handler(struct ata_port *ap);
 extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
 extern int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
@@ -1062,11 +1066,7 @@ extern int sata_pmp_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int sata_pmp_std_hardreset(struct ata_link *link, unsigned int *class,
 				  unsigned long deadline);
 extern void sata_pmp_std_postreset(struct ata_link *link, unsigned int *class);
-extern void sata_pmp_do_eh(struct ata_port *ap,
-		ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
-		ata_reset_fn_t hardreset, ata_postreset_fn_t postreset,
-		ata_prereset_fn_t pmp_prereset, ata_reset_fn_t pmp_softreset,
-		ata_reset_fn_t pmp_hardreset, ata_postreset_fn_t pmp_postreset);
+extern void sata_pmp_error_handler(struct ata_port *ap);
 
 /*
  * EH
@@ -1083,9 +1083,7 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 
-extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
-		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-		      ata_postreset_fn_t postreset);
+extern void ata_std_error_handler(struct ata_port *ap);
 
 /*
  * Base operations to inherit from and initializers for sht
-- 
1.5.2.4

