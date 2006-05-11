From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/7] libata-pm-prep: add HRST_TO_RESUME and implement resume action helpers
Date: Fri, 12 May 2006 01:37:51 +0900
Message-ID: <11473654713185-git-send-email-htejun@gmail.com>
References: <11473654703440-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:50067 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030337AbWEKQiD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:38:03 -0400
Received: by wr-out-0506.google.com with SMTP id i12so407142wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:38:03 -0700 (PDT)
In-Reply-To: <11473654703440-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Some PM needs hardreset to resume link.  Add ATA_LFLAG_HRST_TO_RESUME
to mark such links and separate out ata_link_resume_action() such that
the test can be done in one place and, while at it, separate out
ata_link_init_probe() which sets resume action and probe mask from
ata_device_add().  These resume/probing related helpers will be used
by PM.

---

 drivers/scsi/libata-core.c |    7 +------
 drivers/scsi/libata-eh.c   |    6 +++---
 drivers/scsi/libata-scsi.c |    4 ++--
 include/linux/libata.h     |   17 +++++++++++++++++
 4 files changed, 23 insertions(+), 11 deletions(-)

b23bfeecdddff57fd54e62193ae8b05e88729c63
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fb64a0f..148d84d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5472,14 +5472,9 @@ int ata_device_add(const struct ata_prob
 			ata_port_probe(ap);
 
 			spin_lock_irqsave(&ap->host_set->lock, flags);
-
-			ap->link.eh_info.probe_mask =
-				(1 << ata_link_max_devices(&ap->link)) - 1;
-			ap->link.eh_info.action |= ATA_EH_SOFTRESET;
-
 			set_bit(bit, &ap->flags);
+			ata_link_init_probe(&ap->link);
 			ata_port_schedule_eh(ap);
-
 			spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 			wait_on_bit(&ap->flags, bit, ata_boot_probe_wait,
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index ffbd028..d62a529 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -941,7 +941,7 @@ static void ata_eh_analyze_serror(struct
 	}
 	if (serror & (SERR_PHYRDY_CHG | SERR_DEV_XCHG)) {
 		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_HARDRESET;
+		action |= ata_link_resume_action(link);
 		ehc->i.probe_mask |= 1;
 	}
 
@@ -1695,7 +1695,7 @@ int ata_eh_recover(struct ata_port *ap, 
 				ata_eh_detach_dev(dev);
 				ata_dev_init(dev);
 				ehc->did_probe_mask |= (1 << dev->devno);
-				ehc->i.action |= ATA_EH_SOFTRESET;
+				ehc->i.action |= ata_link_resume_action(link);
 			}
 		}
 	}
@@ -1805,7 +1805,7 @@ int ata_eh_recover(struct ata_port *ap, 
 
 			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 			ehc->did_probe_mask |= (1 << dev->devno);
-			ehc->i.action |= ATA_EH_SOFTRESET;
+			ehc->i.action |= ata_link_resume_action(link);
 		}
 	} else {
 		/* soft didn't work?  be haaaaard */
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 9589013..de40b80 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2903,7 +2903,7 @@ static int ata_scsi_user_scan(struct Scs
 		ata_port_for_each_link(link, ap) {
 			link->eh_info.probe_mask |=
 				(1 << ata_link_max_devices(link)) - 1;
-			link->eh_info.action |= ATA_EH_SOFTRESET;
+			link->eh_info.action |= ata_link_resume_action(link);
 		}
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, id);
@@ -2911,7 +2911,7 @@ static int ata_scsi_user_scan(struct Scs
 		if (dev) {
 			link = dev->link;
 			link->eh_info.probe_mask |= 1 << dev->devno;
-			link->eh_info.action |= ATA_EH_SOFTRESET;
+			link->eh_info.action |= ata_link_resume_action(link);
 		} else
 			rc = -EINVAL;
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index df78f3e..bbfd176 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -143,6 +143,9 @@ enum {
 
 	ATA_DEV_ERING_SIZE	= 32,	/* record 32 recent errors */
 
+	/* struct ata_link flags */
+	ATA_LFLAG_HRST_TO_RESUME = (1 << 0), /* hardreset needed to resume */
+
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
@@ -934,6 +937,20 @@ static inline int ata_link_max_devices(c
 	return 1;
 }
 
+static inline unsigned int ata_link_resume_action(struct ata_link *link)
+{
+	if (link->flags & ATA_LFLAG_HRST_TO_RESUME)
+		return ATA_EH_HARDRESET;
+	return ATA_EH_SOFTRESET;
+}
+
+static inline void ata_link_init_probe(struct ata_link *link)
+{
+	link->eh_info.probe_mask = (1 << ata_link_max_devices(link)) - 1;
+	link->eh_info.action = ata_link_resume_action(link);
+	link->eh_context.i = link->eh_info;
+}
+
 static inline int ata_link_active(struct ata_link *link)
 {
 	return ata_tag_valid(link->active_tag) || link->sactive;
-- 
1.2.4


