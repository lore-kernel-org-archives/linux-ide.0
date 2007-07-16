From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/21] libata: improve EH report formatting
Date: Mon, 16 Jul 2007 14:29:39 +0900
Message-ID: <118456377939-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:2491 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759301AbXGPF3t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1464057wah
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:48 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Requiring LLDs to format multiple error description messages properly
doesn't work too well.  Help LLDs a bit by making ata_ehi_push_desc()
insert ", " on each invocation.  __ata_ehi_push_desc() is the raw
version without the automatic separator.

While at it, make ehi_desc interface proper functions instead of
macros.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    6 ++--
 drivers/ata/libata-core.c |    3 ++
 drivers/ata/libata-eh.c   |   69 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/sata_mv.c     |    8 ++--
 drivers/ata/sata_nv.c     |   22 ++++++++------
 drivers/ata/sata_sil24.c  |   12 ++++----
 include/linux/libata.h    |   13 ++------
 7 files changed, 98 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c5034d4..210292c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1289,12 +1289,12 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	if (irq_stat & PORT_IRQ_IF_ERR) {
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_SOFTRESET;
-		ata_ehi_push_desc(ehi, ", interface fatal error");
+		ata_ehi_push_desc(ehi, "interface fatal error");
 	}
 
 	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
 		ata_ehi_hotplugged(ehi);
-		ata_ehi_push_desc(ehi, ", %s", irq_stat & PORT_IRQ_CONNECT ?
+		ata_ehi_push_desc(ehi, "%s", irq_stat & PORT_IRQ_CONNECT ?
 			"connection status changed" : "PHY RDY changed");
 	}
 
@@ -1303,7 +1303,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 		err_mask |= AC_ERR_HSM;
 		action |= ATA_EH_SOFTRESET;
-		ata_ehi_push_desc(ehi, ", unknown FIS %08x %08x %08x %08x",
+		ata_ehi_push_desc(ehi, "unknown FIS %08x %08x %08x %08x",
 				  unk[0], unk[1], unk[2], unk[3]);
 	}
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a78af01..928b69a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6944,6 +6944,9 @@ EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
+EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
+EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
+EXPORT_SYMBOL_GPL(ata_ehi_clear_desc);
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 EXPORT_SYMBOL_GPL(ata_port_abort);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9aa62a0..96b184e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -85,6 +85,71 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 { }
 #endif /* CONFIG_PM */
 
