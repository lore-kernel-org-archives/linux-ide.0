From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/13] libata-hp: implement ata_eh_detach_dev()
Date: Mon, 29 May 2006 15:38:55 +0900
Message-ID: <1148884735680-git-send-email-htejun@gmail.com>
References: <11488847352050-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:36544 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751295AbWE2GjI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:39:08 -0400
Received: by wr-out-0506.google.com with SMTP id i7so819183wra
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:39:07 -0700 (PDT)
In-Reply-To: <11488847352050-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_eh_detach_dev().  This function is responsible for
detaching an ATA device and offlining the associated SCSI device
atomically so that the detached device is not accessed after ATA
detach is complete.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c   |   28 ++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |   24 ++++++++++++++++++++++++
 drivers/scsi/libata.h      |    1 +
 3 files changed, 53 insertions(+), 0 deletions(-)

f42d6c9dfcfd3f3f720b2bee67ab83046ae9e855
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 4189bb4..695375b 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -629,6 +629,34 @@ void ata_eh_qc_retry(struct ata_queued_c
 }
 
 /**
+ *	ata_eh_detach_dev - detach ATA device
+ *	@dev: ATA device to detach
+ *
+ *	Detach @dev.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_eh_detach_dev(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->ap;
+	unsigned long flags;
+
+	ata_dev_disable(dev);
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	dev->flags &= ~ATA_DFLAG_DETACH;
+
+	if (ata_scsi_offline_dev(dev)) {
+		dev->flags |= ATA_DFLAG_DETACHED;
+		ap->flags |= ATA_FLAG_SCSI_HOTPLUG;
+	}
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
+/**
  *	ata_eh_about_to_do - about to perform eh_action
  *	@ap: target ATA port
  *	@action: action about to be performed
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index a1caf3f..acfa26c 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2762,3 +2762,27 @@ void ata_scsi_scan_host(struct ata_port 
 		}
 	}
 }
+
+/**
+ *	ata_scsi_offline_dev - offline attached SCSI device
+ *	@dev: ATA device to offline attached SCSI device for
+ *
+ *	This function is called from ata_eh_hotplug() and responsible
+ *	for taking the SCSI device attached to @dev offline.  This
+ *	function is called with host_set lock which protects dev->sdev
+ *	against clearing.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	1 if attached SCSI device exists, 0 otherwise.
+ */
+int ata_scsi_offline_dev(struct ata_device *dev)
+{
+	if (dev->sdev) {
+		scsi_device_set_state(dev->sdev, SDEV_OFFLINE);
+		return 1;
+	}
+	return 0;
+}
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index e3f7406..15628b8 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -75,6 +75,7 @@ extern int ata_cmd_ioctl(struct scsi_dev
 extern struct scsi_transport_template ata_scsi_transport_template;
 
 extern void ata_scsi_scan_host(struct ata_port *ap);
+extern int ata_scsi_offline_dev(struct ata_device *dev);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
 
-- 
1.3.2


