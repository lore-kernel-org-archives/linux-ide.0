From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/27] libata: rename SFF functions
Date: Tue, 25 Mar 2008 22:16:45 +0900
Message-ID: <12064510271539-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:60507 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbYCYNRa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755484rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:29 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

SFF functions have confusing names.  Some have sff prefix, some have
bmdma, some std, some pci and some none.  Unify the naming by...

* SFF functions which are common to both BMDMA and non-BMDMA are
  prefixed with ata_sff_.

* SFF functions which are specific to BMDMA are prefixed with
  ata_bmdma_.

* SFF functions which are specific to PCI but apply to both BMDMA and
  non-BMDMA are prefixed with ata_pci_sff_.

* SFF functions which are specific to PCI and BMDMA are prefixed with
  ata_pci_bmdma_.

* Drop generic prefixes from LLD specific routines.  For example,
  bfin_std_dev_select -> bfin_dev_select.

The following renames are noteworthy.

  ata_qc_issue_prot() -> ata_sff_qc_issue()
  ata_pci_default_filter() -> ata_bmdma_mode_filter()
  ata_dev_try_classify() -> ata_sff_dev_classify()

This rename is in preparation of separating SFF support out of libata
core layer.  This patch strictly renames functions and doesn't
introduce any behavior difference.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c              |   10 +-
 drivers/ata/ata_generic.c       |    4 +-
 drivers/ata/ata_piix.c          |    6 +-
 drivers/ata/libata-core.c       |   16 +-
 drivers/ata/libata-eh.c         |    2 +-
 drivers/ata/libata-sff.c        |  344 +++++++++++++++++++-------------------
 drivers/ata/pata_acpi.c         |   16 +-
 drivers/ata/pata_ali.c          |    6 +-
 drivers/ata/pata_amd.c          |   10 +-
 drivers/ata/pata_artop.c        |    6 +-
 drivers/ata/pata_at32.c         |    2 +-
 drivers/ata/pata_atiixp.c       |    6 +-
 drivers/ata/pata_bf54x.c        |   84 +++++-----
 drivers/ata/pata_cmd640.c       |   16 +-
 drivers/ata/pata_cmd64x.c       |    4 +-
 drivers/ata/pata_cs5520.c       |    8 +-
 drivers/ata/pata_cs5530.c       |   12 +-
 drivers/ata/pata_cs5535.c       |    2 +-
 drivers/ata/pata_cs5536.c       |    2 +-
 drivers/ata/pata_cypress.c      |    2 +-
 drivers/ata/pata_efar.c         |    4 +-
 drivers/ata/pata_hpt366.c       |    4 +-
 drivers/ata/pata_hpt37x.c       |   10 +-
 drivers/ata/pata_hpt3x2n.c      |   10 +-
 drivers/ata/pata_hpt3x3.c       |    6 +-
 drivers/ata/pata_icside.c       |    8 +-
 drivers/ata/pata_isapnp.c       |    4 +-
 drivers/ata/pata_it8213.c       |    4 +-
 drivers/ata/pata_it821x.c       |   20 +-
 drivers/ata/pata_ixp4xx_cf.c    |    4 +-
 drivers/ata/pata_jmicron.c      |    4 +-
 drivers/ata/pata_legacy.c       |   32 ++--
 drivers/ata/pata_marvell.c      |    4 +-
 drivers/ata/pata_mpc52xx.c      |    4 +-
 drivers/ata/pata_mpiix.c        |   18 +-
 drivers/ata/pata_netcell.c      |    4 +-
 drivers/ata/pata_ninja32.c      |    6 +-
 drivers/ata/pata_ns87410.c      |   12 +-
 drivers/ata/pata_ns87415.c      |    8 +-
 drivers/ata/pata_oldpiix.c      |   12 +-
 drivers/ata/pata_opti.c         |    4 +-
 drivers/ata/pata_optidma.c      |    4 +-
 drivers/ata/pata_pcmcia.c       |    6 +-
 drivers/ata/pata_pdc2027x.c     |   10 +-
 drivers/ata/pata_pdc202xx_old.c |    2 +-
 drivers/ata/pata_platform.c     |    4 +-
 drivers/ata/pata_qdi.c          |   14 +-
 drivers/ata/pata_radisys.c      |   10 +-
 drivers/ata/pata_rb500_cf.c     |    6 +-
 drivers/ata/pata_rz1000.c       |    2 +-
 drivers/ata/pata_sc1200.c       |   12 +-
 drivers/ata/pata_scc.c          |   80 +++++-----
 drivers/ata/pata_serverworks.c  |   12 +-
 drivers/ata/pata_sil680.c       |   10 +-
 drivers/ata/pata_sis.c          |    4 +-
 drivers/ata/pata_sl82c105.c     |    4 +-
 drivers/ata/pata_triflex.c      |    4 +-
 drivers/ata/pata_via.c          |    6 +-
 drivers/ata/pata_winbond.c      |    6 +-
 drivers/ata/pdc_adma.c          |   12 +-
 drivers/ata/sata_inic162x.c     |   12 +-
 drivers/ata/sata_mv.c           |    6 +-
 drivers/ata/sata_nv.c           |   32 ++--
 drivers/ata/sata_promise.c      |   12 +-
 drivers/ata/sata_qstor.c        |   10 +-
 drivers/ata/sata_sil.c          |    8 +-
 drivers/ata/sata_sis.c          |    6 +-
 drivers/ata/sata_svw.c          |    4 +-
 drivers/ata/sata_sx4.c          |   26 ++--
 drivers/ata/sata_uli.c          |   12 +-
 drivers/ata/sata_via.c          |   12 +-
 drivers/ata/sata_vsc.c          |    4 +-
 include/linux/libata.h          |  103 ++++++------
 73 files changed, 599 insertions(+), 596 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3efa990..771509c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1303,9 +1303,9 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
 
 	/* wait a while before checking status */
-	ata_wait_after_reset(ap, deadline);
+	ata_sff_wait_after_reset(ap, deadline);
 
-	rc = ata_wait_ready(ap, deadline);
+	rc = ata_sff_wait_ready(ap, deadline);
 	/* link occupied, -ENODEV too is an error */
 	if (rc) {
 		reason = "device not ready";
@@ -1350,7 +1350,7 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = 0x80;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
-	rc = sata_std_hardreset(link, class, deadline);
+	rc = sata_sff_hardreset(link, class, deadline);
 
 	ahci_start_engine(ap);
 
@@ -1431,7 +1431,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	 * have to be reset again.  For most cases, this should
 	 * suffice while making probing snappish enough.
 	 */
-	rc = ata_wait_ready(ap, jiffies + 2 * HZ);
+	rc = ata_sff_wait_ready(ap, jiffies + 2 * HZ);
 	if (rc)
 		ahci_kick_engine(ap, 0);
 
@@ -1444,7 +1444,7 @@ static void ahci_postreset(struct ata_link *link, unsigned int *class)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 new_tmp, tmp;
 
-	ata_std_postreset(link, class);
+	ata_sff_postreset(link, class);
 
 	/* Make sure port's ATAPI bit is set appropriately */
 	new_tmp = tmp = readl(port_mmio + PORT_CMD);
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index b23e2a1..47aeccd 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -150,9 +150,9 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
 		return -ENODEV;
 
 	if (dev->vendor == PCI_VENDOR_ID_AL)
-	    	ata_pci_clear_simplex(dev);
+		ata_pci_bmdma_clear_simplex(dev);
 
-	return ata_pci_init_one(dev, ppi, &generic_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &generic_sht, NULL);
 }
 
 static struct pci_device_id ata_generic[] = {
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index eafb984..aa66848 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -643,7 +643,7 @@ static int piix_pata_prereset(struct ata_link *link, unsigned long deadline)
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
 		return -ENOENT;
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -1497,7 +1497,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 		hpriv->map = piix_init_sata_map(pdev, port_info,
 					piix_map_db_table[ent->driver_data]);
 
-	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
 	host->private_data = hpriv;
@@ -1541,7 +1541,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	}
 
 	pci_set_master(pdev);
-	return ata_pci_activate_sff_host(host, ata_interrupt, &piix_sht);
+	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &piix_sht);
 }
 
 static int __init piix_init(void)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d253aeb..60859bb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -75,9 +75,9 @@ const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 const struct ata_port_operations ata_base_port_ops = {
 	.irq_clear		= ata_noop_irq_clear,
-	.prereset		= ata_std_prereset,
-	.hardreset		= sata_std_hardreset,
-	.postreset		= ata_std_postreset,
+	.prereset		= ata_sff_prereset,
+	.hardreset		= sata_sff_hardreset,
+	.postreset		= ata_sff_postreset,
 	.error_handler		= ata_std_error_handler,
 };
 
@@ -3387,7 +3387,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 }
 
 /**
- *	ata_std_prereset - prepare for reset
+ *	ata_sff_prereset - prepare for reset
  *	@link: ATA link to be reset
  *	@deadline: deadline jiffies for the operation
  *
@@ -3403,7 +3403,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_prereset(struct ata_link *link, unsigned long deadline)
+int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
@@ -3425,7 +3425,7 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 
 	/* wait for !BSY if we don't know that no device is attached */
 	if (!ata_link_offline(link)) {
-		rc = ata_wait_ready(ap, deadline);
+		rc = ata_sff_wait_ready(ap, deadline);
 		if (rc && rc != -ENODEV) {
 			ata_link_printk(link, KERN_WARNING, "device not ready "
 					"(errno=%d), forcing hardreset\n", rc);
@@ -3497,7 +3497,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 }
 
 /**
- *	ata_std_postreset - standard postreset callback
+ *	ata_sff_postreset - standard postreset callback
  *	@link: the target ata_link
  *	@classes: classes of attached devices
  *
@@ -3508,7 +3508,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-void ata_std_postreset(struct ata_link *link, unsigned int *classes)
+void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
 {
 	struct ata_port *ap = link->ap;
 	u32 serror;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index bd69afc..0a1ccab 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2863,7 +2863,7 @@ void ata_std_error_handler(struct ata_port *ap)
 	 * ata_base_port_ops.  Ignore it if SCR access is not
 	 * available.
 	 */
-	if (hardreset == sata_std_hardreset && !sata_scr_valid(&ap->link))
+	if (hardreset == sata_sff_hardreset && !sata_scr_valid(&ap->link))
 		hardreset = NULL;
 
 	ata_do_eh(ap, ops->prereset, ops->softreset, hardreset, ops->postreset);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 5208ca2..8544321 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -42,22 +42,22 @@
 const struct ata_port_operations ata_sff_port_ops = {
 	.inherits		= &ata_base_port_ops,
 
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.softreset		= ata_std_softreset,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.dev_select		= ata_std_dev_select,
-	.check_status		= ata_check_status,
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.data_xfer		= ata_data_xfer,
-	.irq_on			= ata_irq_on,
+	.qc_prep		= ata_sff_qc_prep,
+	.qc_issue		= ata_sff_qc_issue,
+
+	.freeze			= ata_sff_freeze,
+	.thaw			= ata_sff_thaw,
+	.softreset		= ata_sff_softreset,
+	.error_handler		= ata_sff_error_handler,
+	.post_internal_cmd	= ata_sff_post_internal_cmd,
+
+	.dev_select		= ata_sff_dev_select,
+	.check_status		= ata_sff_check_status,
+	.tf_load		= ata_sff_tf_load,
+	.tf_read		= ata_sff_tf_read,
+	.exec_command		= ata_sff_exec_command,
+	.data_xfer		= ata_sff_data_xfer,
+	.irq_on			= ata_sff_irq_on,
 
 	.port_start		= ata_sff_port_start,
 };
@@ -65,13 +65,13 @@ const struct ata_port_operations ata_sff_port_ops = {
 const struct ata_port_operations ata_bmdma_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 
-	.mode_filter		= ata_pci_default_filter,
+	.mode_filter		= ata_bmdma_mode_filter,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
-	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_clear		= ata_sff_irq_clear,
 };
 
 /**
@@ -181,7 +181,7 @@ static void ata_fill_sg_dumb(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ata_qc_prep - Prepare taskfile for submission
+ *	ata_sff_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
  *
  *	Prepare ATA taskfile for submission.
@@ -189,7 +189,7 @@ static void ata_fill_sg_dumb(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_qc_prep(struct ata_queued_cmd *qc)
+void ata_sff_qc_prep(struct ata_queued_cmd *qc)
 {
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
@@ -198,7 +198,7 @@ void ata_qc_prep(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ata_dumb_qc_prep - Prepare taskfile for submission
+ *	ata_sff_dumb_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
  *
  *	Prepare ATA taskfile for submission.
@@ -206,7 +206,7 @@ void ata_qc_prep(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_dumb_qc_prep(struct ata_queued_cmd *qc)
+void ata_sff_dumb_qc_prep(struct ata_queued_cmd *qc)
 {
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
@@ -215,7 +215,7 @@ void ata_dumb_qc_prep(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ata_check_status - Read device status reg & clear interrupt
+ *	ata_sff_check_status - Read device status reg & clear interrupt
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
@@ -225,13 +225,13 @@ void ata_dumb_qc_prep(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	Inherited from caller.
  */
-u8 ata_check_status(struct ata_port *ap)
+u8 ata_sff_check_status(struct ata_port *ap)
 {
 	return ioread8(ap->ioaddr.status_addr);
 }
 
 /**
- *	ata_altstatus - Read device alternate status reg
+ *	ata_sff_altstatus - Read device alternate status reg
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile alternate status register for
@@ -243,7 +243,7 @@ u8 ata_check_status(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-u8 ata_altstatus(struct ata_port *ap)
+u8 ata_sff_altstatus(struct ata_port *ap)
 {
 	if (ap->ops->check_altstatus)
 		return ap->ops->check_altstatus(ap);
@@ -252,7 +252,7 @@ u8 ata_altstatus(struct ata_port *ap)
 }
 
 /**
- *	ata_busy_sleep - sleep until BSY clears, or timeout
+ *	ata_sff_busy_sleep - sleep until BSY clears, or timeout
  *	@ap: port containing status register to be polled
  *	@tmout_pat: impatience timeout
  *	@tmout: overall timeout
@@ -266,19 +266,19 @@ u8 ata_altstatus(struct ata_port *ap)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_busy_sleep(struct ata_port *ap,
-		   unsigned long tmout_pat, unsigned long tmout)
+int ata_sff_busy_sleep(struct ata_port *ap,
+		       unsigned long tmout_pat, unsigned long tmout)
 {
 	unsigned long timer_start, timeout;
 	u8 status;
 
-	status = ata_busy_wait(ap, ATA_BUSY, 300);
+	status = ata_sff_busy_wait(ap, ATA_BUSY, 300);
 	timer_start = jiffies;
 	timeout = timer_start + tmout_pat;
 	while (status != 0xff && (status & ATA_BUSY) &&
 	       time_before(jiffies, timeout)) {
 		msleep(50);
-		status = ata_busy_wait(ap, ATA_BUSY, 3);
+		status = ata_sff_busy_wait(ap, ATA_BUSY, 3);
 	}
 
 	if (status != 0xff && (status & ATA_BUSY))
@@ -307,7 +307,7 @@ int ata_busy_sleep(struct ata_port *ap,
 }
 
 /**
- *	ata_wait_ready - sleep until BSY clears, or timeout
+ *	ata_sff_wait_ready - sleep until BSY clears, or timeout
  *	@ap: port containing status register to be polled
  *	@deadline: deadline jiffies for the operation
  *
@@ -320,7 +320,7 @@ int ata_busy_sleep(struct ata_port *ap,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_wait_ready(struct ata_port *ap, unsigned long deadline)
+int ata_sff_wait_ready(struct ata_port *ap, unsigned long deadline)
 {
 	unsigned long start = jiffies;
 	int warned = 0;
@@ -349,7 +349,7 @@ int ata_wait_ready(struct ata_port *ap, unsigned long deadline)
 }
 
 /**
- *	ata_std_dev_select - Select device 0/1 on ATA bus
+ *	ata_sff_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
  *	@device: ATA device (numbered from zero) to select
  *
@@ -362,7 +362,7 @@ int ata_wait_ready(struct ata_port *ap, unsigned long deadline)
  *	LOCKING:
  *	caller.
  */
-void ata_std_dev_select(struct ata_port *ap, unsigned int device)
+void ata_sff_dev_select(struct ata_port *ap, unsigned int device)
 {
 	u8 tmp;
 
@@ -372,7 +372,7 @@ void ata_std_dev_select(struct ata_port *ap, unsigned int device)
 		tmp = ATA_DEVICE_OBS | ATA_DEV1;
 
 	iowrite8(tmp, ap->ioaddr.device_addr);
-	ata_pause(ap);		/* needed; also flushes, for mmio */
+	ata_sff_pause(ap);	/* needed; also flushes, for mmio */
 }
 
 /**
@@ -386,9 +386,9 @@ void ata_std_dev_select(struct ata_port *ap, unsigned int device)
  *	make either device 0, or device 1, active on the
  *	ATA channel.
  *
- *	This is a high-level version of ata_std_dev_select(),
- *	which additionally provides the services of inserting
- *	the proper pauses and status polling, where needed.
+ *	This is a high-level version of ata_sff_dev_select(), which
+ *	additionally provides the services of inserting the proper
+ *	pauses and status polling, where needed.
  *
  *	LOCKING:
  *	caller.
@@ -413,7 +413,7 @@ void ata_dev_select(struct ata_port *ap, unsigned int device,
 }
 
 /**
- *	ata_irq_on - Enable interrupts on a port.
+ *	ata_sff_irq_on - Enable interrupts on a port.
  *	@ap: Port on which interrupts are enabled.
  *
  *	Enable interrupts on a legacy IDE device using MMIO or PIO,
@@ -422,7 +422,7 @@ void ata_dev_select(struct ata_port *ap, unsigned int device,
  *	LOCKING:
  *	Inherited from caller.
  */
-u8 ata_irq_on(struct ata_port *ap)
+u8 ata_sff_irq_on(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u8 tmp;
@@ -440,7 +440,7 @@ u8 ata_irq_on(struct ata_port *ap)
 }
 
 /**
- *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+ *	ata_sff_irq_clear - Clear PCI IDE BMDMA interrupt.
  *	@ap: Port associated with this ATA transaction.
  *
  *	Clear interrupt and error flags in DMA status register.
@@ -450,7 +450,7 @@ u8 ata_irq_on(struct ata_port *ap)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_bmdma_irq_clear(struct ata_port *ap)
+void ata_sff_irq_clear(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->ioaddr.bmdma_addr;
 
@@ -461,7 +461,7 @@ void ata_bmdma_irq_clear(struct ata_port *ap)
 }
 
 /**
- *	ata_tf_load - send taskfile registers to host controller
+ *	ata_sff_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
  *
@@ -470,7 +470,7 @@ void ata_bmdma_irq_clear(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
+void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
@@ -520,7 +520,7 @@ void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 }
 
 /**
- *	ata_tf_read - input device's ATA taskfile shadow registers
+ *	ata_sff_tf_read - input device's ATA taskfile shadow registers
  *	@ap: Port from which input is read
  *	@tf: ATA taskfile register set for storing input
  *
@@ -532,11 +532,11 @@ void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
  *	LOCKING:
  *	Inherited from caller.
  */
-void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+void ata_sff_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	tf->command = ata_check_status(ap);
+	tf->command = ata_sff_check_status(ap);
 	tf->feature = ioread8(ioaddr->error_addr);
 	tf->nsect = ioread8(ioaddr->nsect_addr);
 	tf->lbal = ioread8(ioaddr->lbal_addr);
@@ -560,7 +560,7 @@ void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 }
 
 /**
- *	ata_exec_command - issue ATA command to host controller
+ *	ata_sff_exec_command - issue ATA command to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
  *
@@ -570,12 +570,12 @@ void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
+void ata_sff_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 
 	iowrite8(tf->command, ap->ioaddr.command_addr);
-	ata_pause(ap);
+	ata_sff_pause(ap);
 }
 
 /**
@@ -598,7 +598,7 @@ static inline void ata_tf_to_host(struct ata_port *ap,
 }
 
 /**
- *	ata_data_xfer - Transfer data by PIO
+ *	ata_sff_data_xfer - Transfer data by PIO
  *	@dev: device to target
  *	@buf: data buffer
  *	@buflen: buffer length
@@ -612,8 +612,8 @@ static inline void ata_tf_to_host(struct ata_port *ap,
  *	RETURNS:
  *	Bytes consumed.
  */
