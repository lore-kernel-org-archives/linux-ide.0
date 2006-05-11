From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/14] libata-link: implement ata_link_abort()
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <114736502322-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:7196 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751867AbWEKQai (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:38 -0400
Received: by nf-out-0910.google.com with SMTP id c31so137568nfb
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:37 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_link_abort().

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   50 ++++++++++++++++++++++++++++++++------------
 include/linux/libata.h     |    1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

77f07c1fd4a3c534664d3591e941489d20d51b85
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 11405a4..740e831 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5864,6 +5864,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_device_resume
 
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
+EXPORT_SYMBOL_GPL(ata_link_abort);
 EXPORT_SYMBOL_GPL(ata_port_abort);
 EXPORT_SYMBOL_GPL(ata_port_freeze);
 EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 97a1b4d..1bd7d1e 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -453,19 +453,7 @@ void ata_port_schedule_eh(struct ata_por
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
 
@@ -474,7 +462,7 @@ int ata_port_abort(struct ata_port *ap)
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
 
-		if (qc) {
+		if (qc && (!link || qc->dev->link == link)) {
 			qc->flags |= ATA_QCFLAG_FAILED;
 			ata_qc_complete(qc);
 			nr_aborted++;
@@ -488,6 +476,40 @@ int ata_port_abort(struct ata_port *ap)
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
index 8feaf04..f31c979 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -776,6 +776,7 @@ extern unsigned long ata_pci_default_fil
 extern void ata_eng_timeout(struct ata_port *ap);
 
 extern void ata_port_schedule_eh(struct ata_port *ap);
+extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
 
-- 
1.2.4


