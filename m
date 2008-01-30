From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/9] libata: implement and use ata_noop_irq_clear()
Date: Wed, 30 Jan 2008 18:28:57 +0900
Message-ID: <12016853432109-git-send-email-htejun@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:35445 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894AbYA3J3M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 04:29:12 -0500
Received: by wa-out-1112.google.com with SMTP id v27so277515wah.23
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 01:29:12 -0800 (PST)
In-Reply-To: <12016853433196-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@to
Cc: Tejun Heo <htejun@gmail.com>

->irq_clear() is used to clear IRQ bit of a SFF controller and isn't
useful for drivers which don't use libata SFF HSM implementation.
However, it's a required callback and many drivers implement their own
noop version as placeholder.  This patch implements ata_noop_irq_clear
and use it to replace those custom placeholders.

Also, SFF drivers which don't support BMDMA don't need to use
ata_bmdma_irq_clear().  It becomes noop if BMDMA address isn't
initialized.  Convert them to use ata_noop_irq_clear().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c           |   12 +++---------
 drivers/ata/libata-core.c    |    1 +
 drivers/ata/libata-sff.c     |    8 ++++++++
 drivers/ata/pata_ali.c       |    2 +-
 drivers/ata/pata_at32.c      |    7 +------
 drivers/ata/pata_icside.c    |    7 +------
 drivers/ata/pata_isapnp.c    |    2 +-
 drivers/ata/pata_ixp4xx_cf.c |    2 +-
 drivers/ata/pata_legacy.c    |   22 +++++++++++-----------
 drivers/ata/pata_mpc52xx.c   |    2 +-
 drivers/ata/pata_mpiix.c     |    2 +-
 drivers/ata/pata_ns87410.c   |    2 +-
 drivers/ata/pata_pcmcia.c    |    4 ++--
 drivers/ata/pata_platform.c  |    2 +-
 drivers/ata/pata_qdi.c       |    4 ++--
 drivers/ata/pata_winbond.c   |    2 +-
 drivers/ata/pdc_adma.c       |    8 +-------
 drivers/ata/sata_fsl.c       |    7 +------
 drivers/ata/sata_inic162x.c  |    7 +------
 drivers/ata/sata_mv.c        |   11 +++--------
 drivers/ata/sata_qstor.c     |    8 +-------
 drivers/ata/sata_sil24.c     |    8 +-------
 include/linux/libata.h       |    1 +
 23 files changed, 46 insertions(+), 85 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 70a0f07..07dcaf6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -238,7 +238,6 @@ static int ahci_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
 static int ahci_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
-static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
@@ -298,7 +297,7 @@ static const struct ata_port_operations ahci_ops = {
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
-	.irq_clear		= ahci_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
@@ -334,7 +333,7 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
-	.irq_clear		= ahci_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
@@ -368,7 +367,7 @@ static const struct ata_port_operations ahci_p5wdh_ops = {
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
-	.irq_clear		= ahci_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
@@ -1712,11 +1711,6 @@ static void ahci_port_intr(struct ata_port *ap)
 	}
 }
 
-static void ahci_irq_clear(struct ata_port *ap)
-{
-	/* TODO */
-}
-
 static irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e71276b..e61c5db 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7558,6 +7558,7 @@ EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
 EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