-unsigned int ata_data_xfer(struct ata_device *dev, unsigned char *buf,
-			   unsigned int buflen, int rw)
+unsigned int ata_sff_data_xfer(struct ata_device *dev, unsigned char *buf,
+			       unsigned int buflen, int rw)
 {
 	struct ata_port *ap = dev->link->ap;
 	void __iomem *data_addr = ap->ioaddr.data_addr;
@@ -644,7 +644,7 @@ unsigned int ata_data_xfer(struct ata_device *dev, unsigned char *buf,
 }
 
 /**
- *	ata_data_xfer_noirq - Transfer data by PIO
+ *	ata_sff_data_xfer_noirq - Transfer data by PIO
  *	@dev: device to target
  *	@buf: data buffer
  *	@buflen: buffer length
@@ -659,14 +659,14 @@ unsigned int ata_data_xfer(struct ata_device *dev, unsigned char *buf,
  *	RETURNS:
  *	Bytes consumed.
  */
-unsigned int ata_data_xfer_noirq(struct ata_device *dev, unsigned char *buf,
-				 unsigned int buflen, int rw)
+unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev, unsigned char *buf,
+				     unsigned int buflen, int rw)
 {
 	unsigned long flags;
 	unsigned int consumed;
 
 	local_irq_save(flags);
-	consumed = ata_data_xfer(dev, buf, buflen, rw);
+	consumed = ata_sff_data_xfer(dev, buf, buflen, rw);
 	local_irq_restore(flags);
 
 	return consumed;
@@ -752,7 +752,7 @@ static void ata_pio_sectors(struct ata_queued_cmd *qc)
 	} else
 		ata_pio_sector(qc);
 
-	ata_altstatus(qc->ap); /* flush */
+	ata_sff_altstatus(qc->ap); /* flush */
 }
 
 /**
@@ -773,7 +773,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 	WARN_ON(qc->dev->cdb_len < 12);
 
 	ap->ops->data_xfer(qc->dev, qc->cdb, qc->dev->cdb_len, 1);
-	ata_altstatus(ap); /* flush */
+	ata_sff_altstatus(ap); /* flush */
 
 	switch (qc->tf.protocol) {
 	case ATAPI_PROT_PIO:
@@ -915,7 +915,7 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 
 	if (unlikely(__atapi_pio_bytes(qc, bytes)))
 		goto err_out;
-	ata_altstatus(ap); /* flush */
+	ata_sff_altstatus(ap); /* flush */
 
 	return;
 
@@ -1004,7 +1004,7 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 }
 
 /**
- *	ata_hsm_move - move the HSM to the next state.
+ *	ata_sff_hsm_move - move the HSM to the next state.
  *	@ap: the target ata_port
  *	@qc: qc on going
  *	@status: current device status
@@ -1013,15 +1013,15 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
  *	RETURNS:
  *	1 when poll next status needed, 0 otherwise.
  */
-int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
-		 u8 status, int in_wq)
+int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+		     u8 status, int in_wq)
 {
 	unsigned long flags = 0;
 	int poll_next;
 
 	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
 
-	/* Make sure ata_qc_issue_prot() does not throw things
+	/* Make sure ata_sff_qc_issue() does not throw things
 	 * like DMA polling into the workqueue. Notice that
 	 * in_wq is not equivalent to (qc->tf.flags & ATA_TFLAG_POLLING).
 	 */
@@ -1263,10 +1263,10 @@ fsm_start:
 	 * or something.  Snooze for a couple msecs, then
 	 * chk-status again.  If still busy, queue delayed work.
 	 */
-	status = ata_busy_wait(ap, ATA_BUSY, 5);
+	status = ata_sff_busy_wait(ap, ATA_BUSY, 5);
 	if (status & ATA_BUSY) {
 		msleep(2);
-		status = ata_busy_wait(ap, ATA_BUSY, 10);
+		status = ata_sff_busy_wait(ap, ATA_BUSY, 10);
 		if (status & ATA_BUSY) {
 			ata_pio_queue_task(ap, qc, ATA_SHORT_PAUSE);
 			return;
@@ -1274,7 +1274,7 @@ fsm_start:
 	}
 
 	/* move the HSM */
-	poll_next = ata_hsm_move(ap, qc, status, 1);
+	poll_next = ata_sff_hsm_move(ap, qc, status, 1);
 
 	/* another command or interrupt handler
 	 * may be running at this point.
@@ -1284,7 +1284,7 @@ fsm_start:
 }
 
 /**
- *	ata_qc_issue_prot - issue taskfile to device in proto-dependent manner
+ *	ata_sff_qc_issue - issue taskfile to device in proto-dependent manner
  *	@qc: command to issue to device
  *
  *	Using various libata functions and hooks, this function
@@ -1300,7 +1300,7 @@ fsm_start:
  *	RETURNS:
  *	Zero on success, AC_ERR_* mask on failure
  */
-unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
+unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
@@ -1415,7 +1415,7 @@ unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ata_host_intr - Handle host interrupt for given (port, task)
+ *	ata_sff_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
  *	@qc: Taskfile currently active in engine
  *
@@ -1429,8 +1429,8 @@ unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	One if interrupt was handled, zero if not (shared irq).
  */
-inline unsigned int ata_host_intr(struct ata_port *ap,
-				  struct ata_queued_cmd *qc)
+inline unsigned int ata_sff_host_intr(struct ata_port *ap,
+				      struct ata_queued_cmd *qc)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	u8 status, host_stat = 0;
@@ -1481,7 +1481,7 @@ inline unsigned int ata_host_intr(struct ata_port *ap,
 	}
 
 	/* check altstatus */
-	status = ata_altstatus(ap);
+	status = ata_sff_altstatus(ap);
 	if (status & ATA_BUSY)
 		goto idle_irq;
 
@@ -1493,7 +1493,7 @@ inline unsigned int ata_host_intr(struct ata_port *ap,
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
-	ata_hsm_move(ap, qc, status, 0);
+	ata_sff_hsm_move(ap, qc, status, 0);
 
 	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
 				       qc->tf.protocol == ATAPI_PROT_DMA))
@@ -1516,12 +1516,12 @@ idle_irq:
 }
 
 /**
- *	ata_interrupt - Default ATA host interrupt handler
+ *	ata_sff_interrupt - Default ATA host interrupt handler
  *	@irq: irq line (unused)
  *	@dev_instance: pointer to our ata_host information structure
  *
  *	Default interrupt handler for PCI IDE devices.  Calls
- *	ata_host_intr() for each port that is not disabled.
+ *	ata_sff_host_intr() for each port that is not disabled.
  *
  *	LOCKING:
  *	Obtains host lock during operation.
@@ -1529,7 +1529,7 @@ idle_irq:
  *	RETURNS:
  *	IRQ_NONE or IRQ_HANDLED.
  */
-irqreturn_t ata_interrupt(int irq, void *dev_instance)
+irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
 	unsigned int i;
@@ -1550,7 +1550,7 @@ irqreturn_t ata_interrupt(int irq, void *dev_instance)
 			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
 			    (qc->flags & ATA_QCFLAG_ACTIVE))
-				handled |= ata_host_intr(ap, qc);
+				handled |= ata_sff_host_intr(ap, qc);
 		}
 	}
 
@@ -1560,7 +1560,7 @@ irqreturn_t ata_interrupt(int irq, void *dev_instance)
 }
 
 /**
- *	ata_bmdma_freeze - Freeze BMDMA controller port
+ *	ata_sff_freeze - Freeze SFF controller port
  *	@ap: port to freeze
  *
  *	Freeze BMDMA controller port.
@@ -1568,7 +1568,7 @@ irqreturn_t ata_interrupt(int irq, void *dev_instance)
  *	LOCKING:
  *	Inherited from caller.
  */
-void ata_bmdma_freeze(struct ata_port *ap)
+void ata_sff_freeze(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
@@ -1588,15 +1588,15 @@ void ata_bmdma_freeze(struct ata_port *ap)
 }
 
 /**
- *	ata_bmdma_thaw - Thaw BMDMA controller port
+ *	ata_sff_thaw - Thaw SFF controller port
  *	@ap: port to thaw
  *
- *	Thaw BMDMA controller port.
+ *	Thaw SFF controller port.
  *
  *	LOCKING:
  *	Inherited from caller.
  */
-void ata_bmdma_thaw(struct ata_port *ap)
+void ata_sff_thaw(struct ata_port *ap)
 {
 	/* clear & re-enable interrupts */
 	ap->ops->check_status(ap);
@@ -1647,7 +1647,7 @@ static unsigned int ata_devchk(struct ata_port *ap, unsigned int device)
 }
 
 /**
- *	ata_dev_try_classify - Parse returned ATA device signature
+ *	ata_sff_dev_classify - Parse returned ATA device signature
  *	@dev: ATA device to classify (starting at zero)
  *	@present: device seems present
  *	@r_err: Value of error register on completion
@@ -1667,7 +1667,7 @@ static unsigned int ata_devchk(struct ata_port *ap, unsigned int device)
  *	RETURNS:
  *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
  */
