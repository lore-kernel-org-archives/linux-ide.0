From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/27] libata: separate out ata_std_postreset() from ata_sff_postreset()
Date: Tue, 25 Mar 2008 22:16:49 +0900
Message-ID: <12064510272192-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:60507 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbYCYNRg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755484rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:35 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Separate out generic ATA portion from ata_sff_postreset() into
ata_std_postreset() and implement ata_sff_postreset() using the std
version.

ata_base_port_ops now has ata_std_postreset() for its postreset and
ata_sff_port_ops overrides it to ata_sff_postreset().

This change affects pdc_adma, ahci, sata_fsl and sata_sil24.  pdc_adma
now specifies postreset to ata_sff_postreset() explicitly.  sata_fsl
and sata_sil24 now use ata_std_postreset() which makes no difference
to them.  ahci now calls ata_std_postreset() from its own postreset
method, which causes no behavior difference.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    2 +-
 drivers/ata/libata-core.c |   24 ++++--------------------
 drivers/ata/libata-sff.c  |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |    1 +
 4 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c5e4501..939dc1d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1444,7 +1444,7 @@ static void ahci_postreset(struct ata_link *link, unsigned int *class)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 new_tmp, tmp;
 
-	ata_sff_postreset(link, class);
+	ata_std_postreset(link, class);
 
 	/* Make sure port's ATAPI bit is set appropriately */
 	new_tmp = tmp = readl(port_mmio + PORT_CMD);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4446477..9184a50 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -76,7 +76,7 @@ const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 const struct ata_port_operations ata_base_port_ops = {
 	.prereset		= ata_std_prereset,
 	.hardreset		= sata_sff_hardreset,
-	.postreset		= ata_sff_postreset,
+	.postreset		= ata_std_postreset,
 	.error_handler		= ata_std_error_handler,
 };
 
@@ -3478,7 +3478,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 }
 
 /**
- *	ata_sff_postreset - standard postreset callback
+ *	ata_std_postreset - standard postreset callback
  *	@link: the target ata_link
  *	@classes: classes of attached devices
  *
@@ -3489,9 +3489,8 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
+void ata_std_postreset(struct ata_link *link, unsigned int *classes)
 {
-	struct ata_port *ap = link->ap;
 	u32 serror;
 
 	DPRINTK("ENTER\n");
@@ -3504,22 +3503,6 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
 		sata_scr_write(link, SCR_ERROR, serror);
 	link->eh_info.serror = 0;
 
-	/* is double-select really necessary? */
-	if (classes[0] != ATA_DEV_NONE)
-		ap->ops->sff_dev_select(ap, 1);
-	if (classes[1] != ATA_DEV_NONE)
-		ap->ops->sff_dev_select(ap, 0);
-
-	/* bail out if no device is present */
-	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
-		DPRINTK("EXIT, no device\n");
-		return;
-	}
-
-	/* set up device control */
-	if (ap->ioaddr.ctl_addr)
-		iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
-
 	DPRINTK("EXIT\n");
 }
 
@@ -6043,6 +6026,7 @@ EXPORT_SYMBOL_GPL(sata_link_debounce);
 EXPORT_SYMBOL_GPL(sata_link_resume);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
+EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9234bc0..e530bac 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -49,6 +49,7 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.thaw			= ata_sff_thaw,
 	.prereset		= ata_sff_prereset,
 	.softreset		= ata_sff_softreset,
+	.postreset		= ata_sff_postreset,
 	.error_handler		= ata_sff_error_handler,
 	.post_internal_cmd	= ata_sff_post_internal_cmd,
 
@@ -2032,6 +2033,41 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 }
 
 /**
+ *	ata_sff_postreset - SFF postreset callback
+ *	@link: the target SFF ata_link
+ *	@classes: classes of attached devices
+ *
+ *	This function is invoked after a successful reset.  It first
+ *	calls ata_std_postreset() and performs SFF specific postreset
+ *	processing.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
+{
+	struct ata_port *ap = link->ap;
+
+	ata_std_postreset(link, classes);
+
+	/* is double-select really necessary? */
+	if (classes[0] != ATA_DEV_NONE)
+		ap->ops->sff_dev_select(ap, 1);
+	if (classes[1] != ATA_DEV_NONE)
+		ap->ops->sff_dev_select(ap, 0);
+
+	/* bail out if no device is present */
+	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
+		DPRINTK("EXIT, no device\n");
+		return;
+	}
+
+	/* set up device control */
+	if (ap->ioaddr.ctl_addr)
+		iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
+}
+
+/**
  *	ata_sff_error_handler - Stock error handler for BMDMA controller
  *	@ap: port to handle error for
  *
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fa138fd..49b6888 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -829,6 +829,7 @@ extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline);
+extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
 
 extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
-- 
1.5.2.4

