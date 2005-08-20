From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 02/02] libata: add host_set locking to ata_scsi_error()
Date: Sat, 20 Aug 2005 23:15:40 +0900 (KST)
Message-ID: <20050820141408.52DFBF95@htj.dyndns.org>
References: <20050820141408.62050C34@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.192]:6765 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751247AbVHTOQD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 10:16:03 -0400
Received: by wproxy.gmail.com with SMTP id i20so740466wra
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2005 07:16:00 -0700 (PDT)
In-Reply-To: <20050820141408.62050C34@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org

02_libata_add-locking-to-ata_scsi_error.patch

	SCSI EH can start before ata_qc_complete is completely
	complete.  so, latter part of ata_qc_complete can run
	side-by-side with ->eng_timeout(), interfering EH.

        This patch makes ata_scsi_error() to grab and release host_set
	lock before invoking ->eng_timeout().

	Note: host_failed decrementing and eh_cmd_q banging are moved
	above ->eng_timeout() invocation such that they're done while
	holding the lock.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 libata-scsi.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-08-20 22:34:02.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-08-20 23:13:40.000000000 +0900
@@ -373,12 +373,14 @@ int ata_scsi_slave_config(struct scsi_de
 
 int ata_scsi_error(struct Scsi_Host *host)
 {
-	struct ata_port *ap;
+	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
 
 	DPRINTK("ENTER\n");
 
-	ap = (struct ata_port *) &host->hostdata[0];
-	ap->ops->eng_timeout(ap);
+	/* The following locking ensures that we enter eng_timeout
+	 * after ata_qc_complete is complete.
+	 */
+	spin_lock_irq(&ap->host_set->lock);
 
 	/* TODO: this is per-command; when queueing is supported
 	 * this code will either change or move to a more
@@ -387,6 +389,10 @@ int ata_scsi_error(struct Scsi_Host *hos
 	host->host_failed--;
 	INIT_LIST_HEAD(&host->eh_cmd_q);
 
+	spin_unlock_irq(&ap->host_set->lock);
+
+	ap->ops->eng_timeout(ap);
+
 	DPRINTK("EXIT\n");
 	return 0;
 }