-unsigned int ata_dev_try_classify(struct ata_device *dev, int present,
+unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 				  u8 *r_err)
 {
 	struct ata_port *ap = dev->link->ap;
@@ -1727,7 +1727,7 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	 * BSY bit to clear
 	 */
 	if (dev0) {
-		rc = ata_wait_ready(ap, deadline);
+		rc = ata_sff_wait_ready(ap, deadline);
 		if (rc) {
 			if (rc != -ENODEV)
 				return rc;
@@ -1757,7 +1757,7 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 			msleep(50);	/* give drive a breather */
 		}
 
-		rc = ata_wait_ready(ap, deadline);
+		rc = ata_sff_wait_ready(ap, deadline);
 		if (rc) {
 			if (rc != -ENODEV)
 				return rc;
@@ -1776,7 +1776,7 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 }
 
 /**
- *	ata_wait_after_reset - wait before checking status after reset
+ *	ata_sff_wait_after_reset - wait before checking status after reset
  *	@ap: port containing status register to be polled
  *	@deadline: deadline jiffies for the operation
  *
@@ -1790,7 +1790,7 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline)
+void ata_sff_wait_after_reset(struct ata_port *ap, unsigned long deadline)
 {
 	unsigned long until = jiffies + ATA_TMOUT_FF_WAIT;
 
@@ -1845,7 +1845,7 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
 
 	/* wait a while before checking status */
-	ata_wait_after_reset(ap, deadline);
+	ata_sff_wait_after_reset(ap, deadline);
 
 	/* Before we perform post reset processing we want to see if
 	 * the bus shows 0xFF because the odd clown forgets the D7
@@ -1858,7 +1858,7 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 }
 
 /**
- *	ata_std_softreset - reset host port via ATA SRST
+ *	ata_sff_softreset - reset host port via ATA SRST
  *	@link: ATA link to reset
  *	@classes: resulting classes of attached devices
  *	@deadline: deadline jiffies for the operation
@@ -1871,7 +1871,7 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_softreset(struct ata_link *link, unsigned int *classes,
+int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 		      unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
@@ -1906,10 +1906,10 @@ int ata_std_softreset(struct ata_link *link, unsigned int *classes,
 	}
 
 	/* determine by signature whether we have ATA or ATAPI devices */
-	classes[0] = ata_dev_try_classify(&link->device[0],
+	classes[0] = ata_sff_dev_classify(&link->device[0],
 					  devmask & (1 << 0), &err);
 	if (slave_possible && err != 0x81)
-		classes[1] = ata_dev_try_classify(&link->device[1],
+		classes[1] = ata_sff_dev_classify(&link->device[1],
 						  devmask & (1 << 1), &err);
 
  out:
@@ -1918,7 +1918,7 @@ int ata_std_softreset(struct ata_link *link, unsigned int *classes,
 }
 
 /**
- *	sata_std_hardreset - reset host port via SATA phy reset
+ *	sata_sff_hardreset - reset host port via SATA phy reset
  *	@link: link to reset
  *	@class: resulting class of attached device
  *	@deadline: deadline jiffies for the operation
@@ -1932,7 +1932,7 @@ int ata_std_softreset(struct ata_link *link, unsigned int *classes,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_link *link, unsigned int *class,
+int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 		       unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
@@ -1957,7 +1957,7 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 	}
 
 	/* wait a while before checking status */
-	ata_wait_after_reset(ap, deadline);
+	ata_sff_wait_after_reset(ap, deadline);
 
 	/* If PMP is supported, we have to do follow-up SRST.  Note
 	 * that some PMPs don't send D2H Reg FIS after hardreset at
@@ -1965,11 +1965,11 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 	 * second and request follow-up SRST.
 	 */
 	if (ap->flags & ATA_FLAG_PMP) {
-		ata_wait_ready(ap, jiffies + HZ);
+		ata_sff_wait_ready(ap, jiffies + HZ);
 		return -EAGAIN;
 	}
 
-	rc = ata_wait_ready(ap, deadline);
+	rc = ata_sff_wait_ready(ap, deadline);
 	/* link occupied, -ENODEV too is an error */
 	if (rc) {
 		ata_link_printk(link, KERN_ERR,
@@ -1979,17 +1979,17 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 
 	ap->ops->dev_select(ap, 0);	/* probably unnecessary */
 
-	*class = ata_dev_try_classify(link->device, 1, NULL);
+	*class = ata_sff_dev_classify(link->device, 1, NULL);
 
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 }
 
 /**
- *	ata_bmdma_error_handler - Stock error handler for BMDMA controller
+ *	ata_sff_error_handler - Stock error handler for BMDMA controller
  *	@ap: port to handle error for
  *
- *	Stock error handler for BMDMA controller.  It can handle both
+ *	Stock error handler for SFF controller.  It can handle both
  *	PATA and SATA controllers.  Many controllers should be able to
  *	use this EH as-is or with some added handling before and
  *	after.
@@ -1997,7 +1997,7 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-void ata_bmdma_error_handler(struct ata_port *ap)
+void ata_sff_error_handler(struct ata_port *ap)
 {
 	ata_reset_fn_t softreset = ap->ops->softreset;
 	ata_reset_fn_t hardreset = ap->ops->hardreset;
@@ -2034,7 +2034,7 @@ void ata_bmdma_error_handler(struct ata_port *ap)
 		ap->ops->bmdma_stop(qc);
 	}
 
-	ata_altstatus(ap);
+	ata_sff_altstatus(ap);
 	ap->ops->check_status(ap);
 	ap->ops->irq_clear(ap);
 
@@ -2045,14 +2045,14 @@ void ata_bmdma_error_handler(struct ata_port *ap)
 
 	/* PIO and DMA engines have been stopped, perform recovery */
 
-	/* ata_std_softreset and sata_std_hardreset are inherited to
+	/* ata_sff_softreset and sata_sff_hardreset are inherited to
 	 * all SFF drivers from ata_sff_port_ops.  Ignore softreset if
 	 * ctl isn't accessible.  Ignore hardreset if SCR access isn't
 	 * available.
 	 */
-	if (softreset == ata_std_softreset && !ap->ioaddr.ctl_addr)
+	if (softreset == ata_sff_softreset && !ap->ioaddr.ctl_addr)
 		softreset = NULL;
-	if (hardreset == sata_std_hardreset && !sata_scr_valid(&ap->link))
+	if (hardreset == sata_sff_hardreset && !sata_scr_valid(&ap->link))
 		hardreset = NULL;
 
 	ata_do_eh(ap, ap->ops->prereset, softreset, hardreset,
@@ -2060,14 +2060,13 @@ void ata_bmdma_error_handler(struct ata_port *ap)
 }
 
 /**
- *	ata_bmdma_post_internal_cmd - Stock post_internal_cmd for
- *				      BMDMA controller
+ *	ata_sff_post_internal_cmd - Stock post_internal_cmd for SFF controller
  *	@qc: internal command to clean up
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
+void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	if (qc->ap->ioaddr.bmdma_addr)
 		ata_bmdma_stop(qc);
@@ -2094,7 +2093,7 @@ int ata_sff_port_start(struct ata_port *ap)
 }
 
 /**
- *	ata_std_ports - initialize ioaddr with standard port offsets.
+ *	ata_sff_std_ports - initialize ioaddr with standard port offsets.
  *	@ioaddr: IO address structure to be initialized
  *
  *	Utility function which initializes data_addr, error_addr,
@@ -2104,7 +2103,7 @@ int ata_sff_port_start(struct ata_port *ap)
  *
  *	Does not set ctl_addr, altstatus_addr, bmdma_addr, or scr_addr.
  */
-void ata_std_ports(struct ata_ioports *ioaddr)
+void ata_sff_std_ports(struct ata_ioports *ioaddr)
 {
 	ioaddr->data_addr = ioaddr->cmd_addr + ATA_REG_DATA;
 	ioaddr->error_addr = ioaddr->cmd_addr + ATA_REG_ERR;
@@ -2118,7 +2117,8 @@ void ata_std_ports(struct ata_ioports *ioaddr)
 	ioaddr->command_addr = ioaddr->cmd_addr + ATA_REG_CMD;
 }
 
-unsigned long ata_pci_default_filter(struct ata_device *adev, unsigned long xfer_mask)
+unsigned long ata_bmdma_mode_filter(struct ata_device *adev,
+				    unsigned long xfer_mask)
 {
 	/* Filter out DMA modes if the device has been configured by
 	   the BIOS as PIO only */
@@ -2209,7 +2209,7 @@ void ata_bmdma_stop(struct ata_queued_cmd *qc)
 		 mmio + ATA_DMA_CMD);
 
 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_altstatus(ap);        /* dummy read */
+	ata_sff_altstatus(ap);        /* dummy read */
 }
 
 /**
@@ -2289,9 +2289,9 @@ void ata_bus_reset(struct ata_port *ap)
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
 	 */
-	device[0].class = ata_dev_try_classify(&device[0], dev0, &err);
+	device[0].class = ata_sff_dev_classify(&device[0], dev0, &err);
 	if ((slave_possible) && (err != 0x81))
-		device[1].class = ata_dev_try_classify(&device[1], dev1, &err);
+		device[1].class = ata_sff_dev_classify(&device[1], dev1, &err);
 
 	/* is double-select really necessary? */
 	if (device[1].class != ATA_DEV_NONE)
@@ -2322,7 +2322,7 @@ err_out:
 #ifdef CONFIG_PCI
 
 /**
- *	ata_pci_clear_simplex	-	attempt to kick device out of simplex
+ *	ata_pci_bmdma_clear_simplex -	attempt to kick device out of simplex
  *	@pdev: PCI device
  *
  *	Some PCI ATA devices report simplex mode but in fact can be told to
@@ -2330,7 +2330,7 @@ err_out:
  *	perform the task on such devices. Calling it on other devices will
  *	have -undefined- behaviour.
  */
-int ata_pci_clear_simplex(struct pci_dev *pdev)
+int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
 {
 	unsigned long bmdma = pci_resource_start(pdev, 4);
 	u8 simplex;
@@ -2347,7 +2347,7 @@ int ata_pci_clear_simplex(struct pci_dev *pdev)
 }
 
 /**
- *	ata_pci_init_bmdma - acquire PCI BMDMA resources and init ATA host
+ *	ata_pci_bmdma_init - acquire PCI BMDMA resources and init ATA host
  *	@host: target ATA host
  *
  *	Acquire PCI BMDMA resources and initialize @host accordingly.
@@ -2358,7 +2358,7 @@ int ata_pci_clear_simplex(struct pci_dev *pdev)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_pci_init_bmdma(struct ata_host *host)
+int ata_pci_bmdma_init(struct ata_host *host)
 {
 	struct device *gdev = host->dev;
 	struct pci_dev *pdev = to_pci_dev(gdev);
@@ -2418,7 +2418,7 @@ static int ata_resources_present(struct pci_dev *pdev, int port)
 }
 
 /**
- *	ata_pci_init_sff_host - acquire native PCI ATA resources and init host
+ *	ata_pci_sff_init_host - acquire native PCI ATA resources and init host
  *	@host: target ATA host
  *
  *	Acquire native PCI ATA resources for @host and initialize the
@@ -2436,7 +2436,7 @@ static int ata_resources_present(struct pci_dev *pdev, int port)
  *	0 if at least one port is initialized, -ENODEV if no port is
  *	available.
  */
-int ata_pci_init_sff_host(struct ata_host *host)
+int ata_pci_sff_init_host(struct ata_host *host)
 {
 	struct device *gdev = host->dev;
 	struct pci_dev *pdev = to_pci_dev(gdev);
@@ -2478,7 +2478,7 @@ int ata_pci_init_sff_host(struct ata_host *host)
 		ap->ioaddr.altstatus_addr =
 		ap->ioaddr.ctl_addr = (void __iomem *)
 			((unsigned long)iomap[base + 1] | ATA_PCI_CTL_OFS);
-		ata_std_ports(&ap->ioaddr);
+		ata_sff_std_ports(&ap->ioaddr);
 
 		ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
 			(unsigned long long)pci_resource_start(pdev, base),
@@ -2496,7 +2496,7 @@ int ata_pci_init_sff_host(struct ata_host *host)
 }
 
 /**
- *	ata_pci_prepare_sff_host - helper to prepare native PCI ATA host
+ *	ata_pci_sff_prepare_host - helper to prepare native PCI ATA host
  *	@pdev: target PCI device
  *	@ppi: array of port_info, must be enough for two ports
  *	@r_host: out argument for the initialized ATA host
@@ -2510,7 +2510,7 @@ int ata_pci_init_sff_host(struct ata_host *host)
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_pci_prepare_sff_host(struct pci_dev *pdev,
+int ata_pci_sff_prepare_host(struct pci_dev *pdev,
 			     const struct ata_port_info * const * ppi,
 			     struct ata_host **r_host)
 {
@@ -2528,12 +2528,12 @@ int ata_pci_prepare_sff_host(struct pci_dev *pdev,
 		goto err_out;
 	}
 
-	rc = ata_pci_init_sff_host(host);
+	rc = ata_pci_sff_init_host(host);
 	if (rc)
 		goto err_out;
 
 	/* init DMA related stuff */
-	rc = ata_pci_init_bmdma(host);
+	rc = ata_pci_bmdma_init(host);
 	if (rc)
 		goto err_bmdma;
 
@@ -2554,7 +2554,7 @@ int ata_pci_prepare_sff_host(struct pci_dev *pdev,
 }
 
 /**
- *	ata_pci_activate_sff_host - start SFF host, request IRQ and register it
+ *	ata_pci_sff_activate_host - start SFF host, request IRQ and register it
  *	@host: target SFF ATA host
  *	@irq_handler: irq_handler used when requesting IRQ(s)
  *	@sht: scsi_host_template to use when registering the host
@@ -2569,7 +2569,7 @@ int ata_pci_prepare_sff_host(struct pci_dev *pdev,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_pci_activate_sff_host(struct ata_host *host,
+int ata_pci_sff_activate_host(struct ata_host *host,
 			      irq_handler_t irq_handler,
 			      struct scsi_host_template *sht)
 {
@@ -2647,7 +2647,7 @@ int ata_pci_activate_sff_host(struct ata_host *host,
 }
 
 /**
- *	ata_pci_init_one - Initialize/register PCI IDE host controller
+ *	ata_pci_sff_init_one - Initialize/register PCI IDE host controller
  *	@pdev: Controller to be initialized
  *	@ppi: array of port_info, must be enough for two ports
  *	@sht: scsi_host_template to use when registering the host
@@ -2671,9 +2671,9 @@ int ata_pci_activate_sff_host(struct ata_host *host,
  *	RETURNS:
  *	Zero on success, negative on errno-based value on error.
  */
-int ata_pci_init_one(struct pci_dev *pdev,
-		     const struct ata_port_info * const * ppi,
-		     struct scsi_host_template *sht, void *host_priv)
+int ata_pci_sff_init_one(struct pci_dev *pdev,
+			 const struct ata_port_info * const * ppi,
+			 struct scsi_host_template *sht, void *host_priv)
 {
 	struct device *dev = &pdev->dev;
 	const struct ata_port_info *pi = NULL;
@@ -2704,13 +2704,13 @@ int ata_pci_init_one(struct pci_dev *pdev,
 		goto out;
 
 	/* prepare and activate SFF host */
-	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
 	if (rc)
 		goto out;
 	host->private_data = host_priv;
 
 	pci_set_master(pdev);
-	rc = ata_pci_activate_sff_host(host, ata_interrupt, sht);
+	rc = ata_pci_sff_activate_host(host, ata_sff_interrupt, sht);
  out:
 	if (rc == 0)
 		devres_remove_group(&pdev->dev, NULL);
@@ -2724,47 +2724,47 @@ int ata_pci_init_one(struct pci_dev *pdev,
 
 EXPORT_SYMBOL_GPL(ata_sff_port_ops);
 EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
-EXPORT_SYMBOL_GPL(ata_qc_prep);
-EXPORT_SYMBOL_GPL(ata_dumb_qc_prep);
-EXPORT_SYMBOL_GPL(ata_std_dev_select);
-EXPORT_SYMBOL_GPL(ata_check_status);
-EXPORT_SYMBOL_GPL(ata_altstatus);
-EXPORT_SYMBOL_GPL(ata_busy_sleep);
-EXPORT_SYMBOL_GPL(ata_wait_ready);
-EXPORT_SYMBOL_GPL(ata_tf_load);
-EXPORT_SYMBOL_GPL(ata_tf_read);
-EXPORT_SYMBOL_GPL(ata_exec_command);
-EXPORT_SYMBOL_GPL(ata_data_xfer);
-EXPORT_SYMBOL_GPL(ata_data_xfer_noirq);
-EXPORT_SYMBOL_GPL(ata_irq_on);
-EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
-EXPORT_SYMBOL_GPL(ata_hsm_move);
-EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
-EXPORT_SYMBOL_GPL(ata_host_intr);
-EXPORT_SYMBOL_GPL(ata_interrupt);
-EXPORT_SYMBOL_GPL(ata_bmdma_freeze);
-EXPORT_SYMBOL_GPL(ata_bmdma_thaw);
-EXPORT_SYMBOL_GPL(ata_std_prereset);
-EXPORT_SYMBOL_GPL(ata_dev_try_classify);
-EXPORT_SYMBOL_GPL(ata_wait_after_reset);
-EXPORT_SYMBOL_GPL(ata_std_softreset);
-EXPORT_SYMBOL_GPL(sata_std_hardreset);
-EXPORT_SYMBOL_GPL(ata_std_postreset);
-EXPORT_SYMBOL_GPL(ata_bmdma_error_handler);
-EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
+EXPORT_SYMBOL_GPL(ata_sff_qc_prep);
+EXPORT_SYMBOL_GPL(ata_sff_dumb_qc_prep);
+EXPORT_SYMBOL_GPL(ata_sff_dev_select);
+EXPORT_SYMBOL_GPL(ata_sff_check_status);
+EXPORT_SYMBOL_GPL(ata_sff_altstatus);
+EXPORT_SYMBOL_GPL(ata_sff_busy_sleep);
+EXPORT_SYMBOL_GPL(ata_sff_wait_ready);
+EXPORT_SYMBOL_GPL(ata_sff_tf_load);
+EXPORT_SYMBOL_GPL(ata_sff_tf_read);
+EXPORT_SYMBOL_GPL(ata_sff_exec_command);
+EXPORT_SYMBOL_GPL(ata_sff_data_xfer);
+EXPORT_SYMBOL_GPL(ata_sff_data_xfer_noirq);
+EXPORT_SYMBOL_GPL(ata_sff_irq_on);
+EXPORT_SYMBOL_GPL(ata_sff_irq_clear);
+EXPORT_SYMBOL_GPL(ata_sff_hsm_move);
+EXPORT_SYMBOL_GPL(ata_sff_qc_issue);
+EXPORT_SYMBOL_GPL(ata_sff_host_intr);
+EXPORT_SYMBOL_GPL(ata_sff_interrupt);
+EXPORT_SYMBOL_GPL(ata_sff_freeze);
+EXPORT_SYMBOL_GPL(ata_sff_thaw);
+EXPORT_SYMBOL_GPL(ata_sff_prereset);
+EXPORT_SYMBOL_GPL(ata_sff_dev_classify);
+EXPORT_SYMBOL_GPL(ata_sff_wait_after_reset);
+EXPORT_SYMBOL_GPL(ata_sff_softreset);
+EXPORT_SYMBOL_GPL(sata_sff_hardreset);
+EXPORT_SYMBOL_GPL(ata_sff_postreset);
+EXPORT_SYMBOL_GPL(ata_sff_error_handler);
+EXPORT_SYMBOL_GPL(ata_sff_post_internal_cmd);
 EXPORT_SYMBOL_GPL(ata_sff_port_start);
-EXPORT_SYMBOL_GPL(ata_std_ports);
-EXPORT_SYMBOL_GPL(ata_pci_default_filter);
+EXPORT_SYMBOL_GPL(ata_sff_std_ports);
+EXPORT_SYMBOL_GPL(ata_bmdma_mode_filter);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
 EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
 EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 #ifdef CONFIG_PCI
-EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
-EXPORT_SYMBOL_GPL(ata_pci_init_bmdma);
-EXPORT_SYMBOL_GPL(ata_pci_init_sff_host);
-EXPORT_SYMBOL_GPL(ata_pci_prepare_sff_host);
-EXPORT_SYMBOL_GPL(ata_pci_activate_sff_host);
-EXPORT_SYMBOL_GPL(ata_pci_init_one);
+EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
+EXPORT_SYMBOL_GPL(ata_pci_bmdma_init);
+EXPORT_SYMBOL_GPL(ata_pci_sff_init_host);
+EXPORT_SYMBOL_GPL(ata_pci_sff_prepare_host);
+EXPORT_SYMBOL_GPL(ata_pci_sff_activate_host);
+EXPORT_SYMBOL_GPL(ata_pci_sff_init_one);
 #endif /* CONFIG_PCI */
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index d337f32..c5f91e6 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -47,7 +47,7 @@ static int pacpi_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (ap->acpi_handle == NULL || ata_acpi_gtm(ap, &acpi->gtm) < 0)
 		return -ENODEV;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -106,7 +106,7 @@ static unsigned long pacpi_discover_modes(struct ata_port *ap, struct ata_device
 static unsigned long pacpi_mode_filter(struct ata_device *adev, unsigned long mask)
 {
 	struct pata_acpi *acpi = adev->link->ap->private_data;
-	return ata_pci_default_filter(adev, mask & acpi->mask[adev->devno]);
+	return ata_bmdma_mode_filter(adev, mask & acpi->mask[adev->devno]);
 }
 
 /**
@@ -162,7 +162,7 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	pacpi_qc_issue_prot	-	command issue
+ *	pacpi_qc_issue	-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -170,14 +170,14 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
  *	neccessary.
  */
 
-static unsigned int pacpi_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int pacpi_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
 	struct pata_acpi *acpi = ap->private_data;
 
 	if (acpi->gtm.flags & 0x10)
-		return ata_qc_issue_prot(qc);
+		return ata_sff_qc_issue(qc);
 
 	if (adev != acpi->last) {
 		pacpi_set_piomode(ap, adev);
@@ -185,7 +185,7 @@ static unsigned int pacpi_qc_issue_prot(struct ata_queued_cmd *qc)
 			pacpi_set_dmamode(ap, adev);
 		acpi->last = adev;
 	}
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 /**
@@ -223,7 +223,7 @@ static struct scsi_host_template pacpi_sht = {
 
 static struct ata_port_operations pacpi_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.qc_issue		= pacpi_qc_issue_prot,
+	.qc_issue		= pacpi_qc_issue,
 	.cable_detect		= pacpi_cable_detect,
 	.mode_filter		= pacpi_mode_filter,
 	.set_piomode		= pacpi_set_piomode,
@@ -259,7 +259,7 @@ static int pacpi_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops	= &pacpi_ops,
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_init_one(pdev, ppi, &pacpi_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &pacpi_sht, NULL);
 }
 
 static const struct pci_device_id pacpi_pci_tbl[] = {
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 3271793..d676e94 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -117,7 +117,7 @@ static unsigned long ali_20_filter(struct ata_device *adev, unsigned long mask)
 	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	if (strstr(model_num, "WDC"))
 		return mask &= ~ATA_MASK_UDMA;
-	return ata_pci_default_filter(adev, mask);
+	return ata_bmdma_mode_filter(adev, mask);
 }
 
 /**
@@ -409,7 +409,7 @@ static void ali_init_chipset(struct pci_dev *pdev)
 	}
 	pci_dev_put(isa_bridge);
 	pci_dev_put(north);
-	ata_pci_clear_simplex(pdev);
+	ata_pci_bmdma_clear_simplex(pdev);
 }
 /**
  *	ali_init_one		-	discovery callback
@@ -512,7 +512,7 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	        	ppi[0] = &info_20_udma;
 		pci_dev_put(isa_bridge);
 	}
-	return ata_pci_init_one(pdev, ppi, &ali_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &ali_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 09c8286..87cb7e1 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -141,7 +141,7 @@ static int amd_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 static int amd_cable_detect(struct ata_port *ap)
@@ -291,7 +291,7 @@ static int nv_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &nv_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -501,7 +501,7 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	ppi[0] = &info[type];
 
 	if (type < 3)
-		ata_pci_clear_simplex(pdev);
+		ata_pci_bmdma_clear_simplex(pdev);
 
 	/* Check for AMD7411 */
 	if (type == 3)
@@ -521,7 +521,7 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	/* And fire it up */
-	return ata_pci_init_one(pdev, ppi, &amd_sht, hpriv);
+	return ata_pci_sff_init_one(pdev, ppi, &amd_sht, hpriv);
 }
 
 #ifdef CONFIG_PM
@@ -544,7 +544,7 @@ static int amd_reinit_one(struct pci_dev *pdev)
 			pci_write_config_byte(pdev, 0x41, fifo | 0xF0);
 		if (pdev->device == PCI_DEVICE_ID_AMD_VIPER_7409 ||
 		    pdev->device == PCI_DEVICE_ID_AMD_COBRA_7401)
-		    	ata_pci_clear_simplex(pdev);
+			ata_pci_bmdma_clear_simplex(pdev);
 	}
 
 	ata_host_resume(host);
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index b6d8c4d..0f513bc 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -52,7 +52,7 @@ static int artop6210_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -78,7 +78,7 @@ static int artop6260_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (pdev->device % 1 && !pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -400,7 +400,7 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 
 	BUG_ON(ppi[0] == NULL);
 
-	return ata_pci_init_one(pdev, ppi, &artop_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &artop_sht, NULL);
 }
 
 static const struct pci_device_id artop_pci_tbl[] = {
diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index 5283155..3e8651d 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -223,7 +223,7 @@ static int __init pata_at32_init_one(struct device *dev,
 	host->private_data = info;
 
 	/* Register ATA device and return */
-	return ata_host_activate(host, info->irq, ata_interrupt,
+	return ata_host_activate(host, info->irq, ata_sff_interrupt,
 				 IRQF_SHARED | IRQF_TRIGGER_RISING,
 				 &at32_sht);
 }
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 56a65ba..78738fb 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -45,7 +45,7 @@ static int atiixp_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 static int atiixp_cable_detect(struct ata_port *ap)
@@ -223,7 +223,7 @@ static struct scsi_host_template atiixp_sht = {
 static struct ata_port_operations atiixp_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 
-	.qc_prep 	= ata_dumb_qc_prep,
+	.qc_prep 	= ata_sff_dumb_qc_prep,
 	.bmdma_start 	= atiixp_bmdma_start,
 	.bmdma_stop	= atiixp_bmdma_stop,
 
@@ -243,7 +243,7 @@ static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.port_ops = &atiixp_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_init_one(dev, ppi, &atiixp_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &atiixp_sht, NULL);
 }
 
 static const struct pci_device_id atiixp[] = {
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 457ac80..c854e88 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -674,7 +674,7 @@ static void read_atapi_data(void __iomem *base,
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
  *
- *	Note: Original code is ata_tf_load().
+ *	Note: Original code is ata_sff_tf_load().
  */
 
 static void bfin_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
@@ -745,7 +745,7 @@ static u8 bfin_check_status(struct ata_port *ap)
  *	@ap: Port from which input is read
  *	@tf: ATA taskfile register set for storing input
  *
- *	Note: Original code is ata_tf_read().
+ *	Note: Original code is ata_sff_tf_read().
  */
 
 static void bfin_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
@@ -775,7 +775,7 @@ static void bfin_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
  *
- *	Note: Original code is ata_exec_command().
+ *	Note: Original code is ata_sff_exec_command().
  */
 
 static void bfin_exec_command(struct ata_port *ap,
@@ -785,7 +785,7 @@ static void bfin_exec_command(struct ata_port *ap,
 	dev_dbg(ap->dev, "ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 
 	write_atapi_register(base, ATA_REG_CMD, tf->command);
-	ata_pause(ap);
+	ata_sff_pause(ap);
 }
 
 /**
@@ -800,14 +800,14 @@ static u8 bfin_check_altstatus(struct ata_port *ap)
 }
 
 /**
- *	bfin_std_dev_select - Select device 0/1 on ATA bus
+ *	bfin_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
  *	@device: ATA device (numbered from zero) to select
  *
- *	Note: Original code is ata_std_dev_select().
+ *	Note: Original code is ata_sff_dev_select().
  */
 
-static void bfin_std_dev_select(struct ata_port *ap, unsigned int device)
+static void bfin_dev_select(struct ata_port *ap, unsigned int device)
 {
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
 	u8 tmp;
@@ -818,7 +818,7 @@ static void bfin_std_dev_select(struct ata_port *ap, unsigned int device)
 		tmp = ATA_DEVICE_OBS | ATA_DEV1;
 
 	write_atapi_register(base, ATA_REG_DEVICE, tmp);
-	ata_pause(ap);
+	ata_sff_pause(ap);
 }
 
 /**
@@ -977,7 +977,7 @@ static unsigned int bfin_devchk(struct ata_port *ap,
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
 	u8 nsect, lbal;
 
-	bfin_std_dev_select(ap, device);
+	bfin_dev_select(ap, device);
 
 	write_atapi_register(base, ATA_REG_NSECT, 0x55);
 	write_atapi_register(base, ATA_REG_LBAL, 0xaa);
@@ -1014,7 +1014,7 @@ static void bfin_bus_post_reset(struct ata_port *ap, unsigned int devmask)
 	 * BSY bit to clear
 	 */
 	if (dev0)
-		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+		ata_sff_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 
 	/* if device 1 was found in ata_devchk, wait for
 	 * register access, then wait for BSY to clear
@@ -1023,7 +1023,7 @@ static void bfin_bus_post_reset(struct ata_port *ap, unsigned int devmask)
 	while (dev1) {
 		u8 nsect, lbal;
 
-		bfin_std_dev_select(ap, 1);
+		bfin_dev_select(ap, 1);
 		nsect = read_atapi_register(base, ATA_REG_NSECT);
 		lbal = read_atapi_register(base, ATA_REG_LBAL);
 		if ((nsect == 1) && (lbal == 1))
@@ -1035,14 +1035,14 @@ static void bfin_bus_post_reset(struct ata_port *ap, unsigned int devmask)
 		msleep(50);	/* give drive a breather */
 	}
 	if (dev1)
-		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+		ata_sff_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 
 	/* is all this really necessary? */
-	bfin_std_dev_select(ap, 0);
+	bfin_dev_select(ap, 0);
 	if (dev1)
-		bfin_std_dev_select(ap, 1);
+		bfin_dev_select(ap, 1);
 	if (dev0)
-		bfin_std_dev_select(ap, 0);
+		bfin_dev_select(ap, 0);
 }
 
 /**
@@ -1088,15 +1088,15 @@ static unsigned int bfin_bus_softreset(struct ata_port *ap,
 }
 
 /**
- *	bfin_std_softreset - reset host port via ATA SRST
+ *	bfin_softreset - reset host port via ATA SRST
  *	@ap: port to reset
  *	@classes: resulting classes of attached devices
  *
- *	Note: Original code is ata_std_softreset().
+ *	Note: Original code is ata_sff_softreset().
  */
 
-static int bfin_std_softreset(struct ata_link *link, unsigned int *classes,
-		unsigned long deadline)
+static int bfin_softreset(struct ata_link *link, unsigned int *classes,
+			  unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
@@ -1115,7 +1115,7 @@ static int bfin_std_softreset(struct ata_link *link, unsigned int *classes,
 		devmask |= (1 << 1);
 
 	/* select device 0 again */
-	bfin_std_dev_select(ap, 0);
+	bfin_dev_select(ap, 0);
 
 	/* issue bus reset */
 	err_mask = bfin_bus_softreset(ap, devmask);
@@ -1126,10 +1126,10 @@ static int bfin_std_softreset(struct ata_link *link, unsigned int *classes,
 	}
 
 	/* determine by signature whether we have ATA or ATAPI devices */
-	classes[0] = ata_dev_try_classify(&ap->link.device[0],
+	classes[0] = ata_sff_dev_classify(&ap->link.device[0],
 				devmask & (1 << 0), &err);
 	if (slave_possible && err != 0x81)
-		classes[1] = ata_dev_try_classify(&ap->link.device[1],
+		classes[1] = ata_sff_dev_classify(&ap->link.device[1],
 					devmask & (1 << 1), &err);
 
  out:
@@ -1167,7 +1167,7 @@ static unsigned char bfin_bmdma_status(struct ata_port *ap)
  *	@buflen: buffer length
  *	@write_data: read/write
  *
- *	Note: Original code is ata_data_xfer().
+ *	Note: Original code is ata_sff_data_xfer().
  */
 
 static unsigned int bfin_data_xfer(struct ata_device *dev, unsigned char *buf,
@@ -1206,7 +1206,7 @@ static unsigned int bfin_data_xfer(struct ata_device *dev, unsigned char *buf,
  *	bfin_irq_clear - Clear ATAPI interrupt.
  *	@ap: Port associated with this ATA transaction.
  *
- *	Note: Original code is ata_bmdma_irq_clear().
+ *	Note: Original code is ata_sff_irq_clear().
  */
 
 static void bfin_irq_clear(struct ata_port *ap)
@@ -1223,7 +1223,7 @@ static void bfin_irq_clear(struct ata_port *ap)
  *	bfin_irq_on - Enable interrupts on a port.
  *	@ap: Port on which interrupts are enabled.
  *
- *	Note: Original code is ata_irq_on().
+ *	Note: Original code is ata_sff_irq_on().
  */
 
 static unsigned char bfin_irq_on(struct ata_port *ap)
@@ -1244,13 +1244,13 @@ static unsigned char bfin_irq_on(struct ata_port *ap)
 }
 
 /**
- *	bfin_bmdma_freeze - Freeze DMA controller port
+ *	bfin_freeze - Freeze DMA controller port
  *	@ap: port to freeze
  *
- *	Note: Original code is ata_bmdma_freeze().
+ *	Note: Original code is ata_sff_freeze().
  */
 
-static void bfin_bmdma_freeze(struct ata_port *ap)
+static void bfin_freeze(struct ata_port *ap)
 {
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
 
@@ -1270,13 +1270,13 @@ static void bfin_bmdma_freeze(struct ata_port *ap)
 }
 
 /**
- *	bfin_bmdma_thaw - Thaw DMA controller port
+ *	bfin_thaw - Thaw DMA controller port
  *	@ap: port to thaw
  *
- *	Note: Original code is ata_bmdma_thaw().
+ *	Note: Original code is ata_sff_thaw().
  */
 
-void bfin_bmdma_thaw(struct ata_port *ap)
+void bfin_thaw(struct ata_port *ap)
 {
 	bfin_check_status(ap);
 	bfin_irq_clear(ap);
@@ -1284,14 +1284,14 @@ void bfin_bmdma_thaw(struct ata_port *ap)
 }
 
 /**
- *	bfin_std_postreset - standard postreset callback
+ *	bfin_postreset - standard postreset callback
  *	@ap: the target ata_port
  *	@classes: classes of attached devices
  *
- *	Note: Original code is ata_std_postreset().
+ *	Note: Original code is ata_sff_postreset().
  */
 
-static void bfin_std_postreset(struct ata_link *link, unsigned int *classes)
+static void bfin_postreset(struct ata_link *link, unsigned int *classes)
 {
 	struct ata_port *ap = link->ap;
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
@@ -1301,9 +1301,9 @@ static void bfin_std_postreset(struct ata_link *link, unsigned int *classes)
 
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
-		bfin_std_dev_select(ap, 1);
+		bfin_dev_select(ap, 1);
 	if (classes[1] != ATA_DEV_NONE)
-		bfin_std_dev_select(ap, 0);
+		bfin_dev_select(ap, 0);
 
 	/* bail out if no device is present */
 	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
@@ -1362,7 +1362,7 @@ static const struct ata_port_operations bfin_pata_ops = {
 	.exec_command		= bfin_exec_command,
 	.check_status		= bfin_check_status,
 	.check_altstatus	= bfin_check_altstatus,
-	.dev_select		= bfin_std_dev_select,
+	.dev_select		= bfin_dev_select,
 
 	.bmdma_setup		= bfin_bmdma_setup,
 	.bmdma_start		= bfin_bmdma_start,
@@ -1372,10 +1372,10 @@ static const struct ata_port_operations bfin_pata_ops = {
 
 	.qc_prep		= ata_noop_qc_prep,
 
-	.freeze			= bfin_bmdma_freeze,
-	.thaw			= bfin_bmdma_thaw,
-	.softreset		= bfin_std_softreset,
-	.postreset		= bfin_std_postreset,
+	.freeze			= bfin_freeze,
+	.thaw			= bfin_thaw,
+	.softreset		= bfin_softreset,
+	.postreset		= bfin_postreset,
 	.post_internal_cmd	= bfin_bmdma_stop,
 
 	.irq_clear		= bfin_irq_clear,
@@ -1513,7 +1513,7 @@ static int __devinit bfin_atapi_probe(struct platform_device *pdev)
 	}
 
 	if (ata_host_activate(host, platform_get_irq(pdev, 0),
-		ata_interrupt, IRQF_SHARED, &bfin_sht) != 0) {
+		ata_sff_interrupt, IRQF_SHARED, &bfin_sht) != 0) {
 		peripheral_free_list(atapi_io_port);
 		dev_err(&pdev->dev, "Fail to attach ATAPI device\n");
 		return -ENODEV;
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 27219b0..a907cf4 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -107,8 +107,8 @@ static void cmd640_set_piomode(struct ata_port *ap, struct ata_device *adev)
 		pci_write_config_byte(pdev, arttim + 1, (t.active << 4) | t.recover);
 	} else {
 		/* Save the shared timings for channel, they will be loaded
-		   by qc_issue_prot. Reloading the setup time is expensive
-		   so we keep a merged one loaded */
+		   by qc_issue. Reloading the setup time is expensive so we
+		   keep a merged one loaded */
 		pci_read_config_byte(pdev, ARTIM23, &reg);
 		reg &= 0x3F;
 		reg |= t.setup;
@@ -119,14 +119,14 @@ static void cmd640_set_piomode(struct ata_port *ap, struct ata_device *adev)
 
 
 /**
- *	cmd640_qc_issue_prot	-	command preparation hook
+ *	cmd640_qc_issue	-	command preparation hook
  *	@qc: Command to be issued
  *
  *	Channel 1 has shared timings. We must reprogram the
  *	clock each drive 2/3 switch we do.
  */
 
-static unsigned int cmd640_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int cmd640_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -137,7 +137,7 @@ static unsigned int cmd640_qc_issue_prot(struct ata_queued_cmd *qc)
 		pci_write_config_byte(pdev, DRWTIM23, timing->reg58[adev->devno]);
 		timing->last = adev->devno;
 	}
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 /**
@@ -172,8 +172,8 @@ static struct scsi_host_template cmd640_sht = {
 static struct ata_port_operations cmd640_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 	/* In theory xfer_noirq is not needed once we kill the prefetcher */
-	.data_xfer	= ata_data_xfer_noirq,
-	.qc_issue	= cmd640_qc_issue_prot,
+	.data_xfer	= ata_sff_data_xfer_noirq,
+	.qc_issue	= cmd640_qc_issue,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= cmd640_set_piomode,
 	.port_start	= cmd640_port_start,
@@ -224,7 +224,7 @@ static int cmd640_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cmd640_hardware_init(pdev);
 
-	return ata_pci_init_one(pdev, ppi, &cmd640_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &cmd640_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index f0e5666..ddd09b7 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -349,7 +349,7 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	class_rev &= 0xFF;
 
 	if (id->driver_data == 0)	/* 643 */
-		ata_pci_clear_simplex(pdev);
+		ata_pci_bmdma_clear_simplex(pdev);
 
 	if (pdev->device == PCI_DEVICE_ID_CMD_646) {
 		/* Does UDMA work ? */
@@ -373,7 +373,7 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_write_config_byte(pdev, UDIDETCR0, 0xF0);
 #endif
 
-	return ata_pci_init_one(pdev, ppi, &cmd64x_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &cmd64x_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 46d0ce3..1186bcd 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -146,7 +146,7 @@ static struct scsi_host_template cs5520_sht = {
 
 static struct ata_port_operations cs5520_port_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.qc_prep		= ata_dumb_qc_prep,
+	.qc_prep		= ata_sff_dumb_qc_prep,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= cs5520_set_piomode,
 	.set_dmamode		= cs5520_set_dmamode,
@@ -227,7 +227,7 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 	ioaddr->ctl_addr = iomap[1];
 	ioaddr->altstatus_addr = iomap[1];
 	ioaddr->bmdma_addr = iomap[4];
-	ata_std_ports(ioaddr);
+	ata_sff_std_ports(ioaddr);
 
 	ata_port_desc(host->ports[0],
 		      "cmd 0x%x ctl 0x%x", cmd_port[0], ctl_port[0]);
@@ -238,7 +238,7 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 	ioaddr->ctl_addr = iomap[3];
 	ioaddr->altstatus_addr = iomap[3];
 	ioaddr->bmdma_addr = iomap[4] + 8;
-	ata_std_ports(ioaddr);
+	ata_sff_std_ports(ioaddr);
 
 	ata_port_desc(host->ports[1],
 		      "cmd 0x%x ctl 0x%x", cmd_port[1], ctl_port[1]);
@@ -258,7 +258,7 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 			continue;
 
 		rc = devm_request_irq(&pdev->dev, irq[ap->port_no],
-				      ata_interrupt, 0, DRV_NAME, host);
+				      ata_sff_interrupt, 0, DRV_NAME, host);
 		if (rc)
 			return rc;
 
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index ac3ad55..744beeb 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -133,7 +133,7 @@ static void cs5530_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	cs5530_qc_issue_prot	-	command issue
+ *	cs5530_qc_issue		-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -142,7 +142,7 @@ static void cs5530_set_dmamode(struct ata_port *ap, struct ata_device *adev)
  *	one MWDMA/UDMA bit.
  */
 
-static unsigned int cs5530_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int cs5530_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -157,7 +157,7 @@ static unsigned int cs5530_qc_issue_prot(struct ata_queued_cmd *qc)
 		    	cs5530_set_dmamode(ap, adev);
 	}
 
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static struct scsi_host_template cs5530_sht = {
@@ -168,8 +168,8 @@ static struct scsi_host_template cs5530_sht = {
 static struct ata_port_operations cs5530_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 
-	.qc_prep 	= ata_dumb_qc_prep,
-	.qc_issue	= cs5530_qc_issue_prot,
+	.qc_prep 	= ata_sff_dumb_qc_prep,
+	.qc_issue	= cs5530_qc_issue,
 
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= cs5530_set_piomode,
@@ -325,7 +325,7 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ppi[1] = &info_palmax_secondary;
 
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(pdev, ppi, &cs5530_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &cs5530_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 5c0762e..f1b6556 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -199,7 +199,7 @@ static int cs5535_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	rdmsr(ATAC_CH0D1_PIO, timings, dummy);
 	if (CS5535_BAD_PIO(timings))
 		wrmsr(ATAC_CH0D1_PIO, 0xF7F4F7F4UL, 0);
-	return ata_pci_init_one(dev, ppi, &cs5535_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &cs5535_sht, NULL);
 }
 
 static const struct pci_device_id cs5535[] = {
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 2d34b91..73f8332 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -261,7 +261,7 @@ static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENODEV;
 	}
 
-	return ata_pci_init_one(dev, ppi, &cs5536_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &cs5536_sht, NULL);
 }
 
 static const struct pci_device_id cs5536[] = {
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index ae14969..a9c3218 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -136,7 +136,7 @@ static int cy82c693_init_one(struct pci_dev *pdev, const struct pci_device_id *i
 	if (PCI_FUNC(pdev->devfn) != 1)
 		return -ENODEV;
 
-	return ata_pci_init_one(pdev, ppi, &cy82c693_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &cy82c693_sht, NULL);
 }
 
 static const struct pci_device_id cy82c693[] = {
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index 1d839a5..9fba829 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -45,7 +45,7 @@ static int efar_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &efar_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -262,7 +262,7 @@ static int efar_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi, &efar_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &efar_sht, NULL);
 }
 
 static const struct pci_device_id efar_pci_tbl[] = {
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index c2d4923..f2b83ea 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -184,7 +184,7 @@ static unsigned long hpt366_filter(struct ata_device *adev, unsigned long mask)
 		if (hpt_dma_blacklisted(adev, "UDMA4", bad_ata66_4))
 			mask &= ~(0xF0 << ATA_SHIFT_UDMA);
 	}
-	return ata_pci_default_filter(adev, mask);
+	return ata_bmdma_mode_filter(adev, mask);
 }
 
 /**
@@ -393,7 +393,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 			break;
 	}
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi, &hpt36x_sht, hpriv);
+	return ata_pci_sff_init_one(dev, ppi, &hpt36x_sht, hpriv);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index c10fcd3..4216399 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -283,7 +283,7 @@ static unsigned long hpt370_filter(struct ata_device *adev, unsigned long mask)
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
 			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
-	return ata_pci_default_filter(adev, mask);
+	return ata_bmdma_mode_filter(adev, mask);
 }
 
 /**
@@ -299,7 +299,7 @@ static unsigned long hpt370a_filter(struct ata_device *adev, unsigned long mask)
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
 			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
-	return ata_pci_default_filter(adev, mask);
+	return ata_bmdma_mode_filter(adev, mask);
 }
 
 /**
@@ -338,7 +338,7 @@ static int hpt37x_pre_reset(struct ata_link *link, unsigned long deadline)
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 static int hpt374_fn1_pre_reset(struct ata_link *link, unsigned long deadline)
@@ -374,7 +374,7 @@ static int hpt374_fn1_pre_reset(struct ata_link *link, unsigned long deadline)
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -1019,7 +1019,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi, &hpt37x_sht, private_data);
+	return ata_pci_sff_init_one(dev, ppi, &hpt37x_sht, private_data);
 }
 
 static const struct pci_device_id hpt37x[] = {
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index cd44ee3..d5c9fd7 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -156,7 +156,7 @@ static int hpt3x2n_pre_reset(struct ata_link *link, unsigned long deadline)
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -308,7 +308,7 @@ static int hpt3x2n_use_dpll(struct ata_port *ap, int writing)
 	return 0;
 }
 
-static unsigned int hpt3x2n_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int hpt3x2n_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_port *ap = qc->ap;
@@ -323,7 +323,7 @@ static unsigned int hpt3x2n_qc_issue_prot(struct ata_queued_cmd *qc)
 				hpt3x2n_set_clock(ap, 0x23);
 		}
 	}
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static struct scsi_host_template hpt3x2n_sht = {
@@ -338,7 +338,7 @@ static struct ata_port_operations hpt3x2n_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 
 	.bmdma_stop	= hpt3x2n_bmdma_stop,
-	.qc_issue	= hpt3x2n_qc_issue_prot,
+	.qc_issue	= hpt3x2n_qc_issue,
 
 	.cable_detect	= hpt3x2n_cable_detect,
 	.set_piomode	= hpt3x2n_set_piomode,
@@ -554,7 +554,7 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi, &hpt3x2n_sht, hpriv);
+	return ata_pci_sff_init_one(dev, ppi, &hpt3x2n_sht, hpriv);
 }
 
 static const struct pci_device_id hpt3x2n[] = {
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 8857d02..f11a320 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -202,15 +202,15 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ioaddr->altstatus_addr =
 		ioaddr->ctl_addr = base + offset_ctl[i];
 		ioaddr->scr_addr = NULL;
-		ata_std_ports(ioaddr);
+		ata_sff_std_ports(ioaddr);
 		ioaddr->bmdma_addr = base + 8 * i;
 
 		ata_port_pbar_desc(ap, 4, -1, "ioport");
 		ata_port_pbar_desc(ap, 4, offset_cmd[i], "cmd");
 	}
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
-				 &hpt3x3_sht);
+	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+				 IRQF_SHARED, &hpt3x3_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 13d43e9..52de9f9 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -270,7 +270,7 @@ static void pata_icside_bmdma_stop(struct ata_queued_cmd *qc)
 	disable_dma(state->dma);
 
 	/* see ata_bmdma_stop */
-	ata_altstatus(ap);
+	ata_sff_altstatus(ap);
 }
 
 static u8 pata_icside_bmdma_status(struct ata_port *ap)
@@ -316,7 +316,7 @@ static void pata_icside_postreset(struct ata_link *link, unsigned int *classes)
 	struct pata_icside_state *state = ap->host->private_data;
 
 	if (classes[0] != ATA_DEV_NONE || classes[1] != ATA_DEV_NONE)
-		return ata_std_postreset(link, classes);
+		return ata_sff_postreset(link, classes);
 
 	state->port[ap->port_no].disabled = 1;
 
@@ -336,7 +336,7 @@ static struct ata_port_operations pata_icside_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 	/* no need to build any PRD tables for DMA */
 	.qc_prep		= ata_noop_qc_prep,
-	.data_xfer		= ata_data_xfer_noirq,
+	.data_xfer		= ata_sff_data_xfer_noirq,
 	.bmdma_setup		= pata_icside_bmdma_setup,
 	.bmdma_start		= pata_icside_bmdma_start,
 	.bmdma_stop		= pata_icside_bmdma_stop,
@@ -481,7 +481,7 @@ static int __devinit pata_icside_add_ports(struct pata_icside_info *info)
 		pata_icside_setup_ioaddr(ap, info->base, info, info->port[i]);
 	}
 
-	return ata_host_activate(host, ec->irq, ata_interrupt, 0,
+	return ata_host_activate(host, ec->irq, ata_sff_interrupt, 0,
 				 &pata_icside_sht);
 }
 
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 085913e..6a111ba 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -50,7 +50,7 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 
 	if (pnp_irq_valid(idev, 0)) {
 		irq = pnp_irq(idev, 0);
-		handler = ata_interrupt;
+		handler = ata_sff_interrupt;
 	}
 
 	/* allocate host */
@@ -78,7 +78,7 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 		ap->ioaddr.ctl_addr = ctl_addr;
 	}
 
-	ata_std_ports(&ap->ioaddr);
+	ata_sff_std_ports(&ap->ioaddr);
 
 	ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
 		      (unsigned long long)pnp_port_start(idev, 0),
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 84ab89e..c113d7c 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -40,7 +40,7 @@ static int it8213_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &it8213_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -274,7 +274,7 @@ static int it8213_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi, &it8213_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &it8213_sht, NULL);
 }
 
 static const struct pci_device_id it8213_pci_tbl[] = {
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 6a8a4dd..88e37cf 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -395,11 +395,11 @@ static void it821x_passthru_dev_select(struct ata_port *ap,
 		it821x_program(ap, adev, itdev->pio[adev->devno]);
 		itdev->last_device = device;
 	}
-	ata_std_dev_select(ap, device);
+	ata_sff_dev_select(ap, device);
 }
 
 /**
- *	it821x_smart_qc_issue_prot	-	wrap qc issue prot
+ *	it821x_smart_qc_issue		-	wrap qc issue prot
  *	@qc: command
  *
  *	Wrap the command issue sequence for the IT821x. We need to
@@ -407,7 +407,7 @@ static void it821x_passthru_dev_select(struct ata_port *ap,
  *	usual happenings kick off
  */
 
-static unsigned int it821x_smart_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int it821x_smart_qc_issue(struct ata_queued_cmd *qc)
 {
 	switch(qc->tf.command)
 	{
@@ -427,14 +427,14 @@ static unsigned int it821x_smart_qc_issue_prot(struct ata_queued_cmd *qc)
 		case ATA_CMD_ID_ATA:
 		/* Arguably should just no-op this one */
 		case ATA_CMD_SET_FEATURES:
-			return ata_qc_issue_prot(qc);
+			return ata_sff_qc_issue(qc);
 	}
 	printk(KERN_DEBUG "it821x: can't process command 0x%02X\n", qc->tf.command);
 	return AC_ERR_DEV;
 }
 
 /**
- *	it821x_passthru_qc_issue_prot	-	wrap qc issue prot
+ *	it821x_passthru_qc_issue	-	wrap qc issue prot
  *	@qc: command
  *
  *	Wrap the command issue sequence for the IT821x. We need to
@@ -442,10 +442,10 @@ static unsigned int it821x_smart_qc_issue_prot(struct ata_queued_cmd *qc)
  *	usual happenings kick off
  */
 
-static unsigned int it821x_passthru_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int it821x_passthru_qc_issue(struct ata_queued_cmd *qc)
 {
 	it821x_passthru_dev_select(qc->ap, qc->dev->devno);
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 /**
@@ -639,7 +639,7 @@ static struct ata_port_operations it821x_smart_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 
 	.check_atapi_dma= it821x_check_atapi_dma,
-	.qc_issue	= it821x_smart_qc_issue_prot,
+	.qc_issue	= it821x_smart_qc_issue,
 
 	.cable_detect	= it821x_ident_hack,
 	.set_mode	= it821x_smart_set_mode,
@@ -655,7 +655,7 @@ static struct ata_port_operations it821x_passthru_port_ops = {
 	.dev_select 	= it821x_passthru_dev_select,
 	.bmdma_start 	= it821x_passthru_bmdma_start,
 	.bmdma_stop	= it821x_passthru_bmdma_stop,
-	.qc_issue	= it821x_passthru_qc_issue_prot,
+	.qc_issue	= it821x_passthru_qc_issue,
 
 	.cable_detect	= ata_cable_unknown,
 	.set_piomode	= it821x_passthru_set_piomode,
@@ -722,7 +722,7 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	else
 		ppi[0] = &info_smart;
 
-	return ata_pci_init_one(pdev, ppi, &it821x_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &it821x_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index d02629a..283a8fb 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -110,7 +110,7 @@ static void ixp4xx_setup_port(struct ata_port *ap,
 	ioaddr->altstatus_addr	= data->cs1 + 0x06;
 	ioaddr->ctl_addr	= data->cs1 + 0x06;
 
-	ata_std_ports(ioaddr);
+	ata_sff_std_ports(ioaddr);
 
 #ifndef __ARMEB__
 
@@ -186,7 +186,7 @@ static __devinit int ixp4xx_pata_probe(struct platform_device *pdev)
 	dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
 	/* activate host */
-	return ata_host_activate(host, irq, ata_interrupt, 0, &ixp4xx_sht);
+	return ata_host_activate(host, irq, ata_sff_interrupt, 0, &ixp4xx_sht);
 }
 
 static __devexit int ixp4xx_pata_remove(struct platform_device *dev)
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 317f347..73b7596 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -102,7 +102,7 @@ static int jmicron_pre_reset(struct ata_link *link, unsigned long deadline)
 		ap->cbl = ATA_CBL_SATA;
 		break;
 	}
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /* No PIO or DMA methods needed for this device */
@@ -144,7 +144,7 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
 
-	return ata_pci_init_one(pdev, ppi, &jmicron_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &jmicron_sht, NULL);
 }
 
 static const struct pci_device_id jmicron_pci_tbl[] = {
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 2474068..f13f10a 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -226,12 +226,12 @@ static const struct ata_port_operations legacy_base_port_ops = {
 
 static struct ata_port_operations simple_port_ops = {
 	.inherits	= &legacy_base_port_ops,
-	.data_xfer	= ata_data_xfer_noirq,
+	.data_xfer	= ata_sff_data_xfer_noirq,
 };
 
 static struct ata_port_operations legacy_port_ops = {
 	.inherits	= &legacy_base_port_ops,
-	.data_xfer	= ata_data_xfer_noirq,
+	.data_xfer	= ata_sff_data_xfer_noirq,
 	.set_mode	= legacy_set_mode,
 };
 
@@ -317,7 +317,7 @@ static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
 		}
 		local_irq_restore(flags);
 	} else
-		buflen = ata_data_xfer_noirq(dev, buf, buflen, rw);
+		buflen = ata_sff_data_xfer_noirq(dev, buf, buflen, rw);
 
 	return buflen;
 }
@@ -579,7 +579,7 @@ static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	opt82c465mv_qc_issue_prot	-	command issue
+ *	opt82c465mv_qc_issue		-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -593,7 +593,7 @@ static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
  *	FIXME: dual channel needs ->serialize support
  */
 
-static unsigned int opti82c46x_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int opti82c46x_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -604,13 +604,13 @@ static unsigned int opti82c46x_qc_issue_prot(struct ata_queued_cmd *qc)
 	    && ap->host->private_data != NULL)
 		opti82c46x_set_piomode(ap, adev);
 
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static struct ata_port_operations opti82c46x_port_ops = {
 	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= opti82c46x_set_piomode,
-	.qc_issue	= opti82c46x_qc_issue_prot,
+	.qc_issue	= opti82c46x_qc_issue,
 };
 
 static void qdi6500_set_piomode(struct ata_port *ap, struct ata_device *adev)
@@ -644,7 +644,7 @@ static void qdi6500_set_piomode(struct ata_port *ap, struct ata_device *adev)
  *	@irq: interrupt line
  *
  *	In dual channel mode the 6580 has one clock per channel and we have
- *	to software clockswitch in qc_issue_prot.
+ *	to software clockswitch in qc_issue.
  */
 
 static void qdi6580dp_set_piomode(struct ata_port *ap, struct ata_device *adev)
@@ -710,14 +710,14 @@ static void qdi6580_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	qdi_qc_issue_prot	-	command issue
+ *	qdi_qc_issue		-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
  *	this interface so that we can load the correct ATA timings.
  */
 
-static unsigned int qdi_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int qdi_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -730,7 +730,7 @@ static unsigned int qdi_qc_issue_prot(struct ata_queued_cmd *qc)
 							2 * ap->port_no);
 		}
 	}
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static unsigned int vlb32_data_xfer(struct ata_device *adev, unsigned char *buf,
@@ -759,7 +759,7 @@ static unsigned int vlb32_data_xfer(struct ata_device *adev, unsigned char *buf,
 		}
 		return (buflen + 3) & ~3;
 	} else
-		return ata_data_xfer(adev, buf, buflen, rw);
+		return ata_sff_data_xfer(adev, buf, buflen, rw);
 }
 
 static int qdi_port(struct platform_device *dev,
@@ -774,7 +774,7 @@ static int qdi_port(struct platform_device *dev,
 static struct ata_port_operations qdi6500_port_ops = {
 	.inherits	= &legacy_base_port_ops,
 	.set_piomode	= qdi6500_set_piomode,
-	.qc_issue	= qdi_qc_issue_prot,
+	.qc_issue	= qdi_qc_issue,
 	.data_xfer	= vlb32_data_xfer,
 };
 
@@ -1016,13 +1016,13 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 	ap->ioaddr.cmd_addr = io_addr;
 	ap->ioaddr.altstatus_addr = ctrl_addr;
 	ap->ioaddr.ctl_addr = ctrl_addr;
-	ata_std_ports(&ap->ioaddr);
+	ata_sff_std_ports(&ap->ioaddr);
 	ap->host->private_data = ld;
 
 	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", io, io + 0x0206);
 
-	ret = ata_host_activate(host, probe->irq, ata_interrupt, 0,
-								&legacy_sht);
+	ret = ata_host_activate(host, probe->irq, ata_sff_interrupt, 0,
+				&legacy_sht);
 	if (ret)
 		goto fail;
 	ld->platform_dev = pdev;
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index d38e64c..24a011b 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -55,7 +55,7 @@ static int marvell_pre_reset(struct ata_link *link, unsigned long deadline)
 	    (!(devices & 0x10)))	/* PATA enable ? */
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 static int marvell_cable_detect(struct ata_port *ap)
@@ -128,7 +128,7 @@ static int marvell_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 	if (pdev->device == 0x6101)
 		ppi[1] = &ata_dummy_port_info;
 
-	return ata_pci_init_one(pdev, ppi, &marvell_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &marvell_sht, NULL);
 }
 
 static const struct pci_device_id marvell_pci_tbl[] = {
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index fec9319..5d1d32a 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -252,7 +252,7 @@ mpc52xx_ata_dev_select(struct ata_port *ap, unsigned int device)
 	if (device != priv->csel)
 		mpc52xx_ata_apply_timings(priv, device);
 
-	ata_std_dev_select(ap,device);
+	ata_sff_dev_select(ap,device);
 }
 
 static struct scsi_host_template mpc52xx_ata_sht = {
@@ -305,7 +305,7 @@ mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv,
 	ata_port_desc(ap, "ata_regs 0x%lx", raw_ata_regs);
 
 	/* activate host */
-	return ata_host_activate(host, priv->ata_irq, ata_interrupt, 0,
+	return ata_host_activate(host, priv->ata_irq, ata_sff_interrupt, 0,
 				 &mpc52xx_ata_sht);
 }
 
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 1b9d0d4..7d7e3fd 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -55,7 +55,7 @@ static int mpiix_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &mpiix_enable_bits))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -69,8 +69,8 @@ static int mpiix_pre_reset(struct ata_link *link, unsigned long deadline)
  *
  *	This would get very ugly because we can only program timing for one
  *	device at a time, the other gets PIO0. Fortunately libata calls
- *	our qc_issue_prot command before a command is issued so we can
- *	flip the timings back and forth to reduce the pain.
+ *	our qc_issue command before a command is issued so we can flip the
+ *	timings back and forth to reduce the pain.
  */
 
 static void mpiix_set_piomode(struct ata_port *ap, struct ata_device *adev)
@@ -110,7 +110,7 @@ static void mpiix_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	mpiix_qc_issue_prot	-	command issue
+ *	mpiix_qc_issue		-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -120,7 +120,7 @@ static void mpiix_set_piomode(struct ata_port *ap, struct ata_device *adev)
  *	be made PIO0.
  */
 
-static unsigned int mpiix_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int mpiix_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -133,7 +133,7 @@ static unsigned int mpiix_qc_issue_prot(struct ata_queued_cmd *qc)
 	if (adev->pio_mode && adev != ap->private_data)
 		mpiix_set_piomode(ap, adev);
 
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static struct scsi_host_template mpiix_sht = {
@@ -142,7 +142,7 @@ static struct scsi_host_template mpiix_sht = {
 
 static struct ata_port_operations mpiix_port_ops = {
 	.inherits	= &ata_sff_port_ops,
-	.qc_issue	= mpiix_qc_issue_prot,
+	.qc_issue	= mpiix_qc_issue,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= mpiix_set_piomode,
 	.prereset	= mpiix_pre_reset,
@@ -207,10 +207,10 @@ static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	ap->ioaddr.altstatus_addr = ctl_addr;
 
 	/* Let libata fill in the port details */
-	ata_std_ports(&ap->ioaddr);
+	ata_sff_std_ports(&ap->ioaddr);
 
 	/* activate host */
-	return ata_host_activate(host, irq, ata_interrupt, IRQF_SHARED,
+	return ata_host_activate(host, irq, ata_sff_interrupt, IRQF_SHARED,
 				 &mpiix_sht);
 }
 
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 3491828..d9719c8 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -68,10 +68,10 @@ static int netcell_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		return rc;
 
 	/* Any chip specific setup/optimisation/messages here */
-	ata_pci_clear_simplex(pdev);
+	ata_pci_bmdma_clear_simplex(pdev);
 
 	/* And let the library code do the work */
-	return ata_pci_init_one(pdev, port_info, &netcell_sht, NULL);
+	return ata_pci_sff_init_one(pdev, port_info, &netcell_sht, NULL);
 }
 
 static const struct pci_device_id netcell_pci_tbl[] = {
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 8213d08..c9c0ea6 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -73,7 +73,7 @@ static void ninja32_dev_select(struct ata_port *ap, unsigned int device)
 	struct ata_device *adev = &ap->link.device[device];
 	if (ap->private_data != adev) {
 		iowrite8(0xd6, ap->ioaddr.bmdma_addr + 0x1f);
-		ata_std_dev_select(ap, device);
+		ata_sff_dev_select(ap, device);
 		ninja32_set_piomode(ap, adev);
 	}
 }
@@ -132,7 +132,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	ap->ioaddr.ctl_addr = base + 0x1E;
 	ap->ioaddr.altstatus_addr = base + 0x1E;
 	ap->ioaddr.bmdma_addr = base;
-	ata_std_ports(&ap->ioaddr);
+	ata_sff_std_ports(&ap->ioaddr);
 
 	iowrite8(0x05, base + 0x01);	/* Enable interrupt lines */
 	iowrite8(0xBE, base + 0x02);	/* Burst, ?? setup */
@@ -142,7 +142,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	iowrite8(0xa4, base + 0x1c);	/* Unknown */
 	iowrite8(0x83, base + 0x1d);	/* BMDMA control: WAIT0 */
 	/* FIXME: Should we disable them at remove ? */
-	return ata_host_activate(host, dev->irq, ata_interrupt,
+	return ata_host_activate(host, dev->irq, ata_sff_interrupt,
 				 IRQF_SHARED, &ninja32_sht);
 }
 
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 4d2eefe..76d2455 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -50,7 +50,7 @@ static int ns87410_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -105,7 +105,7 @@ static void ns87410_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	ns87410_qc_issue_prot	-	command issue
+ *	ns87410_qc_issue	-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -113,7 +113,7 @@ static void ns87410_set_piomode(struct ata_port *ap, struct ata_device *adev)
  *	necessary.
  */
 
-static unsigned int ns87410_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int ns87410_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -126,7 +126,7 @@ static unsigned int ns87410_qc_issue_prot(struct ata_queued_cmd *qc)
 	if (adev->pio_mode && adev != ap->private_data)
 		ns87410_set_piomode(ap, adev);
 
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static struct scsi_host_template ns87410_sht = {
@@ -135,7 +135,7 @@ static struct scsi_host_template ns87410_sht = {
 
 static struct ata_port_operations ns87410_port_ops = {
 	.inherits	= &ata_sff_port_ops,
-	.qc_issue	= ns87410_qc_issue_prot,
+	.qc_issue	= ns87410_qc_issue,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= ns87410_set_piomode,
 	.prereset	= ns87410_pre_reset,
@@ -149,7 +149,7 @@ static int ns87410_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.port_ops = &ns87410_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_init_one(dev, ppi, &ns87410_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &ns87410_sht, NULL);
 }
 
 static const struct pci_device_id ns87410[] = {
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index cdd79d6..03a52ce 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -172,14 +172,14 @@ static void ns87415_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ns87415_bmdma_irq_clear		-	Clear interrupt
+ *	ns87415_irq_clear		-	Clear interrupt
  *	@ap: Channel to clear
  *
  *	Erratum: Due to a chip bug regisers 02 and 0A bit 1 and 2 (the
  *	error bits) are reset by writing to register 00 or 08.
  */
 
-static void ns87415_bmdma_irq_clear(struct ata_port *ap)
+static void ns87415_irq_clear(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->ioaddr.bmdma_addr;
 
@@ -306,7 +306,7 @@ static struct ata_port_operations ns87415_pata_ops = {
 	.bmdma_setup		= ns87415_bmdma_setup,
 	.bmdma_start		= ns87415_bmdma_start,
 	.bmdma_stop		= ns87415_bmdma_stop,
-	.irq_clear		= ns87415_bmdma_irq_clear,
+	.irq_clear		= ns87415_irq_clear,
 
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= ns87415_set_piomode,
@@ -375,7 +375,7 @@ static int ns87415_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	pci_write_config_byte(pdev, 0x55, 0xEE);
 	/* Select PIO0 8bit clocking */
 	pci_write_config_byte(pdev, 0x54, 0xB7);
-	return ata_pci_init_one(pdev, ppi, &ns87415_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &ns87415_sht, NULL);
 }
 
 static const struct pci_device_id ns87415_pci_tbl[] = {
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index c1da79a..e678af3 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -47,7 +47,7 @@ static int oldpiix_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -181,7 +181,7 @@ static void oldpiix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	oldpiix_qc_issue_prot	-	command issue
+ *	oldpiix_qc_issue	-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -191,7 +191,7 @@ static void oldpiix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
  *	be made PIO0.
  */
 
-static unsigned int oldpiix_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int oldpiix_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -201,7 +201,7 @@ static unsigned int oldpiix_qc_issue_prot(struct ata_queued_cmd *qc)
 		if (adev->dma_mode)
 			oldpiix_set_dmamode(ap, adev);
 	}
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 
@@ -211,7 +211,7 @@ static struct scsi_host_template oldpiix_sht = {
 
 static struct ata_port_operations oldpiix_pata_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.qc_issue		= oldpiix_qc_issue_prot,
+	.qc_issue		= oldpiix_qc_issue,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= oldpiix_set_piomode,
 	.set_dmamode		= oldpiix_set_dmamode,
@@ -249,7 +249,7 @@ static int oldpiix_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi, &oldpiix_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &oldpiix_sht, NULL);
 }
 
 static const struct pci_device_id oldpiix_pci_tbl[] = {
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 4ddd03a..fb2cf66 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -64,7 +64,7 @@ static int opti_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &opti_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -173,7 +173,7 @@ static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(dev, ppi, &opti_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &opti_sht, NULL);
 }
 
 static const struct pci_device_id opti[] = {
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index 36ac147..4cd7444 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -64,7 +64,7 @@ static int optidma_pre_reset(struct ata_link *link, unsigned long deadline)
 	if (ap->port_no && !pci_test_config_bits(pdev, &optidma_enable_bits))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -430,7 +430,7 @@ static int optidma_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (optiplus_with_udma(dev))
 		ppi[0] = &info_82c700_udma;
 
-	return ata_pci_init_one(dev, ppi, &optidma_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &optidma_sht, NULL);
 }
 
 static const struct pci_device_id optidma[] = {
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 57efbf0..2e206c5 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -133,7 +133,7 @@ static struct scsi_host_template pcmcia_sht = {
 
 static struct ata_port_operations pcmcia_port_ops = {
 	.inherits	= &ata_sff_port_ops,
-	.data_xfer	= ata_data_xfer_noirq,
+	.data_xfer	= ata_sff_data_xfer_noirq,
 	.cable_detect	= ata_cable_40wire,
 	.set_mode	= pcmcia_set_mode,
 };
@@ -323,13 +323,13 @@ next_entry:
 		ap->ioaddr.cmd_addr = io_addr + 0x10 * p;
 		ap->ioaddr.altstatus_addr = ctl_addr + 0x10 * p;
 		ap->ioaddr.ctl_addr = ctl_addr + 0x10 * p;
-		ata_std_ports(&ap->ioaddr);
+		ata_sff_std_ports(&ap->ioaddr);
 
 		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", io_base, ctl_base);
 	}
 
 	/* activate */
-	ret = ata_host_activate(host, pdev->irq.AssignedIRQ, ata_interrupt,
+	ret = ata_host_activate(host, pdev->irq.AssignedIRQ, ata_sff_interrupt,
 				IRQF_SHARED, &pcmcia_sht);
 	if (ret)
 		goto failed;
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index d235c9f..0e1c2c1 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -248,7 +248,7 @@ static int pdc2027x_prereset(struct ata_link *link, unsigned long deadline)
 	/* Check whether port enabled */
 	if (!pdc2027x_port_enabled(link->ap))
 		return -ENOENT;
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
@@ -265,7 +265,7 @@ static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long
 	struct ata_device *pair = ata_dev_pair(adev);
 
 	if (adev->class != ATA_DEV_ATA || adev->devno == 0 || pair == NULL)
-		return ata_pci_default_filter(adev, mask);
+		return ata_bmdma_mode_filter(adev, mask);
 
 	/* Check for slave of a Maxtor at UDMA6 */
 	ata_id_c_string(pair->id, model_num, ATA_ID_PROD,
@@ -274,7 +274,7 @@ static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long
 	if (strstr(model_num, "Maxtor") == NULL && pair->dma_mode == XFER_UDMA_6)
 		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
 
-	return ata_pci_default_filter(adev, mask);
+	return ata_bmdma_mode_filter(adev, mask);
 }
 
 /**
@@ -759,8 +759,8 @@ static int __devinit pdc2027x_init_one(struct pci_dev *pdev, const struct pci_de
 		return -EIO;
 
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
-				 &pdc2027x_sht);
+	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+				 IRQF_SHARED, &pdc2027x_sht);
 }
 
 /**
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 8214100..d267306 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -324,7 +324,7 @@ static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id
 				return -ENODEV;
 		}
 	}
-	return ata_pci_init_one(dev, ppi, &pdc202xx_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &pdc202xx_sht, NULL);
 }
 
 static const struct pci_device_id pdc202xx[] = {
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 0588c9b..1edfc13 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -52,7 +52,7 @@ static struct scsi_host_template pata_platform_sht = {
 
 static struct ata_port_operations pata_platform_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.data_xfer		= ata_data_xfer_noirq,
+	.data_xfer		= ata_sff_data_xfer_noirq,
 	.cable_detect		= ata_cable_unknown,
 	.set_mode		= pata_platform_set_mode,
 	.port_start		= ATA_OP_NULL,
@@ -176,7 +176,7 @@ int __devinit __pata_platform_probe(struct device *dev,
 		      (unsigned long long)ctl_res->start);
 
 	/* activate */
-	return ata_host_activate(host, irq, irq ? ata_interrupt : NULL,
+	return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
 				 irq_flags, &pata_platform_sht);
 }
 EXPORT_SYMBOL_GPL(__pata_platform_probe);
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index d16b343..0d81dd5 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -102,14 +102,14 @@ static void qdi6580_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	qdi_qc_issue_prot	-	command issue
+ *	qdi_qc_issue		-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
  *	this interface so that we can load the correct ATA timings.
  */
 
-static unsigned int qdi_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int qdi_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -121,7 +121,7 @@ static unsigned int qdi_qc_issue_prot(struct ata_queued_cmd *qc)
 			outb(qdi->clock[adev->devno], qdi->timing);
 		}
 	}
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static unsigned int qdi_data_xfer(struct ata_device *dev, unsigned char *buf,
@@ -148,7 +148,7 @@ static unsigned int qdi_data_xfer(struct ata_device *dev, unsigned char *buf,
 			buflen += 4 - slop;
 		}
 	} else
-		buflen = ata_data_xfer(dev, buf, buflen, rw);
+		buflen = ata_sff_data_xfer(dev, buf, buflen, rw);
 
 	return buflen;
 }
@@ -159,7 +159,7 @@ static struct scsi_host_template qdi_sht = {
 
 static struct ata_port_operations qdi6500_port_ops = {
 	.inherits	= &ata_sff_port_ops,
-	.qc_issue	= qdi_qc_issue_prot,
+	.qc_issue	= qdi_qc_issue,
 	.data_xfer	= qdi_data_xfer,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= qdi6500_set_piomode,
@@ -223,7 +223,7 @@ static __init int qdi_init_one(unsigned long port, int type, unsigned long io, i
 	ap->ioaddr.cmd_addr = io_addr;
 	ap->ioaddr.altstatus_addr = ctl_addr;
 	ap->ioaddr.ctl_addr = ctl_addr;
-	ata_std_ports(&ap->ioaddr);
+	ata_sff_std_ports(&ap->ioaddr);
 
 	ata_port_desc(ap, "cmd %lx ctl %lx", io, ctl);
 
@@ -239,7 +239,7 @@ static __init int qdi_init_one(unsigned long port, int type, unsigned long io, i
 	printk(KERN_INFO DRV_NAME": qd%d at 0x%lx.\n", type, io);
 
 	/* activate */
-	ret = ata_host_activate(host, irq, ata_interrupt, 0, &qdi_sht);
+	ret = ata_host_activate(host, irq, ata_sff_interrupt, 0, &qdi_sht);
 	if (ret)
 		goto fail;
 
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 9ab84fc..1c0d9fa 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -156,7 +156,7 @@ static void radisys_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	radisys_qc_issue_prot	-	command issue
+ *	radisys_qc_issue	-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -166,7 +166,7 @@ static void radisys_set_dmamode (struct ata_port *ap, struct ata_device *adev)
  *	be made PIO0.
  */
 
-static unsigned int radisys_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int radisys_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -180,7 +180,7 @@ static unsigned int radisys_qc_issue_prot(struct ata_queued_cmd *qc)
 				radisys_set_piomode(ap, adev);
 		}
 	}
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 
@@ -190,7 +190,7 @@ static struct scsi_host_template radisys_sht = {
 
 static struct ata_port_operations radisys_pata_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.qc_issue		= radisys_qc_issue_prot,
+	.qc_issue		= radisys_qc_issue,
 	.cable_detect		= ata_cable_unknown,
 	.set_piomode		= radisys_set_piomode,
 	.set_dmamode		= radisys_set_dmamode,
@@ -228,7 +228,7 @@ static int radisys_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi, &radisys_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &radisys_sht, NULL);
 }
 
 static const struct pci_device_id radisys_pci_tbl[] = {
diff --git a/drivers/ata/pata_rb500_cf.c b/drivers/ata/pata_rb500_cf.c
index 7affcee..5b23d79 100644
--- a/drivers/ata/pata_rb500_cf.c
+++ b/drivers/ata/pata_rb500_cf.c
@@ -57,7 +57,7 @@ static inline void rb500_pata_finish_io(struct ata_port *ap)
 	struct ata_host *ah = ap->host;
 	struct rb500_cf_info *info = ah->private_data;
 
-	ata_altstatus(ap);
+	ata_sff_altstatus(ap);
 	ndelay(RB500_CF_IO_DELAY);
 
 	set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
@@ -109,7 +109,7 @@ static irqreturn_t rb500_pata_irq_handler(int irq, void *dev_instance)
 	if (gpio_get_value(info->gpio_line)) {
 		set_irq_type(info->irq, IRQ_TYPE_LEVEL_LOW);
 		if (!info->frozen)
-			ata_interrupt(info->irq, dev_instance);
+			ata_sff_interrupt(info->irq, dev_instance);
 	} else {
 		set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
 	}
@@ -148,7 +148,7 @@ static void rb500_pata_setup_ports(struct ata_host *ah)
 	ap->ioaddr.ctl_addr	= info->iobase + RB500_CF_REG_CTRL;
 	ap->ioaddr.altstatus_addr = info->iobase + RB500_CF_REG_CTRL;
 
-	ata_std_ports(&ap->ioaddr);
+	ata_sff_std_ports(&ap->ioaddr);
 
 	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DATA;
 }
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 462b72a..7dfd1f3 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -99,7 +99,7 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
 	if (rz1000_fifo_disable(pdev) == 0)
-		return ata_pci_init_one(pdev, ppi, &rz1000_sht, NULL);
+		return ata_pci_sff_init_one(pdev, ppi, &rz1000_sht, NULL);
 
 	printk(KERN_ERR DRV_NAME ": failed to disable read-ahead on chipset..\n");
 	/* Not safe to use so skip */
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 42efacf..cbab397 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -151,7 +151,7 @@ static void sc1200_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	sc1200_qc_issue_prot	-	command issue
+ *	sc1200_qc_issue		-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -160,7 +160,7 @@ static void sc1200_set_dmamode(struct ata_port *ap, struct ata_device *adev)
  *	one MWDMA/UDMA bit.
  */
 
-static unsigned int sc1200_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int sc1200_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *adev = qc->dev;
@@ -175,7 +175,7 @@ static unsigned int sc1200_qc_issue_prot(struct ata_queued_cmd *qc)
 		    	sc1200_set_dmamode(ap, adev);
 	}
 
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static struct scsi_host_template sc1200_sht = {
@@ -185,8 +185,8 @@ static struct scsi_host_template sc1200_sht = {
 
 static struct ata_port_operations sc1200_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
-	.qc_prep 	= ata_dumb_qc_prep,
-	.qc_issue	= sc1200_qc_issue_prot,
+	.qc_prep 	= ata_sff_dumb_qc_prep,
+	.qc_issue	= sc1200_qc_issue,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= sc1200_set_piomode,
 	.set_dmamode	= sc1200_set_dmamode,
@@ -213,7 +213,7 @@ static int sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	/* Can't enable port 2 yet, see top comments */
 	const struct ata_port_info *ppi[] = { &info, &ata_dummy_port_info };
 
-	return ata_pci_init_one(dev, ppi, &sc1200_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &sc1200_sht, NULL);
 }
 
 static const struct pci_device_id sc1200[] = {
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 85d3363..65c341a 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -266,7 +266,7 @@ unsigned long scc_mode_filter(struct ata_device *adev, unsigned long mask)
 		printk(KERN_INFO "%s: limit ATAPI UDMA to UDMA4\n", DRV_NAME);
 		mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
-	return ata_pci_default_filter(adev, mask);
+	return ata_bmdma_mode_filter(adev, mask);
 }
 
 /**
@@ -274,7 +274,7 @@ unsigned long scc_mode_filter(struct ata_device *adev, unsigned long mask)
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
  *
- *	Note: Original code is ata_tf_load().
+ *	Note: Original code is ata_sff_tf_load().
  */
 
 static void scc_tf_load (struct ata_port *ap, const struct ata_taskfile *tf)
@@ -341,7 +341,7 @@ static u8 scc_check_status (struct ata_port *ap)
  *	@ap: Port from which input is read
  *	@tf: ATA taskfile register set for storing input
  *
- *	Note: Original code is ata_tf_read().
+ *	Note: Original code is ata_sff_tf_read().
  */
 
 static void scc_tf_read (struct ata_port *ap, struct ata_taskfile *tf)
@@ -373,7 +373,7 @@ static void scc_tf_read (struct ata_port *ap, struct ata_taskfile *tf)
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
  *
- *	Note: Original code is ata_exec_command().
+ *	Note: Original code is ata_sff_exec_command().
  */
 
 static void scc_exec_command (struct ata_port *ap,
@@ -382,7 +382,7 @@ static void scc_exec_command (struct ata_port *ap,
 	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 
 	out_be32(ap->ioaddr.command_addr, tf->command);
-	ata_pause(ap);
+	ata_sff_pause(ap);
 }
 
 /**
@@ -396,14 +396,14 @@ static u8 scc_check_altstatus (struct ata_port *ap)
 }
 
 /**
- *	scc_std_dev_select - Select device 0/1 on ATA bus
+ *	scc_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
  *	@device: ATA device (numbered from zero) to select
  *
- *	Note: Original code is ata_std_dev_select().
+ *	Note: Original code is ata_sff_dev_select().
  */
 
-static void scc_std_dev_select (struct ata_port *ap, unsigned int device)
+static void scc_dev_select (struct ata_port *ap, unsigned int device)
 {
 	u8 tmp;
 
@@ -413,7 +413,7 @@ static void scc_std_dev_select (struct ata_port *ap, unsigned int device)
 		tmp = ATA_DEVICE_OBS | ATA_DEV1;
 
 	out_be32(ap->ioaddr.device_addr, tmp);
-	ata_pause(ap);
+	ata_sff_pause(ap);
 }
 
 /**
@@ -514,7 +514,7 @@ static int scc_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	 * BSY bit to clear
 	 */
 	if (dev0) {
-		rc = ata_wait_ready(ap, deadline);
+		rc = ata_sff_wait_ready(ap, deadline);
 		if (rc && rc != -ENODEV)
 			return rc;
 	}
@@ -535,7 +535,7 @@ static int scc_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 		msleep(50);	/* give drive a breather */
 	}
 	if (dev1) {
-		rc = ata_wait_ready(ap, deadline);
+		rc = ata_sff_wait_ready(ap, deadline);
 		if (rc && rc != -ENODEV)
 			return rc;
 	}
@@ -571,7 +571,7 @@ static unsigned int scc_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	out_be32(ioaddr->ctl_addr, ap->ctl);
 
 	/* wait a while before checking status */
-	ata_wait_after_reset(ap, deadline);
+	ata_sff_wait_after_reset(ap, deadline);
 
 	/* Before we perform post reset processing we want to see if
 	 * the bus shows 0xFF because the odd clown forgets the D7
@@ -586,16 +586,16 @@ static unsigned int scc_bus_softreset(struct ata_port *ap, unsigned int devmask,
 }
 
 /**
- *	scc_std_softreset - reset host port via ATA SRST
+ *	scc_softreset - reset host port via ATA SRST
  *	@ap: port to reset
  *	@classes: resulting classes of attached devices
  *	@deadline: deadline jiffies for the operation
  *
- *	Note: Original code is ata_std_softreset().
+ *	Note: Original code is ata_sff_softreset().
  */
 
-static int scc_std_softreset(struct ata_link *link, unsigned int *classes,
-                             unsigned long deadline)
+static int scc_softreset(struct ata_link *link, unsigned int *classes,
+			 unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
@@ -628,10 +628,10 @@ static int scc_std_softreset(struct ata_link *link, unsigned int *classes,
 	}
 
 	/* determine by signature whether we have ATA or ATAPI devices */
-	classes[0] = ata_dev_try_classify(&ap->link.device[0],
+	classes[0] = ata_sff_dev_classify(&ap->link.device[0],
 					  devmask & (1 << 0), &err);
 	if (slave_possible && err != 0x81)
-		classes[1] = ata_dev_try_classify(&ap->link.device[1],
+		classes[1] = ata_sff_dev_classify(&ap->link.device[1],
 						  devmask & (1 << 1), &err);
 
  out:
@@ -695,7 +695,7 @@ static void scc_bmdma_stop (struct ata_queued_cmd *qc)
 			printk(KERN_WARNING "%s: Internal Bus Error\n", DRV_NAME);
 			out_be32(bmid_base + SCC_DMA_INTST, INTSTS_BMSINT);
 			/* TBD: SW reset */
-			scc_std_softreset(&ap->link, &classes, deadline);
+			scc_softreset(&ap->link, &classes, deadline);
 			continue;
 		}
 
@@ -721,7 +721,7 @@ static void scc_bmdma_stop (struct ata_queued_cmd *qc)
 		 in_be32(bmid_base + SCC_DMA_CMD) & ~ATA_DMA_START);
 
 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_altstatus(ap);	/* dummy read */
+	ata_sff_altstatus(ap);	/* dummy read */
 }
 
 /**
@@ -742,7 +742,7 @@ static u8 scc_bmdma_status (struct ata_port *ap)
 		return host_stat;
 
 	/* errata A252,A308 workaround: Step4 */
-	if ((ata_altstatus(ap) & ATA_ERR) && (int_status & INTSTS_INTRQ))
+	if ((ata_sff_altstatus(ap) & ATA_ERR) && (int_status & INTSTS_INTRQ))
 		return (host_stat | ATA_DMA_INTR);
 
 	/* errata A308 workaround Step5 */
@@ -773,7 +773,7 @@ static u8 scc_bmdma_status (struct ata_port *ap)
  *	@buflen: buffer length
  *	@rw: read/write
  *
- *	Note: Original code is ata_data_xfer().
+ *	Note: Original code is ata_sff_data_xfer().
  */
 
 static unsigned int scc_data_xfer (struct ata_device *dev, unsigned char *buf,
@@ -815,7 +815,7 @@ static unsigned int scc_data_xfer (struct ata_device *dev, unsigned char *buf,
  *	scc_irq_on - Enable interrupts on a port.
  *	@ap: Port on which interrupts are enabled.
  *
- *	Note: Original code is ata_irq_on().
+ *	Note: Original code is ata_sff_irq_on().
  */
 
 static u8 scc_irq_on (struct ata_port *ap)
@@ -835,13 +835,13 @@ static u8 scc_irq_on (struct ata_port *ap)
 }
 
 /**
- *	scc_bmdma_freeze - Freeze BMDMA controller port
+ *	scc_freeze - Freeze BMDMA controller port
  *	@ap: port to freeze
  *
- *	Note: Original code is ata_bmdma_freeze().
+ *	Note: Original code is ata_sff_freeze().
  */
 
-static void scc_bmdma_freeze (struct ata_port *ap)
+static void scc_freeze (struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
@@ -868,18 +868,18 @@ static void scc_bmdma_freeze (struct ata_port *ap)
 static int scc_pata_prereset(struct ata_link *link, unsigned long deadline)
 {
 	link->ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 /**
- *	scc_std_postreset - standard postreset callback
+ *	scc_postreset - standard postreset callback
  *	@ap: the target ata_port
  *	@classes: classes of attached devices
  *
- *	Note: Original code is ata_std_postreset().
+ *	Note: Original code is ata_sff_postreset().
  */
 
-static void scc_std_postreset(struct ata_link *link, unsigned int *classes)
+static void scc_postreset(struct ata_link *link, unsigned int *classes)
 {
 	struct ata_port *ap = link->ap;
 
@@ -905,13 +905,13 @@ static void scc_std_postreset(struct ata_link *link, unsigned int *classes)
 }
 
 /**
- *	scc_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+ *	scc_irq_clear - Clear PCI IDE BMDMA interrupt.
  *	@ap: Port associated with this ATA transaction.
  *
- *	Note: Original code is ata_bmdma_irq_clear().
+ *	Note: Original code is ata_sff_irq_clear().
  */
 
-static void scc_bmdma_irq_clear (struct ata_port *ap)
+static void scc_irq_clear (struct ata_port *ap)
 {
 	void __iomem *mmio = ap->ioaddr.bmdma_addr;
 
@@ -972,7 +972,7 @@ static const struct ata_port_operations scc_pata_ops = {
 	.exec_command		= scc_exec_command,
 	.check_status		= scc_check_status,
 	.check_altstatus	= scc_check_altstatus,
-	.dev_select		= scc_std_dev_select,
+	.dev_select		= scc_dev_select,
 
 	.bmdma_setup		= scc_bmdma_setup,
 	.bmdma_start		= scc_bmdma_start,
@@ -980,13 +980,13 @@ static const struct ata_port_operations scc_pata_ops = {
 	.bmdma_status		= scc_bmdma_status,
 	.data_xfer		= scc_data_xfer,
 
-	.freeze			= scc_bmdma_freeze,
+	.freeze			= scc_freeze,
 	.prereset		= scc_pata_prereset,
-	.softreset		= scc_std_softreset,
-	.postreset		= scc_std_postreset,
+	.softreset		= scc_softreset,
+	.postreset		= scc_postreset,
 	.post_internal_cmd	= scc_bmdma_stop,
 
-	.irq_clear		= scc_bmdma_irq_clear,
+	.irq_clear		= scc_irq_clear,
 	.irq_on			= scc_irq_on,
 
 	.port_start		= scc_port_start,
@@ -1140,8 +1140,8 @@ static int scc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
-				 &scc_sht);
+	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+				 IRQF_SHARED, &scc_sht);
 }
 
 static struct pci_driver scc_pci_driver = {
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 2f4f9b0..ffd26d0 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -199,7 +199,7 @@ static unsigned long serverworks_osb4_filter(struct ata_device *adev, unsigned l
 {
 	if (adev->class == ATA_DEV_ATA)
 		mask &= ~ATA_MASK_UDMA;
-	return ata_pci_default_filter(adev, mask);
+	return ata_bmdma_mode_filter(adev, mask);
 }
 
 
@@ -219,7 +219,7 @@ static unsigned long serverworks_csb_filter(struct ata_device *adev, unsigned lo
 
 	/* Disk, UDMA */
 	if (adev->class != ATA_DEV_ATA)
-		return ata_pci_default_filter(adev, mask);
+		return ata_bmdma_mode_filter(adev, mask);
 
 	/* Actually do need to check */
 	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
@@ -228,7 +228,7 @@ static unsigned long serverworks_csb_filter(struct ata_device *adev, unsigned lo
 		if (!strcmp(p, model_num))
 			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
 	}
-	return ata_pci_default_filter(adev, mask);
+	return ata_bmdma_mode_filter(adev, mask);
 }
 
 /**
@@ -459,9 +459,9 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 		serverworks_fixup_ht1000(pdev);
 
 	if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
-		ata_pci_clear_simplex(pdev);
+		ata_pci_bmdma_clear_simplex(pdev);
 
-	return ata_pci_init_one(pdev, ppi, &serverworks_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &serverworks_sht, NULL);
 }
 
 #ifdef CONFIG_PM
@@ -482,7 +482,7 @@ static int serverworks_reinit_one(struct pci_dev *pdev)
 			serverworks_fixup_osb4(pdev);
 			break;
 		case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
-			ata_pci_clear_simplex(pdev);
+			ata_pci_bmdma_clear_simplex(pdev);
 			/* fall through */
 		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE:
 		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2:
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 2fa612b..e08d9e0 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -346,19 +346,19 @@ static int __devinit sil680_init_one(struct pci_dev *pdev,
 	host->ports[0]->ioaddr.cmd_addr = mmio_base + 0x80;
 	host->ports[0]->ioaddr.ctl_addr = mmio_base + 0x8a;
 	host->ports[0]->ioaddr.altstatus_addr = mmio_base + 0x8a;
-	ata_std_ports(&host->ports[0]->ioaddr);
+	ata_sff_std_ports(&host->ports[0]->ioaddr);
 	host->ports[1]->ioaddr.bmdma_addr = mmio_base + 0x08;
 	host->ports[1]->ioaddr.cmd_addr = mmio_base + 0xc0;
 	host->ports[1]->ioaddr.ctl_addr = mmio_base + 0xca;
 	host->ports[1]->ioaddr.altstatus_addr = mmio_base + 0xca;
-	ata_std_ports(&host->ports[1]->ioaddr);
+	ata_sff_std_ports(&host->ports[1]->ioaddr);
 
 	/* Register & activate */
-	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
-				 &sil680_sht);
+	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+				 IRQF_SHARED, &sil680_sht);
 
 use_ioports:
-	return ata_pci_init_one(pdev, ppi, &sil680_sht, NULL);
+	return ata_pci_sff_init_one(pdev, ppi, &sil680_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 793e671..e82c66e 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -156,7 +156,7 @@ static int sis_pre_reset(struct ata_link *link, unsigned long deadline)
 	/* Clear the FIFO settings. We can't enable the FIFO until
 	   we know we are poking at a disk */
 	pci_write_config_byte(pdev, 0x4B, 0);
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 
@@ -821,7 +821,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	sis_fixup(pdev, chipset);
 
-	return ata_pci_init_one(pdev, ppi, &sis_sht, chipset);
+	return ata_pci_sff_init_one(pdev, ppi, &sis_sht, chipset);
 }
 
 static const struct pci_device_id sis_pci_tbl[] = {
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index bee11ca..70d94fb 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -60,7 +60,7 @@ static int sl82c105_pre_reset(struct ata_link *link, unsigned long deadline)
 
 	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no]))
 		return -ENOENT;
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 
@@ -317,7 +317,7 @@ static int sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id
 	val |= CTRL_P0EN | CTRL_P0F16 | CTRL_P1F16;
 	pci_write_config_dword(dev, 0x40, val);
 
-	return ata_pci_init_one(dev, ppi, &sl82c105_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &sl82c105_sht, NULL);
 }
 
 static const struct pci_device_id sl82c105[] = {
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index bd546a3..b181261 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -66,7 +66,7 @@ static int triflex_prereset(struct ata_link *link, unsigned long deadline)
 	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 
@@ -201,7 +201,7 @@ static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(dev, ppi, &triflex_sht, NULL);
+	return ata_pci_sff_init_one(dev, ppi, &triflex_sht, NULL);
 }
 
 static const struct pci_device_id triflex[] = {
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 2928fa1..4b85f84 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -210,7 +210,7 @@ static int via_pre_reset(struct ata_link *link, unsigned long deadline)
 			return -ENOENT;
 	}
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 
@@ -336,7 +336,7 @@ static struct ata_port_operations via_port_ops = {
 
 static struct ata_port_operations via_port_ops_noirq = {
 	.inherits	= &via_port_ops,
-	.data_xfer	= ata_data_xfer_noirq,
+	.data_xfer	= ata_sff_data_xfer_noirq,
 };
 
 /**
@@ -511,7 +511,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	/* We have established the device type, now fire it up */
-	return ata_pci_init_one(pdev, ppi, &via_sht, (void *)config);
+	return ata_pci_sff_init_one(pdev, ppi, &via_sht, (void *)config);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index f235bb0..cc18231 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -116,7 +116,7 @@ static unsigned int winbond_data_xfer(struct ata_device *dev,
 			buflen += 4 - slop;
 		}
 	} else
-		buflen = ata_data_xfer(dev, buf, buflen, rw);
+		buflen = ata_sff_data_xfer(dev, buf, buflen, rw);
 
 	return buflen;
 }
@@ -198,7 +198,7 @@ static __init int winbond_init_one(unsigned long port)
 		ap->ioaddr.cmd_addr = cmd_addr;
 		ap->ioaddr.altstatus_addr = ctl_addr;
 		ap->ioaddr.ctl_addr = ctl_addr;
-		ata_std_ports(&ap->ioaddr);
+		ata_sff_std_ports(&ap->ioaddr);
 
 		/* hook in a private data structure per channel */
 		host->private_data = &winbond_data[nr_winbond_host];
@@ -206,7 +206,7 @@ static __init int winbond_init_one(unsigned long port)
 		winbond_data[nr_winbond_host].platform_dev = pdev;
 
 		/* activate */
-		rc = ata_host_activate(host, 14 + i, ata_interrupt, 0,
+		rc = ata_host_activate(host, 14 + i, ata_sff_interrupt, 0,
 				       &winbond_sht);
 		if (rc)
 			goto err_unregister;
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index c431bf3..be53545 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -208,7 +208,7 @@ static void adma_reinit_engine(struct ata_port *ap)
 
 	/* mask/clear ATA interrupts */
 	writeb(ATA_NIEN, ap->ioaddr.ctl_addr);
-	ata_check_status(ap);
+	ata_sff_check_status(ap);
 
 	/* reset the ADMA engine */
 	adma_reset_engine(ap);
@@ -243,7 +243,7 @@ static void adma_freeze(struct ata_port *ap)
 
 	/* mask/clear ATA interrupts */
 	writeb(ATA_NIEN, ap->ioaddr.ctl_addr);
-	ata_check_status(ap);
+	ata_sff_check_status(ap);
 
 	/* reset ADMA to idle state */
 	writew(aPIOMD4 | aNIEN | aRSTADM, chan + ADMA_CONTROL);
@@ -266,7 +266,7 @@ static int adma_prereset(struct ata_link *link, unsigned long deadline)
 		pp->state = adma_state_mmio;
 	adma_reinit_engine(ap);
 
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 static int adma_fill_sg(struct ata_queued_cmd *qc)
@@ -322,7 +322,7 @@ static void adma_qc_prep(struct ata_queued_cmd *qc)
 
 	adma_enter_reg_mode(qc->ap);
 	if (qc->tf.protocol != ATA_PROT_DMA) {
-		ata_qc_prep(qc);
+		ata_sff_qc_prep(qc);
 		return;
 	}
 
@@ -421,7 +421,7 @@ static unsigned int adma_qc_issue(struct ata_queued_cmd *qc)
 	}
 
 	pp->state = adma_state_mmio;
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static inline unsigned int adma_intr_pkt(struct ata_host *host)
@@ -492,7 +492,7 @@ static inline unsigned int adma_intr_mmio(struct ata_host *host)
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
-				u8 status = ata_check_status(ap);
+				u8 status = ata_sff_check_status(ap);
 				if ((status & ATA_BUSY))
 					continue;
 				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 12fbf38..6e6fca4 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -271,7 +271,7 @@ static void inic_host_intr(struct ata_port *ap)
 			return;
 		}
 
-		if (likely(ata_host_intr(ap, qc)))
+		if (likely(ata_sff_host_intr(ap, qc)))
 			return;
 
 		ap->ops->check_status(ap); /* clear ATA interrupt */
@@ -356,7 +356,7 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
 			return AC_ERR_HSM;
 	}
 
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static void inic_freeze(struct ata_port *ap)
@@ -418,9 +418,9 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 		struct ata_taskfile tf;
 
 		/* wait a while before checking status */
-		ata_wait_after_reset(ap, deadline);
+		ata_sff_wait_after_reset(ap, deadline);
 
-		rc = ata_wait_ready(ap, deadline);
+		rc = ata_sff_wait_ready(ap, deadline);
 		/* link occupied, -ENODEV too is an error */
 		if (rc) {
 			ata_link_printk(link, KERN_WARNING, "device not ready "
@@ -428,7 +428,7 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 			return rc;
 		}
 
-		ata_tf_read(ap, &tf);
+		ata_sff_tf_read(ap, &tf);
 		*class = ata_dev_classify(&tf);
 		if (*class == ATA_DEV_UNKNOWN)
 			*class = ATA_DEV_NONE;
@@ -663,7 +663,7 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			((unsigned long)iomap[2 * i + 1] | ATA_PCI_CTL_OFS);
 		port->scr_addr = iomap[MMIO_BAR] + offset + PORT_SCR;
 
-		ata_std_ports(port);
+		ata_sff_std_ports(port);
 
 		ata_port_pbar_desc(ap, MMIO_BAR, -1, "mmio");
 		ata_port_pbar_desc(ap, MMIO_BAR, offset, "port");
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 9a89390..fae0dec 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1385,7 +1385,7 @@ static unsigned int mv_qc_issue(struct ata_queued_cmd *qc)
 		 * shadow block, etc registers.
 		 */
 		__mv_stop_dma(ap);
-		return ata_qc_issue_prot(qc);
+		return ata_sff_qc_issue(qc);
 	}
 
 	mv_start_dma(ap, port_mmio, pp, qc->tf.protocol);
@@ -2346,7 +2346,7 @@ comreset_retry:
 	 */
 	retry = 20;
 	while (1) {
-		u8 drv_stat = ata_check_status(ap);
+		u8 drv_stat = ata_sff_check_status(ap);
 		if ((drv_stat != 0x80) && (drv_stat != 0x7f))
 			break;
 		msleep(500);
@@ -2361,7 +2361,7 @@ comreset_retry:
 	 */
 
 	/* finally, read device signature from TF registers */
-	*class = ata_dev_try_classify(ap->link.device, 1, NULL);
+	*class = ata_sff_dev_classify(ap->link.device, 1, NULL);
 
 	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index b2eb572..c30f267 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -730,7 +730,7 @@ static void nv_adma_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 	   ADMA mode could abort outstanding commands. */
 	nv_adma_register_mode(ap);
 
-	ata_tf_read(ap, tf);
+	ata_sff_tf_read(ap, tf);
 }
 
 static unsigned int nv_adma_tf_to_cpb(struct ata_taskfile *tf, __le16 *cpb)
@@ -844,12 +844,12 @@ static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
 
 	/* DEV interrupt w/ no active qc? */
 	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
-		ata_check_status(ap);
+		ata_sff_check_status(ap);
 		return 1;
 	}
 
 	/* handle interrupt */
-	return ata_host_intr(ap, qc);
+	return ata_sff_host_intr(ap, qc);
 }
 
 static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
@@ -1028,7 +1028,7 @@ static void nv_adma_irq_clear(struct ata_port *ap)
 	u32 notifier_clears[2];
 
 	if (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE) {
-		ata_bmdma_irq_clear(ap);
+		ata_sff_irq_clear(ap);
 		return;
 	}
 
@@ -1059,7 +1059,7 @@ static void nv_adma_post_internal_cmd(struct ata_queued_cmd *qc)
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
 
 	if (pp->flags & NV_ADMA_PORT_REGISTER_MODE)
-		ata_bmdma_post_internal_cmd(qc);
+		ata_sff_post_internal_cmd(qc);
 }
 
 static int nv_adma_port_start(struct ata_port *ap)
@@ -1336,7 +1336,7 @@ static void nv_adma_qc_prep(struct ata_queued_cmd *qc)
 		BUG_ON(!(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE) &&
 			(qc->flags & ATA_QCFLAG_DMAMAP));
 		nv_adma_register_mode(qc->ap);
-		ata_qc_prep(qc);
+		ata_sff_qc_prep(qc);
 		return;
 	}
 
@@ -1395,7 +1395,7 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 		BUG_ON(!(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE) &&
 			(qc->flags & ATA_QCFLAG_DMAMAP));
 		nv_adma_register_mode(qc->ap);
-		return ata_qc_issue_prot(qc);
+		return ata_sff_qc_issue(qc);
 	} else
 		nv_adma_mode(qc->ap);
 
@@ -1436,7 +1436,7 @@ static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance)
 
 			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