+static void __ata_ehi_pushv_desc(struct ata_eh_info *ehi, const char *fmt,
+				 va_list args)
+{
+	ehi->desc_len += vscnprintf(ehi->desc + ehi->desc_len,
+				     ATA_EH_DESC_LEN - ehi->desc_len,
+				     fmt, args);
+}
+
+/**
+ *	__ata_ehi_push_desc - push error description without adding separator
+ *	@ehi: target EHI
+ *	@fmt: printf format string
+ *
+ *	Format string according to @fmt and append it to @ehi->desc.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void __ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	__ata_ehi_pushv_desc(ehi, fmt, args);
+	va_end(args);
+}
+
+/**
+ *	ata_ehi_push_desc - push error description with separator
+ *	@ehi: target EHI
+ *	@fmt: printf format string
+ *
+ *	Format string according to @fmt and append it to @ehi->desc.
+ *	If @ehi->desc is not empty, ", " is added in-between.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...)
+{
+	va_list args;
+
+	if (ehi->desc_len)
+		__ata_ehi_push_desc(ehi, ", ");
+
+	va_start(args, fmt);
+	__ata_ehi_pushv_desc(ehi, fmt, args);
+	va_end(args);
+}
+
+/**
+ *	ata_ehi_clear_desc - clean error description
+ *	@ehi: target EHI
+ *
+ *	Clear @ehi->desc.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_ehi_clear_desc(struct ata_eh_info *ehi)
+{
+	ehi->desc[0] = '\0';
+	ehi->desc_len = 0;
+}
+
 static void ata_ering_record(struct ata_ering *ering, int is_io,
 			     unsigned int err_mask)
 {
@@ -1524,14 +1589,14 @@ static void ata_eh_report(struct ata_port *ap)
 			       ehc->i.err_mask, ap->sactive, ehc->i.serror,
 			       ehc->i.action, frozen);
 		if (desc)
-			ata_dev_printk(ehc->i.dev, KERN_ERR, "(%s)\n", desc);
+			ata_dev_printk(ehc->i.dev, KERN_ERR, "%s\n", desc);
 	} else {
 		ata_port_printk(ap, KERN_ERR, "exception Emask 0x%x "
 				"SAct 0x%x SErr 0x%x action 0x%x%s\n",
 				ehc->i.err_mask, ap->sactive, ehc->i.serror,
 				ehc->i.action, frozen);
 		if (desc)
-			ata_port_printk(ap, KERN_ERR, "(%s)\n", desc);
+			ata_port_printk(ap, KERN_ERR, "%s\n", desc);
 	}
 
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 80ade5b..b4b737e 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1411,12 +1411,12 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 			EDMA_ERR_INTRL_PAR)) {
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_HARDRESET;
-		ata_ehi_push_desc(ehi, ", parity error");
+		ata_ehi_push_desc(ehi, "parity error");
 	}
 	if (edma_err_cause & (EDMA_ERR_DEV_DCON | EDMA_ERR_DEV_CON)) {
 		ata_ehi_hotplugged(ehi);
 		ata_ehi_push_desc(ehi, edma_err_cause & EDMA_ERR_DEV_DCON ?
-			", dev disconnect" : ", dev connect");
+			"dev disconnect" : "dev connect");
 	}
 
 	if (IS_GEN_I(hpriv)) {
@@ -1425,7 +1425,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 		if (edma_err_cause & EDMA_ERR_SELF_DIS_5) {
 			struct mv_port_priv *pp	= ap->private_data;
 			pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
-			ata_ehi_push_desc(ehi, ", EDMA self-disable");
+			ata_ehi_push_desc(ehi, "EDMA self-disable");
 		}
 	} else {
 		eh_freeze_mask = EDMA_EH_FREEZE;
@@ -1433,7 +1433,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 		if (edma_err_cause & EDMA_ERR_SELF_DIS) {
 			struct mv_port_priv *pp	= ap->private_data;
 			pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
-			ata_ehi_push_desc(ehi, ", EDMA self-disable");
+			ata_ehi_push_desc(ehi, "EDMA self-disable");
 		}
 
 		if (edma_err_cause & EDMA_ERR_SERR) {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index db81e3e..5d943da 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -715,19 +715,20 @@ static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 		int freeze = 0;
 
 		ata_ehi_clear_desc(ehi);
-		ata_ehi_push_desc(ehi, "CPB resp_flags 0x%x", flags );
+		__ata_ehi_push_desc(ehi, "CPB resp_flags 0x%x: ", flags );
 		if (flags & NV_CPB_RESP_ATA_ERR) {
-			ata_ehi_push_desc(ehi, ": ATA error");
+			ata_ehi_push_desc(ehi, "ATA error");
 			ehi->err_mask |= AC_ERR_DEV;
 		} else if (flags & NV_CPB_RESP_CMD_ERR) {
-			ata_ehi_push_desc(ehi, ": CMD error");
+			ata_ehi_push_desc(ehi, "CMD error");
 			ehi->err_mask |= AC_ERR_DEV;
 		} else if (flags & NV_CPB_RESP_CPB_ERR) {
-			ata_ehi_push_desc(ehi, ": CPB error");
+			ata_ehi_push_desc(ehi, "CPB error");
 			ehi->err_mask |= AC_ERR_SYSTEM;
 			freeze = 1;
 		} else {
 			/* notifier error, but no error in CPB flags? */
+			ata_ehi_push_desc(ehi, "unknown");
 			ehi->err_mask |= AC_ERR_OTHER;
 			freeze = 1;
 		}