+EXPORT_SYMBOL_GPL(ata_noop_irq_clear);
 EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
 EXPORT_SYMBOL_GPL(ata_bmdma_freeze);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 60cd4b1..34cdab0 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -297,6 +297,14 @@ void ata_bmdma_irq_clear(struct ata_port *ap)
 }
 
 /**
+ *	ata_noop_irq_clear - Noop placeholder for irq_clear
+ *	@ap: Port associated with this ATA transaction.
+ */
+void ata_noop_irq_clear(struct ata_port *ap)
+{
+}
+
+/**
  *	ata_bmdma_status - Read PCI IDE BMDMA status
  *	@ap: Port associated with this ATA transaction.
  *
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 5ef6594..8a9044c 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -342,7 +342,7 @@ static struct ata_port_operations ali_early_port_ops = {
 	.data_xfer	= ata_data_xfer,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index 67e574d..86a8ee9 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -166,11 +166,6 @@ static void pata_at32_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	}
 }
 
-static void pata_at32_irq_clear(struct ata_port *ap)
-{
-	/* No DMA controller yet */
-}
-
 static struct scsi_host_template at32_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -208,7 +203,7 @@ static struct ata_port_operations at32_port_ops = {
 
 	.data_xfer		= ata_data_xfer,
 
-	.irq_clear		= pata_at32_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 
 	.port_start		= ata_sff_port_start,
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 5b8586d..121fe52 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -328,11 +328,6 @@ static struct scsi_host_template pata_icside_sht = {
 	.bios_param		= ata_std_bios_param,
 };
 
-/* wish this was exported from libata-core */
-static void ata_dummy_noret(struct ata_port *port)
-{
-}
-
 static void pata_icside_postreset(struct ata_link *link, unsigned int *classes)
 {
 	struct ata_port *ap = link->ap;
@@ -386,7 +381,7 @@ static struct ata_port_operations pata_icside_port_ops = {
 	.error_handler		= pata_icside_error_handler,
 	.post_internal_cmd	= pata_icside_bmdma_stop,
 
-	.irq_clear		= ata_dummy_noret,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 
 	.port_start		= pata_icside_port_start,
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 4320e79..ef561de 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -55,7 +55,7 @@ static struct ata_port_operations isapnp_port_ops = {
 
 	.data_xfer	= ata_data_xfer,
 
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 030878f..83e38cc 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -126,7 +126,7 @@ static struct ata_port_operations ixp4xx_port_ops = {
 	.cable_detect		= ata_cable_40wire,
 
 	.irq_handler		= ata_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 
 	.port_start		= ata_port_start,
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 333dc15..7b2140e 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -252,7 +252,7 @@ static struct ata_port_operations simple_port_ops = {
 	.data_xfer	= ata_data_xfer_noirq,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -279,7 +279,7 @@ static struct ata_port_operations legacy_port_ops = {
 	.data_xfer	= ata_data_xfer_noirq,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -393,7 +393,7 @@ static struct ata_port_operations pdc20230_port_ops = {
 	.data_xfer	= pdc_data_xfer_vlb,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -447,7 +447,7 @@ static struct ata_port_operations ht6560a_port_ops = {
 	.data_xfer	= ata_data_xfer,	/* Check vlb/noirq */
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -512,7 +512,7 @@ static struct ata_port_operations ht6560b_port_ops = {
 	.data_xfer	= ata_data_xfer,    /* FIXME: Check 32bit and noirq */
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -633,7 +633,7 @@ static struct ata_port_operations opti82c611a_port_ops = {
 	.data_xfer	= ata_data_xfer,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -765,7 +765,7 @@ static struct ata_port_operations opti82c46x_port_ops = {
 	.data_xfer	= ata_data_xfer,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -950,7 +950,7 @@ static struct ata_port_operations qdi6500_port_ops = {
 	.data_xfer	= vlb32_data_xfer,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -977,7 +977,7 @@ static struct ata_port_operations qdi6580_port_ops = {
 	.data_xfer	= vlb32_data_xfer,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -1004,7 +1004,7 @@ static struct ata_port_operations qdi6580dp_port_ops = {
 	.data_xfer	= vlb32_data_xfer,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -1095,7 +1095,7 @@ static struct ata_port_operations winbond_port_ops = {
 
 	.data_xfer	= vlb32_data_xfer,
 
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index dc40162..bc5259e 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -296,7 +296,7 @@ static struct ata_port_operations mpc52xx_ata_port_ops = {
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 	.port_start		= ata_port_start,
 };
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index c0d9e0c..ced6372 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -187,7 +187,7 @@ static struct ata_port_operations mpiix_port_ops = {
 	.qc_issue	= mpiix_qc_issue_prot,
 	.data_xfer	= ata_data_xfer,
 
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 9fe66fd..d182bdf 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -182,7 +182,7 @@ static struct ata_port_operations ns87410_port_ops = {
 	.data_xfer	= ata_data_xfer,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 3e7f6a9..9881a9e 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -164,7 +164,7 @@ static struct ata_port_operations pcmcia_port_ops = {
 
 	.data_xfer	= ata_data_xfer_noirq,
 
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -189,7 +189,7 @@ static struct ata_port_operations pcmcia_8bit_port_ops = {
 
 	.data_xfer	= ata_data_xfer_8bit,
 
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index ac03a90..07b024a 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -86,7 +86,7 @@ static struct ata_port_operations pata_platform_port_ops = {
 
 	.data_xfer		= ata_data_xfer_noirq,
 
-	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 
 	.port_start		= ata_dummy_ret0,
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 9f308ed..60238d5 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -191,7 +191,7 @@ static struct ata_port_operations qdi6500_port_ops = {
 
 	.data_xfer	= qdi_data_xfer,
 
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
@@ -217,7 +217,7 @@ static struct ata_port_operations qdi6580_port_ops = {
 
 	.data_xfer	= qdi_data_xfer,
 
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 99c92ed..5318248 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -159,7 +159,7 @@ static struct ata_port_operations winbond_port_ops = {
 
 	.data_xfer	= winbond_data_xfer,
 
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 8e1b7e9..bc2d12a 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -138,7 +138,6 @@ static unsigned int adma_qc_issue(struct ata_queued_cmd *qc);
 static int adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void adma_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 adma_bmdma_status(struct ata_port *ap);
-static void adma_irq_clear(struct ata_port *ap);
 static void adma_freeze(struct ata_port *ap);
 static void adma_thaw(struct ata_port *ap);
 static void adma_error_handler(struct ata_port *ap);
@@ -174,7 +173,7 @@ static const struct ata_port_operations adma_ata_ops = {
 	.freeze			= adma_freeze,
 	.thaw			= adma_thaw,
 	.error_handler		= adma_error_handler,
-	.irq_clear		= adma_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
@@ -223,11 +222,6 @@ static u8 adma_bmdma_status(struct ata_port *ap)
 	return 0;
 }
 
-static void adma_irq_clear(struct ata_port *ap)
-{
-	/* nothing */
-}
-
 static void adma_reset_engine(struct ata_port *ap)
 {
 	void __iomem *chan = ADMA_PORT_REGS(ap);
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b66a1f4..e798c4c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -944,11 +944,6 @@ static void sata_fsl_post_internal_cmd(struct ata_queued_cmd *qc)
 	}
 }
 
-static void sata_fsl_irq_clear(struct ata_port *ap)
-{
-	/* unused */
-}
-
 static void sata_fsl_error_intr(struct ata_port *ap)
 {
 	struct ata_link *link = &ap->link;
@@ -1234,7 +1229,7 @@ static const struct ata_port_operations sata_fsl_ops = {
 
 	.qc_prep = sata_fsl_qc_prep,
 	.qc_issue = sata_fsl_qc_issue,
-	.irq_clear = sata_fsl_irq_clear,
+	.irq_clear = ata_noop_irq_clear,
 
 	.scr_read = sata_fsl_scr_read,
 	.scr_write = sata_fsl_scr_write,
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 96e614a..ea7e2b1 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -277,11 +277,6 @@ static u8 inic_bmdma_status(struct ata_port *ap)
 	return ATA_DMA_INTR;
 }
 
-static void inic_irq_clear(struct ata_port *ap)
-{
-	/* noop */
-}
-
 static void inic_host_intr(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
@@ -566,7 +561,7 @@ static struct ata_port_operations inic_port_ops = {
 	.bmdma_stop		= inic_bmdma_stop,
 	.bmdma_status		= inic_bmdma_status,
 
-	.irq_clear		= inic_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 
 	.qc_prep	 	= ata_qc_prep,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 0e54d9e..939bf1d 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -414,7 +414,6 @@ struct mv_hw_ops {
 	void (*reset_bus)(struct pci_dev *pdev, void __iomem *mmio);
 };
 
-static void mv_irq_clear(struct ata_port *ap);
 static int mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val);
 static int mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
 static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val);
@@ -501,7 +500,7 @@ static const struct ata_port_operations mv5_ops = {
 	.qc_issue		= mv_qc_issue,
 	.data_xfer		= ata_data_xfer,
 
-	.irq_clear		= mv_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 
 	.error_handler		= mv_error_handler,
@@ -529,7 +528,7 @@ static const struct ata_port_operations mv6_ops = {
 	.qc_issue		= mv_qc_issue,
 	.data_xfer		= ata_data_xfer,
 
-	.irq_clear		= mv_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 
 	.error_handler		= mv_error_handler,
@@ -557,7 +556,7 @@ static const struct ata_port_operations mv_iie_ops = {
 	.qc_issue		= mv_qc_issue,
 	.data_xfer		= ata_data_xfer,
 
-	.irq_clear		= mv_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 
 	.error_handler		= mv_error_handler,
@@ -760,10 +759,6 @@ static inline int mv_get_hc_count(unsigned long port_flags)
 	return ((port_flags & MV_FLAG_DUAL_HC) ? 2 : 1);
 }
 
-static void mv_irq_clear(struct ata_port *ap)
-{
-}
-
 static void mv_set_edma_ptrs(void __iomem *port_mmio,
 			     struct mv_host_priv *hpriv,
 			     struct mv_port_priv *pp)
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 91cc12c..3c8e97f 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -121,7 +121,6 @@ static unsigned int qs_qc_issue(struct ata_queued_cmd *qc);
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc);
 static void qs_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 qs_bmdma_status(struct ata_port *ap);
-static void qs_irq_clear(struct ata_port *ap);
 static void qs_freeze(struct ata_port *ap);
 static void qs_thaw(struct ata_port *ap);
 static void qs_error_handler(struct ata_port *ap);
@@ -157,7 +156,7 @@ static const struct ata_port_operations qs_ata_ops = {
 	.freeze			= qs_freeze,
 	.thaw			= qs_thaw,
 	.error_handler		= qs_error_handler,
-	.irq_clear		= qs_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 	.scr_read		= qs_scr_read,
 	.scr_write		= qs_scr_write,
@@ -211,11 +210,6 @@ static u8 qs_bmdma_status(struct ata_port *ap)
 	return 0;
 }
 
-static void qs_irq_clear(struct ata_port *ap)
-{
-	/* nothing */
-}
-
 static inline void qs_enter_reg_mode(struct ata_port *ap)
 {
 	u8 __iomem *chan = qs_mmio_base(ap->host) + (ap->port_no * 0x4000);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 64cdde5..5e57f78 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -348,7 +348,6 @@ static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static int sil24_qc_defer(struct ata_queued_cmd *qc);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
-static void sil24_irq_clear(struct ata_port *ap);
 static void sil24_pmp_attach(struct ata_port *ap);
 static void sil24_pmp_detach(struct ata_port *ap);
 static void sil24_freeze(struct ata_port *ap);
@@ -416,7 +415,7 @@ static const struct ata_port_operations sil24_ops = {
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
-	.irq_clear		= sil24_irq_clear,
+	.irq_clear		= ata_noop_irq_clear,
 
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
@@ -921,11 +920,6 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 	return 0;
 }
 
-static void sil24_irq_clear(struct ata_port *ap)
-{
-	/* unused */
-}
-
 static void sil24_pmp_attach(struct ata_port *ap)
 {
 	sil24_config_pmp(ap, 1);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7af3da8..b6f06a2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -903,6 +903,7 @@ extern void ata_bmdma_start(struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
+extern void ata_noop_irq_clear(struct ata_port *ap);
 extern void ata_bmdma_freeze(struct ata_port *ap);
 extern void ata_bmdma_thaw(struct ata_port *ap);
 extern void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
-- 
1.5.2.4