-				handled += ata_host_intr(ap, qc);
+				handled += ata_sff_host_intr(ap, qc);
 			else
 				// No request pending?  Clear interrupt status
 				// anyway, in case there's one pending.
@@ -1571,7 +1571,7 @@ static void nv_mcp55_freeze(struct ata_port *ap)
 	mask = readl(mmio_base + NV_INT_ENABLE_MCP55);
 	mask &= ~(NV_INT_ALL_MCP55 << shift);
 	writel(mask, mmio_base + NV_INT_ENABLE_MCP55);
-	ata_bmdma_freeze(ap);
+	ata_sff_freeze(ap);
 }
 
 static void nv_mcp55_thaw(struct ata_port *ap)
@@ -1585,7 +1585,7 @@ static void nv_mcp55_thaw(struct ata_port *ap)
 	mask = readl(mmio_base + NV_INT_ENABLE_MCP55);
 	mask |= (NV_INT_MASK_MCP55 << shift);
 	writel(mask, mmio_base + NV_INT_ENABLE_MCP55);
-	ata_bmdma_thaw(ap);
+	ata_sff_thaw(ap);
 }
 
 static int nv_hardreset(struct ata_link *link, unsigned int *class,
@@ -1597,7 +1597,7 @@ static int nv_hardreset(struct ata_link *link, unsigned int *class,
 	 * some controllers.  Don't classify on hardreset.  For more
 	 * info, see http://bugzilla.kernel.org/show_bug.cgi?id=3352
 	 */
-	return sata_std_hardreset(link, &dummy, deadline);
+	return sata_sff_hardreset(link, &dummy, deadline);
 }
 
 static void nv_adma_error_handler(struct ata_port *ap)
@@ -1653,7 +1653,7 @@ static void nv_adma_error_handler(struct ata_port *ap)
 		readw(mmio + NV_ADMA_CTL);	/* flush posted write */
 	}
 
