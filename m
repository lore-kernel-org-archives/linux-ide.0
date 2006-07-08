From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/17] libata-link: implement ata_link_abort()
Date: Sat, 8 Jul 2006 14:45:37 +0900
Message-ID: <1152337537226-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:42863 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932524AbWGHFox (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:53 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484118wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:52 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_link_abort().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   50 ++++++++++++++++++++++++++++++++------------
 include/linux/libata.h     |    1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

1b09612fdc4030df0d6645b1307c5a144511d15b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 95488ea..25bc6d7 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -6166,6 +6166,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_device_resume
 
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
+EXPORT_SYMBOL_GPL(ata_link_abort);
 EXPORT_SYMBOL_GPL(ata_port_abort);
 EXPORT_SYMBOL_GPL(ata_port_freeze);
 EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index db6e132..7b4a7d8 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -539,19 +539,7 @@ void ata_port_schedule_eh(struct ata_por
 	DPRINTK("port EH scheduled\n");
 }
 
-/**
- *	ata_port_abort - abort all qc's on the port
- *	@ap: ATA port to abort qc's for
- *
- *	Abort all active qc's of @ap and schedule EH.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- *
- *	RETURNS:
- *	Number of aborted qc's.
- */
-int ata_port_abort(struct ata_port *ap)
+static int ata_do_link_abort(struct ata_port *ap, struct ata_link *link)
 {
 	int tag, nr_aborted = 0;
 
@@ -560,7 +548,7 @@ int ata_port_abort(struct ata_port *ap)
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
 
-		if (qc) {
+		if (qc && (!link || qc->dev->link == link)) {
 			qc->flags |= ATA_QCFLAG_FAILED;
 			ata_qc_complete(qc);
 			nr_aborted++;
@@ -574,6 +562,40 @@ int ata_port_abort(struct ata_port *ap)
 }
 
 /**
+ *	ata_link_abort - abort all qc's on the link
+ *	@link: ATA link to abort qc's for
+ *
+ *	Abort all active qc's active on @link and schedule EH.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
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
index b24f21d..7d09ccc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -844,6 +844,7 @@ #endif /* CONFIG_PCI */
 extern void ata_eng_timeout(struct ata_port *ap);
 
 extern void ata_port_schedule_eh(struct ata_port *ap);
+extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
 
-- 
1.3.2


