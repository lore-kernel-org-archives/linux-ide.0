From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: implement PMP helpers
Date: Tue, 25 Mar 2008 22:25:16 +0900
Message-ID: <12064515172410-git-send-email-htejun@gmail.com>
References: <1206451517133-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:22913 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbYCYNZ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:25:26 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2261130wra.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:25:25 -0700 (PDT)
In-Reply-To: <1206451517133-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca
Cc: Tejun Heo <htejun@gmail.com>

Implement helpers to test whether PMP is supported, attached and
determine pmp number to use when issuing SRST to a link.  While at it,
move ata_is_host_link() so that it's together with the two new PMP
helpers.

This change simplifies LLDs and helps making PMP support optional.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |   30 ++++++------------------------
 drivers/ata/libata-acpi.c |    2 +-
 drivers/ata/libata-core.c |    4 ++--
 drivers/ata/libata-eh.c   |   14 +++++++-------
 drivers/ata/libata-pmp.c  |    6 +++---
 drivers/ata/libata-scsi.c |    6 +++---
 drivers/ata/sata_sil24.c  |   27 +++++++--------------------
 include/linux/libata.h    |   38 +++++++++++++++++++++++++++++---------
 8 files changed, 58 insertions(+), 69 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6281f7f..0de6432 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -260,8 +260,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 				unsigned long deadline);
 static void ahci_postreset(struct ata_link *link, unsigned int *class);
-static int ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
-			      unsigned long deadline);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_port_resume(struct ata_port *ap);
@@ -301,7 +299,7 @@ static struct ata_port_operations ahci_ops = {
 	.softreset		= ahci_softreset,
 	.hardreset		= ahci_hardreset,
 	.postreset		= ahci_postreset,
-	.pmp_softreset		= ahci_pmp_softreset,
+	.pmp_softreset		= ahci_softreset,
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 	.dev_config		= ahci_dev_config,
@@ -1263,10 +1261,11 @@ static int ahci_check_ready(struct ata_link *link)
 	return 0;
 }
 
-static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
-			     int pmp, unsigned long deadline)
+static int ahci_softreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
+	int pmp = sata_srst_pmp(link);
 	const char *reason = NULL;
 	unsigned long now, msecs;
 	struct ata_taskfile tf;
@@ -1326,17 +1325,6 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	return rc;
 }
 
-static int ahci_softreset(struct ata_link *link, unsigned int *class,
-			  unsigned long deadline)
-{
-	int pmp = 0;
-
-	if (link->ap->flags & ATA_FLAG_PMP)
-		pmp = SATA_PMP_CTRL_PORT;
-
-	return ahci_do_softreset(link, class, pmp, deadline);
-}
-
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
@@ -1457,12 +1445,6 @@ static void ahci_postreset(struct ata_link *link, unsigned int *class)
 	}
 }
 
-static int ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
-			      unsigned long deadline)
-{
-	return ahci_do_softreset(link, class, link->pmp, deadline);
-}
-
 static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 {
 	struct scatterlist *sg;
@@ -1581,7 +1563,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 				  unk[0], unk[1], unk[2], unk[3]);
 	}
 