-	ata_bmdma_error_handler(ap);
+	ata_sff_error_handler(ap);
 }
 
 static void nv_swncq_qc_to_dq(struct ata_port *ap, struct ata_queued_cmd *qc)
@@ -1779,7 +1779,7 @@ static void nv_swncq_error_handler(struct ata_port *ap)
 		ehc->i.action |= ATA_EH_RESET;
 	}
 
-	ata_bmdma_error_handler(ap);
+	ata_sff_error_handler(ap);
 }
 
 #ifdef CONFIG_PM
@@ -1925,7 +1925,7 @@ static int nv_swncq_port_start(struct ata_port *ap)
 static void nv_swncq_qc_prep(struct ata_queued_cmd *qc)
 {
 	if (qc->tf.protocol != ATA_PROT_NCQ) {
-		ata_qc_prep(qc);
+		ata_sff_qc_prep(qc);
 		return;
 	}
 
@@ -2001,7 +2001,7 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
 	struct nv_swncq_port_priv *pp = ap->private_data;
 
 	if (qc->tf.protocol != ATA_PROT_NCQ)
-		return ata_qc_issue_prot(qc);
+		return ata_sff_qc_issue(qc);
 
 	DPRINTK("Enter\n");
 
@@ -2350,7 +2350,7 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ppi[0] = &nv_port_info[type];
 	ipriv = ppi[0]->private_data;
-	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 91659dc..74d033a 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -143,7 +143,7 @@ static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile
 static int pdc_check_atapi_dma(struct ata_queued_cmd *qc);
 static int pdc_old_sata_check_atapi_dma(struct ata_queued_cmd *qc);
 static void pdc_irq_clear(struct ata_port *ap);
-static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
+static unsigned int pdc_qc_issue(struct ata_queued_cmd *qc);
 static void pdc_freeze(struct ata_port *ap);
 static void pdc_sata_freeze(struct ata_port *ap);
 static void pdc_thaw(struct ata_port *ap);
@@ -166,7 +166,7 @@ static const struct ata_port_operations pdc_common_ops = {
 	.exec_command		= pdc_exec_command_mmio,
 	.check_atapi_dma	= pdc_check_atapi_dma,
 	.qc_prep		= pdc_qc_prep,
-	.qc_issue		= pdc_qc_issue_prot,
+	.qc_issue		= pdc_qc_issue,
 	.irq_clear		= pdc_irq_clear,
 
 	.post_internal_cmd	= pdc_post_internal_cmd,
@@ -894,7 +894,7 @@ static inline void pdc_packet_start(struct ata_queued_cmd *qc)
 	readl(ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT); /* flush */
 }
 
-static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int pdc_qc_issue(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
 	case ATAPI_PROT_NODATA:
@@ -914,20 +914,20 @@ static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
 		break;
 	}
 
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	WARN_ON(tf->protocol == ATA_PROT_DMA || tf->protocol == ATAPI_PROT_DMA);
-	ata_tf_load(ap, tf);
+	ata_sff_tf_load(ap, tf);
 }
 
 static void pdc_exec_command_mmio(struct ata_port *ap,
 				  const struct ata_taskfile *tf)
 {
 	WARN_ON(tf->protocol == ATA_PROT_DMA || tf->protocol == ATAPI_PROT_DMA);
-	ata_exec_command(ap, tf);
+	ata_sff_exec_command(ap, tf);
 }
 
 static int pdc_check_atapi_dma(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 2ceb099..1600107 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -239,7 +239,7 @@ static int qs_prereset(struct ata_link *link, unsigned long deadline)
 	struct ata_port *ap = link->ap;
 
 	qs_reset_channel_logic(ap);
-	return ata_std_prereset(link, deadline);
+	return ata_sff_prereset(link, deadline);
 }
 
 static int qs_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
