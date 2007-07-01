From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata: update EH report formatting
Date: Sun, 1 Jul 2007 18:53:36 +0900
Message-ID: <1183283616149-git-send-email-htejun@gmail.com>
References: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:10168 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375AbXGAJxn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:43 -0400
Received: by py-out-1112.google.com with SMTP id u77so2074401pyb
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:42 -0700 (PDT)
In-Reply-To: <118328361627-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Update formatting for LLD provided error descriptions such that...

* No default () around it
* Each element is separated by <> not ,

This change makes each element responsible for putting a space after
itself instead of before - e.g. "<elem> " not ", elem".  This is more
conventional and allows more flexible combination of messages.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c          |    8 ++++----
 drivers/ata/libata-core.c   |    2 +-
 drivers/ata/libata-eh.c     |    4 ++--
 drivers/ata/sata_inic162x.c |    2 +-
 drivers/ata/sata_nv.c       |   19 ++++++++++---------
 drivers/ata/sata_promise.c  |    2 +-
 drivers/ata/sata_sil24.c    |   10 +++++-----
 7 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b14e7ef..ff0b70d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1197,7 +1197,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	ahci_scr_write(ap, SCR_ERROR, serror);
 
 	/* analyze @irq_stat */
-	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
+	ata_ehi_push_desc(ehi, "irq_stat 0x%08x ", irq_stat);
 
 	/* some controllers set IRQ_IF_ERR on device errors, ignore it */
 	if (ap->flags & AHCI_FLAG_IGN_IRQ_IF_ERR)
@@ -1217,12 +1217,12 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	if (irq_stat & PORT_IRQ_IF_ERR) {
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_SOFTRESET;
-		ata_ehi_push_desc(ehi, ", interface fatal error");
+		ata_ehi_push_desc(ehi, "<interface fatal error> ");
 	}
 
 	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
 		ata_ehi_hotplugged(ehi);
-		ata_ehi_push_desc(ehi, ", %s", irq_stat & PORT_IRQ_CONNECT ?
+		ata_ehi_push_desc(ehi, "<%s> ", irq_stat & PORT_IRQ_CONNECT ?
 			"connection status changed" : "PHY RDY changed");
 	}
 
@@ -1231,7 +1231,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 		err_mask |= AC_ERR_HSM;
 		action |= ATA_EH_SOFTRESET;
-		ata_ehi_push_desc(ehi, ", unknown FIS %08x %08x %08x %08x",
+		ata_ehi_push_desc(ehi, "<unknown FIS %08x %08x %08x %08x> ",
 				  unk[0], unk[1], unk[2], unk[3]);
 	}
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e5364af..8570975 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5581,7 +5581,7 @@ inline unsigned int ata_host_intr (struct ata_port *ap,
 
 	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
 				       qc->tf.protocol == ATA_PROT_ATAPI_DMA))
-		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
+		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x ", host_stat);
 
 	return 1;	/* irq handled */
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9ee0a8c..744665a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1524,14 +1524,14 @@ static void ata_eh_report(struct ata_port *ap)
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
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index e8525d7..4f1fc28 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -310,7 +310,7 @@ static void inic_host_intr(struct ata_port *ap)
 	}
 
 	/* error */
