From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/15] libata-hp: connect ATA hotplug events to SCSI hotplug
Date: Tue, 11 Apr 2006 23:14:07 +0900
Message-ID: <11447648471621-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:7863 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751284AbWDKOOJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:09 -0400
Received: by pproxy.gmail.com with SMTP id i49so1396235pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:08 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Schedule SCSI plug/unplug operations from EH with appropriate hotplug
flags and run scsi hotplug from ata_hotplug_wq on EH completion.  On
host initialization, SCSI hotplug starts disabled until
ATA_HOTPLUG_RUNNING flag is set on boot probing completion.  This is
to avoid running multiple SCSI plug/unplug operations simultaneously.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    3 +++
 drivers/scsi/libata-eh.c   |   12 ++++++++++++
 include/linux/libata.h     |    1 +
 3 files changed, 16 insertions(+), 0 deletions(-)

dce4c2009a3abc3fa370b639feda83e09c96dc9c
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 85f0600..91a01ca 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4896,6 +4896,7 @@ static void ata_host_init(struct ata_por
 	ap->last_ctl = 0xFF;
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
+	INIT_WORK(&ap->hotplug_task, ata_eh_scsi_hotplug, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
@@ -5088,6 +5089,8 @@ int ata_device_add(const struct ata_prob
 		struct ata_port *ap = host_set->ports[i];
 
 		ata_scsi_scan_host(ap);
+		/* boot probe done, allow hotplugging */
+		ata_set_hotplug_flags(ap, ATA_HOTPLUG_RUNNING);
 	}
 
 	dev_set_drvdata(dev, host_set);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index ee46221..64edf48 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -240,6 +240,12 @@ int ata_scsi_error(struct Scsi_Host *hos
 	/* bookkeeping for hotplug */
 	ata_clr_hotplug_flags(ap, ATA_HOTPLUG_PROBE | ATA_HOTPLUG_DID_PROBE);
 
+	/* schedule SCSI hotplug if requested */
+	if (ap->hotplug_flags & ATA_HOTPLUG_RUNNING &&
+	    ap->hotplug_flags & (ATA_HOTPLUG_SCSI_PLUG |
+				 ATA_HOTPLUG_SCSI_UNPLUG))
+		queue_work(ata_hotplug_wq, &ap->hotplug_task);
+
 	DPRINTK("EXIT\n");
 	return 0;
 }
@@ -1434,6 +1440,9 @@ void ata_eh_hotplug(struct ata_port *ap)
 		dev->flags &= ~ATA_DFLAG_DETACH_ATA;
 		ata_scsi_offline_dev(ap, dev);
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		/* schedule SCSI unplug */
+		ata_set_hotplug_flags(ap, ATA_HOTPLUG_SCSI_UNPLUG);
 	}
 
 	/* probe requested? */
@@ -1530,4 +1539,7 @@ void ata_eh_scsi_hotplug(void *data)
 		ata_clr_hotplug_flags(ap, ATA_HOTPLUG_SCSI_PLUG);
 		ata_scsi_scan_host(ap);
 	}
+
+	/* schedule SCSI plug */
+	ata_set_hotplug_flags(ap, ATA_HOTPLUG_SCSI_PLUG);
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b9dd793..f145f0e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -482,6 +482,7 @@ struct ata_port {
 	struct list_head	eh_done_q;
 
 	unsigned long		hotplug_flags;
+	struct work_struct	hotplug_task;
 
 	void			*private_data;
 };
-- 
1.2.4