-	if (ap->nr_pmp_links && (irq_stat & PORT_IRQ_BAD_PMP)) {
+	if (sata_pmp_attached(ap) && (irq_stat & PORT_IRQ_BAD_PMP)) {
 		active_ehi->err_mask |= AC_ERR_HSM;
 		active_ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(active_ehi, "incorrect PMP");
@@ -1847,7 +1829,7 @@ static int ahci_port_resume(struct ata_port *ap)
 	ahci_power_up(ap);
 	ahci_start_port(ap);
 
-	if (ap->nr_pmp_links)
+	if (sata_pmp_attached(ap))
 		ahci_pmp_attach(ap);
 	else
 		ahci_pmp_detach(ap);
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index bf98a56..f88a4f9 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -77,7 +77,7 @@ void ata_acpi_associate_sata_port(struct ata_port *ap)
 {
 	WARN_ON(!(ap->flags & ATA_FLAG_ACPI_SATA));
 
-	if (!ap->nr_pmp_links) {
+	if (!sata_pmp_attached(ap)) {
 		acpi_integer adr = SATA_ADR(ap->port_no, NO_PORT_MULT);
 
 		ap->link.device->acpi_handle =
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 51d7959..7646523 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2240,7 +2240,7 @@ int ata_dev_configure(struct ata_device *dev)
 		 * changed notifications and ATAPI ANs.
 		 */
 		if ((ap->flags & ATA_FLAG_AN) && ata_id_has_atapi_AN(id) &&
-		    (!ap->nr_pmp_links ||
+		    (!sata_pmp_attached(ap) ||
 		     sata_scr_read(&ap->link, SCR_NOTIFICATION, &sntf) == 0)) {
 			unsigned int err_mask;
 
@@ -3585,7 +3585,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	if (online)
 		*online = true;
 
-	if ((link->ap->flags & ATA_FLAG_PMP) && ata_is_host_link(link)) {
+	if (sata_pmp_supported(link->ap) && ata_is_host_link(link)) {
 		/* If PMP is supported, we have to do follow-up SRST.
 		 * Some PMPs don't send D2H Reg FIS after hardreset if
 		 * the first port is empty.  Wait only for
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ebcd73f..53d6cde 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -873,9 +873,9 @@ int sata_async_notification(struct ata_port *ap)
 	if (rc == 0)
 		sata_scr_write(&ap->link, SCR_NOTIFICATION, sntf);
 
-	if (!ap->nr_pmp_links || rc) {
+	if (!sata_pmp_attached(ap) || rc) {
 		/* PMP is not attached or SNTF is not available */
-		if (!ap->nr_pmp_links) {
+		if (!sata_pmp_attached(ap)) {
 			/* PMP is not attached.  Check whether ATAPI
 			 * AN is configured.  If so, notify media
 			 * change.
@@ -1848,7 +1848,7 @@ void ata_eh_autopsy(struct ata_port *ap)
 	/* Autopsy of fanout ports can affect host link autopsy.
 	 * Perform host link autopsy last.
 	 */
-	if (ap->nr_pmp_links)
+	if (sata_pmp_attached(ap))
 		ata_eh_link_autopsy(&ap->link);
 }
 
@@ -2071,7 +2071,7 @@ static int ata_eh_followup_srst_needed(struct ata_link *link,
 	}
 	if (rc != 0)
 		return 0;
-	if ((link->ap->flags & ATA_FLAG_PMP) && ata_is_host_link(link))
+	if (sata_pmp_supported(link->ap) && ata_is_host_link(link))
 		return 1;
 	return 0;
 }
@@ -2663,7 +2663,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		/* if PMP is attached, this function only deals with
 		 * downstream links, port should stay thawed.
 		 */
-		if (!ap->nr_pmp_links)
+		if (!sata_pmp_attached(ap))
 			ata_eh_freeze_port(ap);
 
 		ata_port_for_each_link(link, ap) {
@@ -2682,7 +2682,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			}
 		}
 
-		if (!ap->nr_pmp_links)
+		if (!sata_pmp_attached(ap))
 			ata_eh_thaw_port(ap);
 	}
 
@@ -2726,7 +2726,7 @@ dev_fail:
 			/* PMP reset requires working host port.
 			 * Can't retry if it's frozen.
 			 */
-			if (ap->nr_pmp_links)
+			if (sata_pmp_attached(ap))
 				goto out;
 			break;
 		}
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index bb10c06..ff1822a 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -411,7 +411,7 @@ int sata_pmp_attach(struct ata_device *dev)
 	int rc;
 
 	/* is it hanging off the right place? */
-	if (!(ap->flags & ATA_FLAG_PMP)) {
+	if (!sata_pmp_supported(ap)) {
 		ata_dev_printk(dev, KERN_ERR,
 			       "host does not support Port Multiplier\n");
 		return -EINVAL;
@@ -876,7 +876,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 
  retry:
 	/* PMP attached? */
-	if (!ap->nr_pmp_links) {
+	if (!sata_pmp_attached(ap)) {
 		rc = ata_eh_recover(ap, ops->prereset, ops->softreset,
 				    ops->hardreset, ops->postreset, NULL);
 		if (rc) {
@@ -983,7 +983,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 	if (ap->pflags & ATA_PFLAG_UNLOADING)
 		return rc;
 
-	if (!ap->nr_pmp_links)
+	if (!sata_pmp_attached(ap))
 		goto retry;
 
 	if (--pmp_tries) {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a70881c..fedf62d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2617,7 +2617,7 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
 static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
 {
-	if (ap->nr_pmp_links == 0) {
+	if (!sata_pmp_attached(ap)) {
 		if (likely(devno < ata_link_max_devices(&ap->link)))
 			return &ap->link.device[devno];
 	} else {
@@ -2634,7 +2634,7 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
 	int devno;
 
 	/* skip commands not addressed to targets we simulate */
-	if (ap->nr_pmp_links == 0) {
+	if (!sata_pmp_attached(ap)) {
 		if (unlikely(scsidev->channel || scsidev->lun))
 			return NULL;
 		devno = scsidev->id;
@@ -3492,7 +3492,7 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 	if (lun != SCAN_WILD_CARD && lun)
 		return -EINVAL;
 
-	if (ap->nr_pmp_links == 0) {
+	if (!sata_pmp_attached(ap)) {
 		if (channel != SCAN_WILD_CARD && channel)
 			return -EINVAL;
 		devno = id;
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 6039614..0687893 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -354,8 +354,6 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline);
 static int sil24_hardreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline);
-static int sil24_pmp_softreset(struct ata_link *link, unsigned int *class,
-			       unsigned long deadline);
 static int sil24_pmp_hardreset(struct ata_link *link, unsigned int *class,
 			       unsigned long deadline);
 static void sil24_error_handler(struct ata_port *ap);
@@ -408,7 +406,7 @@ static struct ata_port_operations sil24_ops = {
 	.thaw			= sil24_thaw,
 	.softreset		= sil24_softreset,
 	.hardreset		= sil24_hardreset,
-	.pmp_softreset		= sil24_pmp_softreset,
+	.pmp_softreset		= sil24_softreset,
 	.pmp_hardreset		= sil24_pmp_hardreset,
 	.error_handler		= sil24_error_handler,
 	.post_internal_cmd	= sil24_post_internal_cmd,
@@ -588,7 +586,7 @@ static int sil24_init_port(struct ata_port *ap)
 	u32 tmp;
 
 	/* clear PMP error status */
-	if (ap->nr_pmp_links)
+	if (sata_pmp_attached(ap))
 		sil24_clear_pmp(ap);
 
 	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
@@ -653,10 +651,11 @@ static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
 	return rc;
 }
 
-static int sil24_do_softreset(struct ata_link *link, unsigned int *class,
-			      int pmp, unsigned long deadline)
+static int sil24_softreset(struct ata_link *link, unsigned int *class,
+			   unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
+	int pmp = sata_srst_pmp(link);
 	unsigned long timeout_msec = 0;
 	struct ata_taskfile tf;
 	const char *reason;
@@ -706,12 +705,6 @@ static int sil24_do_softreset(struct ata_link *link, unsigned int *class,
 	return -EIO;
 }
 
-static int sil24_softreset(struct ata_link *link, unsigned int *class,
-			   unsigned long deadline)
-{
-	return sil24_do_softreset(link, class, SATA_PMP_CTRL_PORT, deadline);
-}
-
 static int sil24_hardreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline)
 {
@@ -926,12 +919,6 @@ static void sil24_pmp_detach(struct ata_port *ap)
 	sil24_config_pmp(ap, 0);
 }
 
-static int sil24_pmp_softreset(struct ata_link *link, unsigned int *class,
-			       unsigned long deadline)
-{
-	return sil24_do_softreset(link, class, link->pmp, deadline);
-}
-
 static int sil24_pmp_hardreset(struct ata_link *link, unsigned int *class,
 			       unsigned long deadline)
 {
@@ -1034,7 +1021,7 @@ static void sil24_error_intr(struct ata_port *ap)
 		}
 
 		/* find out the offending link and qc */
-		if (ap->nr_pmp_links) {
+		if (sata_pmp_attached(ap)) {
 			context = readl(port + PORT_CONTEXT);
 			pmp = (context >> 5) & 0xf;
 
@@ -1082,7 +1069,7 @@ static void sil24_error_intr(struct ata_port *ap)
 		ehi->action |= action;
 
 		/* if PMP, resume */
-		if (ap->nr_pmp_links)
+		if (sata_pmp_attached(ap))
 			writel(PORT_CS_PMP_RESUME, port + PORT_CTRL_STAT);
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a1a9f3f..fd73f05 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1087,13 +1087,38 @@ extern const struct ata_port_operations sata_port_ops;
 	.change_queue_depth	= ata_scsi_change_queue_depth
 
 /*
+ * PMP helpers
+ */
+static inline bool sata_pmp_supported(struct ata_port *ap)
+{
+	return ap->flags & ATA_FLAG_PMP;
+}
+
+static inline bool sata_pmp_attached(struct ata_port *ap)
+{
+	return ap->nr_pmp_links != 0;
+}
+
+static inline int ata_is_host_link(const struct ata_link *link)
+{
+	return link == &link->ap->link;
+}
+
+static inline int sata_srst_pmp(struct ata_link *link)
+{
+	if (sata_pmp_supported(link->ap) && ata_is_host_link(link))
+		return SATA_PMP_CTRL_PORT;
+	return link->pmp;
+}
+
+/*
  * printk helpers
  */
 #define ata_port_printk(ap, lv, fmt, args...) \
 	printk("%sata%u: "fmt, lv, (ap)->print_id , ##args)
 
 #define ata_link_printk(link, lv, fmt, args...) do { \
-	if ((link)->ap->nr_pmp_links) \
+	if (sata_pmp_attached((link)->ap)) \
 		printk("%sata%u.%02u: "fmt, lv, (link)->ap->print_id,	\
 		       (link)->pmp , ##args); \
 	else \
@@ -1179,11 +1204,6 @@ static inline unsigned int ata_dev_absent(const struct ata_device *dev)
 /*
  * link helpers
  */
-static inline int ata_is_host_link(const struct ata_link *link)
-{
-	return link == &link->ap->link;
-}
-
 static inline int ata_link_max_devices(const struct ata_link *link)
 {
 	if (ata_is_host_link(link) && link->ap->flags & ATA_FLAG_SLAVE_POSS)
@@ -1198,7 +1218,7 @@ static inline int ata_link_active(struct ata_link *link)
 
 static inline struct ata_link *ata_port_first_link(struct ata_port *ap)
 {
-	if (ap->nr_pmp_links)
+	if (sata_pmp_attached(ap))
 		return ap->pmp_link;
 	return &ap->link;
 }
@@ -1207,8 +1227,8 @@ static inline struct ata_link *ata_port_next_link(struct ata_link *link)
 {
 	struct ata_port *ap = link->ap;
 
-	if (link == &ap->link) {
-		if (!ap->nr_pmp_links)
+	if (ata_is_host_link(link)) {
+		if (!sata_pmp_attached(ap))
 			return NULL;
 		return ap->pmp_link;
 	}
-- 
1.5.2.4