-	ata_ehi_push_desc(ehi, "irq_stat=0x%x", irq_stat);
+	ata_ehi_push_desc(ehi, "irq_stat=0x%x ", irq_stat);
 
 	if (irq_stat & (PIRQ_OFFLINE | PIRQ_ONLINE)) {
 		ata_ehi_hotplugged(ehi);
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index adfa693..e9701c7 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -714,19 +714,20 @@ static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 		int freeze = 0;
 
 		ata_ehi_clear_desc(ehi);
-		ata_ehi_push_desc(ehi, "CPB resp_flags 0x%x", flags );
+		ata_ehi_push_desc(ehi, "<CPB resp_flags 0x%x", flags );
 		if (flags & NV_CPB_RESP_ATA_ERR) {
-			ata_ehi_push_desc(ehi, ": ATA error");
+			ata_ehi_push_desc(ehi, ": ATA error> ");
 			ehi->err_mask |= AC_ERR_DEV;
 		} else if (flags & NV_CPB_RESP_CMD_ERR) {
-			ata_ehi_push_desc(ehi, ": CMD error");
+			ata_ehi_push_desc(ehi, ": CMD error> ");
 			ehi->err_mask |= AC_ERR_DEV;
 		} else if (flags & NV_CPB_RESP_CPB_ERR) {
-			ata_ehi_push_desc(ehi, ": CPB error");
+			ata_ehi_push_desc(ehi, ": CPB error> ");
 			ehi->err_mask |= AC_ERR_SYSTEM;
 			freeze = 1;
 		} else {
 			/* notifier error, but no error in CPB flags? */
+			ata_ehi_push_desc(ehi, ": unknown> ");
 			ehi->err_mask |= AC_ERR_OTHER;
 			freeze = 1;
 		}
@@ -853,19 +854,19 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 				struct ata_eh_info *ehi = &ap->eh_info;
 
 				ata_ehi_clear_desc(ehi);
-				ata_ehi_push_desc(ehi, "ADMA status 0x%08x", status );
+				ata_ehi_push_desc(ehi, "<ADMA status 0x%08x", status );
 				if (status & NV_ADMA_STAT_TIMEOUT) {
 					ehi->err_mask |= AC_ERR_SYSTEM;
-					ata_ehi_push_desc(ehi, ": timeout");
+					ata_ehi_push_desc(ehi, ": timeout> ");
 				} else if (status & NV_ADMA_STAT_HOTPLUG) {
 					ata_ehi_hotplugged(ehi);
-					ata_ehi_push_desc(ehi, ": hotplug");
+					ata_ehi_push_desc(ehi, ": hotplug> ");
 				} else if (status & NV_ADMA_STAT_HOTUNPLUG) {
 					ata_ehi_hotplugged(ehi);
-					ata_ehi_push_desc(ehi, ": hot unplug");
+					ata_ehi_push_desc(ehi, ": hot unplug> ");
 				} else if (status & NV_ADMA_STAT_SERROR) {
 					/* let libata analyze SError and figure out the cause */
-					ata_ehi_push_desc(ehi, ": SError");
+					ata_ehi_push_desc(ehi, ": SError> ");
 				}
 				ata_port_freeze(ap);
 				continue;
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 7fcc4fe..ff3d5c8 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -634,7 +634,7 @@ static void pdc_error_intr(struct ata_port *ap, struct ata_queued_cmd *qc,
 	unsigned int ac_err_mask = 0;
 
 	ata_ehi_clear_desc(ehi);
-	ata_ehi_push_desc(ehi, "port_status 0x%08x", port_status);
+	ata_ehi_push_desc(ehi, "port_status 0x%08x ", port_status);
 	port_status &= err_mask;
 
 	if (port_status & PDC_DRIVE_ERR)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 0ddfae9..23650f3 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -765,11 +765,11 @@ static void sil24_error_intr(struct ata_port *ap)
 	/* first, analyze and record host port events */
 	ata_ehi_clear_desc(ehi);
 
-	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
+	ata_ehi_push_desc(ehi, "irq_stat 0x%08x ", irq_stat);
 
 	if (irq_stat & (PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG)) {
 		ata_ehi_hotplugged(ehi);
-		ata_ehi_push_desc(ehi, ", %s",
+		ata_ehi_push_desc(ehi, "<%s> ",
 			       irq_stat & PORT_IRQ_PHYRDY_CHG ?
 			       "PHY RDY changed" : "device exchanged");
 		freeze = 1;
@@ -778,7 +778,7 @@ static void sil24_error_intr(struct ata_port *ap)
 	if (irq_stat & PORT_IRQ_UNK_FIS) {
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_SOFTRESET;
-		ata_ehi_push_desc(ehi , ", unknown FIS");
+		ata_ehi_push_desc(ehi, "<unknown FIS> ");
 		freeze = 1;
 	}
 
@@ -797,11 +797,11 @@ static void sil24_error_intr(struct ata_port *ap)
 		if (ci && ci->desc) {
 			err_mask |= ci->err_mask;
 			action |= ci->action;
-			ata_ehi_push_desc(ehi, ", %s", ci->desc);
+			ata_ehi_push_desc(ehi, "<%s> ", ci->desc);
 		} else {
 			err_mask |= AC_ERR_OTHER;
 			action |= ATA_EH_SOFTRESET;
-			ata_ehi_push_desc(ehi, ", unknown command error %d",
+			ata_ehi_push_desc(ehi, "<unknown command error %d> ",
 					  cerr);
 		}
 
-- 
1.5.0.3