@@ -303,7 +303,7 @@ static void qs_qc_prep(struct ata_queued_cmd *qc)
 
 	qs_enter_reg_mode(qc->ap);
 	if (qc->tf.protocol != ATA_PROT_DMA) {
-		ata_qc_prep(qc);
+		ata_sff_qc_prep(qc);
 		return;
 	}
 
@@ -362,7 +362,7 @@ static unsigned int qs_qc_issue(struct ata_queued_cmd *qc)
 	}
 
 	pp->state = qs_state_mmio;
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static void qs_do_or_die(struct ata_queued_cmd *qc, u8 status)
@@ -451,7 +451,7 @@ static inline unsigned int qs_intr_mmio(struct ata_host *host)
 				 * and pretend we knew it was ours.. (ugh).
 				 * This does not affect packet mode.
 				 */
-				ata_check_status(ap);
+				ata_sff_check_status(ap);
 				handled = 1;
 				continue;
 			}
@@ -459,7 +459,7 @@ static inline unsigned int qs_intr_mmio(struct ata_host *host)
 			if (!pp || pp->state != qs_state_mmio)
 				continue;
 			if (!(qc->tf.flags & ATA_TFLAG_POLLING))
-				handled |= ata_host_intr(ap, qc);
+				handled |= ata_sff_host_intr(ap, qc);
 		}
 	}
 	return handled;
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 659dfcb..987313b 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -410,10 +410,10 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 		goto err_hsm;
 
 	/* ack bmdma irq events */