@@ -854,20 +855,21 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 				struct ata_eh_info *ehi = &ap->eh_info;
 
 				ata_ehi_clear_desc(ehi);
-				ata_ehi_push_desc(ehi, "ADMA status 0x%08x", status );
+				__ata_ehi_push_desc(ehi, "ADMA status 0x%08x: ", status );
 				if (status & NV_ADMA_STAT_TIMEOUT) {
 					ehi->err_mask |= AC_ERR_SYSTEM;
-					ata_ehi_push_desc(ehi, ": timeout");
+					ata_ehi_push_desc(ehi, "timeout");
 				} else if (status & NV_ADMA_STAT_HOTPLUG) {
 					ata_ehi_hotplugged(ehi);
-					ata_ehi_push_desc(ehi, ": hotplug");
+					ata_ehi_push_desc(ehi, "hotplug");
 				} else if (status & NV_ADMA_STAT_HOTUNPLUG) {
 					ata_ehi_hotplugged(ehi);
-					ata_ehi_push_desc(ehi, ": hot unplug");
+					ata_ehi_push_desc(ehi, "hot unplug");
 				} else if (status & NV_ADMA_STAT_SERROR) {
 					/* let libata analyze SError and figure out the cause */
-					ata_ehi_push_desc(ehi, ": SError");
-				}
+					ata_ehi_push_desc(ehi, "SError");
+				} else
+					ata_ehi_push_desc(ehi, "unknown");
 				ata_port_freeze(ap);
 				continue;
 			}
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index e538edc..e201f1c 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -814,16 +814,16 @@ static void sil24_error_intr(struct ata_port *ap)
 
 	if (irq_stat & (PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG)) {
 		ata_ehi_hotplugged(ehi);
-		ata_ehi_push_desc(ehi, ", %s",
-			       irq_stat & PORT_IRQ_PHYRDY_CHG ?
-			       "PHY RDY changed" : "device exchanged");
+		ata_ehi_push_desc(ehi, "%s",
+				  irq_stat & PORT_IRQ_PHYRDY_CHG ?
+				  "PHY RDY changed" : "device exchanged");
 		freeze = 1;
 	}
 
 	if (irq_stat & PORT_IRQ_UNK_FIS) {
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_SOFTRESET;
-		ata_ehi_push_desc(ehi , ", unknown FIS");
+		ata_ehi_push_desc(ehi, "unknown FIS");
 		freeze = 1;
 	}
 
@@ -842,11 +842,11 @@ static void sil24_error_intr(struct ata_port *ap)
 		if (ci && ci->desc) {
 			err_mask |= ci->err_mask;
 			action |= ci->action;
-			ata_ehi_push_desc(ehi, ", %s", ci->desc);
+			ata_ehi_push_desc(ehi, "%s", ci->desc);
 		} else {
 			err_mask |= AC_ERR_OTHER;
 			action |= ATA_EH_SOFTRESET;
-			ata_ehi_push_desc(ehi, ", unknown command error %d",
+			ata_ehi_push_desc(ehi, "unknown command error %d",
 					  cerr);
 		}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5d3df6c..94b37d1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -910,16 +910,9 @@ extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 /*
  * ata_eh_info helpers
  */
-#define ata_ehi_push_desc(ehi, fmt, args...) do { \
-	(ehi)->desc_len += scnprintf((ehi)->desc + (ehi)->desc_len, \
-				     ATA_EH_DESC_LEN - (ehi)->desc_len, \
-				     fmt , ##args); \
-} while (0)
-
-#define ata_ehi_clear_desc(ehi) do { \
-	(ehi)->desc[0] = '\0'; \
-	(ehi)->desc_len = 0; \
-} while (0)
+extern void __ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...);
+extern void ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...);
+extern void ata_ehi_clear_desc(struct ata_eh_info *ehi);
 
 static inline void __ata_ehi_hotplugged(struct ata_eh_info *ehi)
 {
-- 
1.5.0.3


