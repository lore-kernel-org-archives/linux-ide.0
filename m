From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 02/09] NCQ: add timeout to ata_read_log_page()
Date: Mon, 27 Jun 2005 00:21:17 +0900 (KST)
Message-ID: <20050626152105.BA5CB434@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:50375 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261309AbVFZPVW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:22 -0400
Received: by zproxy.gmail.com with SMTP id i11so111281nzi
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:22 -0700 (PDT)
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

02_NCQ_add-timeout-to-ata_read_log_page.patch

	Some drives may lock up during read log page after NCQ
	failures (HD160JJ does), so we need to timeout
	ata_read_log_page().  This function adds timeout feature to
	ata_read_log_page().

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/ahci.c        |    2 +-
 drivers/scsi/libata-core.c |   35 ++++++++++++++++++++++++++++++++---
 include/linux/libata.h     |    2 +-
 3 files changed, 34 insertions(+), 5 deletions(-)

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-06-27 00:20:29.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-06-27 00:20:29.000000000 +0900
@@ -674,7 +674,7 @@ static void ahci_ncq_timeout(struct ata_
 		goto done;
 	}
 
-	if (ata_read_log_page(ap, 0, READ_LOG_SATA_NCQ_PAGE, buffer, 1)) {
+	if (ata_read_log_page(ap, 0, READ_LOG_SATA_NCQ_PAGE, buffer, 1, 0)) {
 		printk(KERN_ERR "ata%u: unable to read log page\n", ap->id);
 		goto out;
 	}
Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-27 00:20:29.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-27 00:20:29.000000000 +0900
@@ -1309,6 +1309,12 @@ err_out:
 	DPRINTK("EXIT, err\n");
 }
 
+static void ata_read_log_page_timeout(unsigned long data)
+{
+	struct completion *wait = (void *)data;
+	complete(wait);
+}
+
 /**
  *	ata_read_log_page - read a specific log page
  *	@ap: port on which device we wish to probe resides
@@ -1316,6 +1322,7 @@ err_out:
  *	@page: page to read
  *	@buffer: where to store the read data
  *	@sectors: how much data to read
+ *	@timeout: timeout in millisecs
  *
  *	After reading the device information page, we use several
  *	bits of information from it to initialize data structures
@@ -1328,10 +1335,11 @@ err_out:
  */
 
 int ata_read_log_page(struct ata_port *ap, unsigned int device, char page,
-		      char *buffer, unsigned int sectors)
+		      char *buffer, unsigned int sectors, unsigned int timeout)
 {
 	struct ata_device *dev = &ap->device[device];
 	DECLARE_COMPLETION(wait);
+	struct timer_list timer;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	int rc;
@@ -1355,15 +1363,36 @@ int ata_read_log_page(struct ata_port *a
 	qc->waiting = &wait;
 	qc->complete_fn = ata_qc_complete_noop;
 
+	if (timeout) {
+		init_timer(&timer);
+		timer.function = ata_read_log_page_timeout;
+		timer.data = (unsigned long)&wait;
+		timer.expires = jiffies + timeout * HZ / 1000;
+		add_timer(&timer);
+	}
+
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	rc = ata_qc_issue(qc);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	if (rc)
+	if (rc) {
+		if (timeout)
+			del_timer(&timer);
 		return -EIO;
+	}
 
 	wait_for_completion(&wait);
-	return 0;
+
+	if (timeout && !del_timer(&timer)) {
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		if (qc->waiting == &wait) {
+			ata_qc_complete(qc, 0);
+			rc = -ETIMEDOUT;
+		}
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	}
+
+	return rc;
 }
 
 /**
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-06-27 00:20:29.000000000 +0900
+++ work/include/linux/libata.h	2005-06-27 00:20:29.000000000 +0900
@@ -453,7 +453,7 @@ extern void ata_scsi_block_requests(stru
 extern void ata_scsi_unblock_requests(struct ata_port *);
 extern void ata_scsi_requeue(struct ata_queued_cmd *);
 extern int ata_read_log_page(struct ata_port *, unsigned int, char, char *,
-			     unsigned int);
+			     unsigned int, unsigned int);
 
 
 #ifdef CONFIG_PCI