-	ata_bmdma_irq_clear(ap);
+	ata_sff_irq_clear(ap);
 
 	/* kick HSM in the ass */
-	ata_hsm_move(ap, qc, status, 0);
+	ata_sff_hsm_move(ap, qc, status, 0);
 
 	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
 		ata_ehi_push_desc(ehi, "BMDMA2 stat 0x%x", bmdma2);
@@ -481,7 +481,7 @@ static void sil_thaw(struct ata_port *ap)
 
 	/* clear IRQ */
 	ap->ops->check_status(ap);
-	ata_bmdma_irq_clear(ap);
+	ata_sff_irq_clear(ap);
 
 	/* turn on SATA IRQ if supported */
 	if (!(ap->flags & SIL_FLAG_NO_SATA_IRQ))
@@ -655,7 +655,7 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		ioaddr->ctl_addr = mmio_base + sil_port[i].ctl;
 		ioaddr->bmdma_addr = mmio_base + sil_port[i].bmdma;
 		ioaddr->scr_addr = mmio_base + sil_port[i].scr;
-		ata_std_ports(ioaddr);
+		ata_sff_std_ports(ioaddr);
 
 		ata_port_pbar_desc(ap, SIL_MMIO_BAR, -1, "mmio");
 		ata_port_pbar_desc(ap, SIL_MMIO_BAR, sil_port[i].tf, "tf");
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 9089c7a..6b8e45b 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -309,7 +309,7 @@ static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		break;
 	}
 
