From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/16] libata-link: implement ata_link_abort()
Date: Sun, 1 Jul 2007 19:06:00 +0900
Message-ID: <11832843603742-git-send-email-htejun@gmail.com>
References: <11832843581399-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:51779 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbXGAKGK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:06:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879666wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:06:10 -0700 (PDT)
In-Reply-To: <11832843581399-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_link_abort().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 drivers/ata/libata-eh.c   |   50 ++++++++++++++++++++++++++++++++------------
 include/linux/libata.h    |    1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dbcfe81..84edb5a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6978,6 +6978,7 @@ EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
+EXPORT_SYMBOL_GPL(ata_link_abort);
 EXPORT_SYMBOL_GPL(ata_port_abort);
 EXPORT_SYMBOL_GPL(ata_port_freeze);
 EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 6581222..2e0e11b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -654,19 +654,7 @@ void ata_port_schedule_eh(struct ata_port *ap)
 	DPRINTK("port EH scheduled\n");
 }
 
-/**
- *	ata_port_abort - abort all qc's on the port
- *	@ap: ATA port to abort qc's for
- *
- *	Abort all active qc's of @ap and schedule EH.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	Number of aborted qc's.
- */
-int ata_port_abort(struct ata_port *ap)
+static int ata_do_link_abort(struct ata_port *ap, struct ata_link *link)
 {
 	int tag, nr_aborted = 0;
 
@@ -678,7 +666,7 @@ int ata_port_abort(struct ata_port *ap)
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
 
-		if (qc) {
+		if (qc && (!link || qc->dev->link == link)) {
 			qc->flags |= ATA_QCFLAG_FAILED;
 			ata_qc_complete(qc);
 			nr_aborted++;
@@ -692,6 +680,40 @@ int ata_port_abort(struct ata_port *ap)
 }
 
 /**
+ *	ata_link_abort - abort all qc's on the link
+ *	@link: ATA link to abort qc's for
+ *
+ *	Abort all active qc's active on @link and schedule EH.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	Number of aborted qc's.
+ */
+int ata_link_abort(struct ata_link *link)
+{
+	return ata_do_link_abort(link->ap, link);
+}
+
+/**
+ *	ata_port_abort - abort all qc's on the port
+ *	@ap: ATA port to abort qc's for
+ *
+ *	Abort all active qc's of @ap and schedule EH.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Number of aborted qc's.
+ */
+int ata_port_abort(struct ata_port *ap)
+{
+	return ata_do_link_abort(ap, NULL);
+}
+
+/**
  *	__ata_port_freeze - freeze port
  *	@ap: ATA port to freeze
  *
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c96330c..5dfa5c5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -901,6 +901,7 @@ extern unsigned long ata_pci_default_filter(struct ata_device *, unsigned long);
 extern void ata_eng_timeout(struct ata_port *ap);
 
 extern void ata_port_schedule_eh(struct ata_port *ap);
+extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
 
-- 
1.5.0.3