-	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
 
@@ -327,8 +327,8 @@ static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 	pci_intx(pdev, 1);
-	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
-				 &sis_sht);
+	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+				 IRQF_SHARED, &sis_sht);
 }
 
 static int __init sis_init(void)
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 540be24..8686d0f 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -492,8 +492,8 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
 	writel(0x0, mmio_base + K2_SATA_SIM_OFFSET);
 
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
-				 &k2_sata_sht);
+	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+				 IRQF_SHARED, &k2_sata_sht);
 }
 
 /* 0x240 is device ID for Apple K2 device
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 8138cda..c6b4a62 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -232,7 +232,7 @@ static void pdc20621_get_from_dimm(struct ata_host *host,
 static void pdc20621_put_to_dimm(struct ata_host *host,
 				 void *psource, u32 offset, u32 size);
 static void pdc20621_irq_clear(struct ata_port *ap);
-static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
+static unsigned int pdc20621_qc_issue(struct ata_queued_cmd *qc);
 
 
 static struct scsi_host_template pdc_sata_sht = {
@@ -244,17 +244,17 @@ static struct scsi_host_template pdc_sata_sht = {
 /* TODO: inherit from base port_ops after converting to new EH */
 static struct ata_port_operations pdc_20621_ops = {
 	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
+	.tf_read		= ata_sff_tf_read,
+	.check_status		= ata_sff_check_status,
 	.exec_command		= pdc_exec_command_mmio,
-	.dev_select		= ata_std_dev_select,
+	.dev_select		= ata_sff_dev_select,
 	.phy_reset		= pdc_20621_phy_reset,
 	.qc_prep		= pdc20621_qc_prep,
-	.qc_issue		= pdc20621_qc_issue_prot,
-	.data_xfer		= ata_data_xfer,
+	.qc_issue		= pdc20621_qc_issue,
+	.data_xfer		= ata_sff_data_xfer,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_clear		= pdc20621_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= ata_sff_irq_on,
 	.port_start		= pdc_port_start,
 };
 
@@ -682,7 +682,7 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 	}
 }
 
-static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int pdc20621_qc_issue(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -698,7 +698,7 @@ static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc)
 		break;
 	}
 
-	return ata_qc_issue_prot(qc);
+	return ata_sff_qc_issue(qc);
 }
 
 static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
@@ -770,7 +770,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 	/* command completion, but no data xfer */
 	} else if (qc->tf.protocol == ATA_PROT_NODATA) {
 
-		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+		status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
 		qc->err_mask |= ac_err_mask(status);
 		ata_qc_complete(qc);
@@ -879,7 +879,7 @@ static void pdc_eng_timeout(struct ata_port *ap)
 		break;
 
 	default:
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+		drv_stat = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
 		ata_port_printk(ap, KERN_ERR,
 				"unknown timeout, cmd 0x%x stat 0x%x\n",
@@ -898,7 +898,7 @@ static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	WARN_ON(tf->protocol == ATA_PROT_DMA ||
 		tf->protocol == ATA_PROT_NODATA);
-	ata_tf_load(ap, tf);
+	ata_sff_tf_load(ap, tf);
 }
 
 
@@ -906,7 +906,7 @@ static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile
 {
 	WARN_ON(tf->protocol == ATA_PROT_DMA ||
 		tf->protocol == ATA_PROT_NODATA);
-	ata_exec_command(ap, tf);
+	ata_sff_exec_command(ap, tf);
 }
 
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 6ecd13f..f277cea 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -175,11 +175,11 @@ static int uli_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	host->private_data = hpriv;
 
 	/* the first two ports are standard SFF */
-	rc = ata_pci_init_sff_host(host);
+	rc = ata_pci_sff_init_host(host);
 	if (rc)
 		return rc;
 
-	rc = ata_pci_init_bmdma(host);
+	rc = ata_pci_bmdma_init(host);
 	if (rc)
 		return rc;
 
@@ -200,7 +200,7 @@ static int uli_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			((unsigned long)iomap[1] | ATA_PCI_CTL_OFS) + 4;
 		ioaddr->bmdma_addr = iomap[4] + 16;
 		hpriv->scr_cfg_addr[2] = ULI5287_BASE + ULI5287_OFFS*4;
-		ata_std_ports(ioaddr);
+		ata_sff_std_ports(ioaddr);
 
 		ata_port_desc(host->ports[2],
 			"cmd 0x%llx ctl 0x%llx bmdma 0x%llx",
@@ -215,7 +215,7 @@ static int uli_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			((unsigned long)iomap[3] | ATA_PCI_CTL_OFS) + 4;
 		ioaddr->bmdma_addr = iomap[4] + 24;
 		hpriv->scr_cfg_addr[3] = ULI5287_BASE + ULI5287_OFFS*5;
-		ata_std_ports(ioaddr);
+		ata_sff_std_ports(ioaddr);
 
 		ata_port_desc(host->ports[2],
 			"cmd 0x%llx ctl 0x%llx bmdma 0x%llx",
@@ -242,8 +242,8 @@ static int uli_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 	pci_intx(pdev, 1);
-	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
-				 &uli_sht);
+	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+				 IRQF_SHARED, &uli_sht);
 }
 
 static int __init uli_init(void)
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 4bc6e84..9323bc2 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -174,7 +174,7 @@ static void svia_noop_freeze(struct ata_port *ap)
 	 * certain way.  Leave it alone and just clear pending IRQ.
 	 */
 	ap->ops->check_status(ap);
-	ata_bmdma_irq_clear(ap);
+	ata_sff_irq_clear(ap);
 }
 
 /**
@@ -242,7 +242,7 @@ static int vt6420_prereset(struct ata_link *link, unsigned long deadline)
 
  skip_scr:
 	/* wait for !BSY */
-	ata_wait_ready(ap, deadline);
+	ata_sff_wait_ready(ap, deadline);
 
 	return 0;
 }
@@ -304,7 +304,7 @@ static void vt6421_init_addrs(struct ata_port *ap)
 	ioaddr->bmdma_addr = bmdma_addr;
 	ioaddr->scr_addr = vt6421_scr_addr(iomap[5], ap->port_no);
 
-	ata_std_ports(ioaddr);
+	ata_sff_std_ports(ioaddr);
 
 	ata_port_pbar_desc(ap, ap->port_no, -1, "port");
 	ata_port_pbar_desc(ap, 4, ap->port_no * 8, "bmdma");
@@ -316,7 +316,7 @@ static int vt6420_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 	struct ata_host *host;
 	int rc;
 
-	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
 	*r_host = host;
@@ -448,8 +448,8 @@ static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	svia_configure(pdev);
 
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
-				 &svia_sht);
+	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+				 IRQF_SHARED, &svia_sht);
 }
 
 static int __init svia_init(void)
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index fb3a887..2c3c769 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -200,7 +200,7 @@ static void vsc_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u16 nsect, lbal, lbam, lbah, feature;
 
-	tf->command = ata_check_status(ap);
+	tf->command = ata_sff_check_status(ap);
 	tf->device = readw(ioaddr->device_addr);
 	feature = readw(ioaddr->error_addr);
 	nsect = readw(ioaddr->nsect_addr);
@@ -243,7 +243,7 @@ static void vsc_port_intr(u8 port_status, struct ata_port *ap)
 
 	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc && likely(!(qc->tf.flags & ATA_TFLAG_POLLING)))
-		handled = ata_host_intr(ap, qc);
+		handled = ata_sff_host_intr(ap, qc);
 
 	/* We received an interrupt during a polled command,
 	 * or some other spurious condition.  Interrupt reporting
diff --git a/include/linux/libata.h b/include/linux/libata.h
index af7195c..8ac1e13 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1360,45 +1360,48 @@ extern const struct ata_port_operations ata_bmdma_port_ops;
 	.sg_tablesize		= LIBATA_MAX_PRD,		\
 	.dma_boundary		= ATA_DMA_BOUNDARY
 
-extern void ata_qc_prep(struct ata_queued_cmd *qc);
-extern void ata_dumb_qc_prep(struct ata_queued_cmd *qc);
-extern void ata_std_dev_select(struct ata_port *ap, unsigned int device);
-extern u8 ata_check_status(struct ata_port *ap);
-extern u8 ata_altstatus(struct ata_port *ap);
-extern int ata_busy_sleep(struct ata_port *ap,
-			  unsigned long timeout_pat, unsigned long timeout);
-extern int ata_wait_ready(struct ata_port *ap, unsigned long deadline);
-extern void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
-extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
-extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
-extern unsigned int ata_data_xfer(struct ata_device *dev,
+extern void ata_sff_qc_prep(struct ata_queued_cmd *qc);
+extern void ata_sff_dumb_qc_prep(struct ata_queued_cmd *qc);
+extern void ata_sff_dev_select(struct ata_port *ap, unsigned int device);
+extern u8 ata_sff_check_status(struct ata_port *ap);
+extern u8 ata_sff_altstatus(struct ata_port *ap);
+extern int ata_sff_busy_sleep(struct ata_port *ap,
+			      unsigned long timeout_pat, unsigned long timeout);
+extern int ata_sff_wait_ready(struct ata_port *ap, unsigned long deadline);
+extern void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
+extern void ata_sff_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
+extern void ata_sff_exec_command(struct ata_port *ap,
+				 const struct ata_taskfile *tf);
+extern unsigned int ata_sff_data_xfer(struct ata_device *dev,
 			unsigned char *buf, unsigned int buflen, int rw);
-extern unsigned int ata_data_xfer_noirq(struct ata_device *dev,
+extern unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev,
 			unsigned char *buf, unsigned int buflen, int rw);
-extern u8 ata_irq_on(struct ata_port *ap);
-extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
-			u8 status, int in_wq);
-extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
-extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
-extern irqreturn_t ata_interrupt(int irq, void *dev_instance);
-extern void ata_bmdma_freeze(struct ata_port *ap);
-extern void ata_bmdma_thaw(struct ata_port *ap);
-extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
-extern unsigned int ata_dev_try_classify(struct ata_device *dev, int present,
-					 u8 *r_err);
-extern void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline);
-extern int ata_std_softreset(struct ata_link *link, unsigned int *classes,
+extern u8 ata_sff_irq_on(struct ata_port *ap);
+extern void ata_sff_irq_clear(struct ata_port *ap);
+extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+			    u8 status, int in_wq);
+extern unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc);
+extern unsigned int ata_sff_host_intr(struct ata_port *ap,
+				      struct ata_queued_cmd *qc);
+extern irqreturn_t ata_sff_interrupt(int irq, void *dev_instance);
+extern void ata_sff_freeze(struct ata_port *ap);
+extern void ata_sff_thaw(struct ata_port *ap);
+extern int ata_sff_prereset(struct ata_link *link, unsigned long deadline);
+extern unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
+					  u8 *r_err);
+extern void ata_sff_wait_after_reset(struct ata_port *ap,
+				     unsigned long deadline);
+extern int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 			     unsigned long deadline);
-extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
-			      unsigned long deadline);
-extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
-extern void ata_bmdma_error_handler(struct ata_port *ap);
-extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
+extern int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
+			       unsigned long deadline);
+extern void ata_sff_postreset(struct ata_link *link, unsigned int *classes);
+extern void ata_sff_error_handler(struct ata_port *ap);
+extern void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc);
 extern int ata_sff_port_start(struct ata_port *ap);
-extern void ata_std_ports(struct ata_ioports *ioaddr);
-extern unsigned long ata_pci_default_filter(struct ata_device *dev,
-					    unsigned long xfer_mask);
+extern void ata_sff_std_ports(struct ata_ioports *ioaddr);
+extern unsigned long ata_bmdma_mode_filter(struct ata_device *dev,
+					   unsigned long xfer_mask);
 extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
 extern void ata_bmdma_start(struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
@@ -1406,35 +1409,35 @@ extern u8 ata_bmdma_status(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
 
 #ifdef CONFIG_PCI
-extern int ata_pci_clear_simplex(struct pci_dev *pdev);
-extern int ata_pci_init_bmdma(struct ata_host *host);
-extern int ata_pci_init_sff_host(struct ata_host *host);
-extern int ata_pci_prepare_sff_host(struct pci_dev *pdev,
+extern int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev);
+extern int ata_pci_bmdma_init(struct ata_host *host);
+extern int ata_pci_sff_init_host(struct ata_host *host);
+extern int ata_pci_sff_prepare_host(struct pci_dev *pdev,
 				    const struct ata_port_info * const * ppi,
 				    struct ata_host **r_host);
-extern int ata_pci_activate_sff_host(struct ata_host *host,
+extern int ata_pci_sff_activate_host(struct ata_host *host,
 				     irq_handler_t irq_handler,
 				     struct scsi_host_template *sht);
-extern int ata_pci_init_one(struct pci_dev *pdev,
-			    const struct ata_port_info * const * ppi,
-			    struct scsi_host_template *sht, void *host_priv);
+extern int ata_pci_sff_init_one(struct pci_dev *pdev,
+				const struct ata_port_info * const * ppi,
+				struct scsi_host_template *sht, void *host_priv);
 #endif /* CONFIG_PCI */
 
 /**
- *	ata_pause - Flush writes and pause 400 nanoseconds.
+ *	ata_sff_pause - Flush writes and pause 400 nanoseconds.
  *	@ap: Port to wait for.
  *
  *	LOCKING:
  *	Inherited from caller.
  */
-static inline void ata_pause(struct ata_port *ap)
+static inline void ata_sff_pause(struct ata_port *ap)
 {
-	ata_altstatus(ap);
+	ata_sff_altstatus(ap);
 	ndelay(400);
 }
 
 /**
- *	ata_busy_wait - Wait for a port status register
+ *	ata_sff_busy_wait - Wait for a port status register
  *	@ap: Port to wait for.
  *	@bits: bits that must be clear
  *	@max: number of 10uS waits to perform
@@ -1446,8 +1449,8 @@ static inline void ata_pause(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
-			       unsigned int max)
+static inline u8 ata_sff_busy_wait(struct ata_port *ap, unsigned int bits,
+				   unsigned int max)
 {
 	u8 status;
 
@@ -1472,7 +1475,7 @@ static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
  */
 static inline u8 ata_wait_idle(struct ata_port *ap)
 {
-	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+	u8 status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
 #ifdef ATA_DEBUG
 	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
-- 
1.5.2.4

