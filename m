From: Tejun Heo <tj@kernel.org>
Subject: [PATCH upstream] libata: remove spindown skipping and warning
Date: Fri, 03 Jul 2009 11:46:12 +0900
Message-ID: <4A4D70F4.5010909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44103 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbZGCCrM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Jul 2009 22:47:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, jaswinder@kernel.org

This was a hack to give userland shutdown tools time to drop manual
spindown.  All popular distros updated quite some time ago and the due
is well passed.  Drop it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>
---
 Documentation/feature-removal-schedule.txt |   18 ----------
 drivers/ata/libata-scsi.c                  |   51 -----------------------------
 include/linux/libata.h                     |    1 
 3 files changed, 70 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index de491a3..519c881 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -192,24 +192,6 @@ Who:	Len Brown <len.brown@intel.com>
 
 ---------------------------
 
-What: libata spindown skipping and warning
-When: Dec 2008
-Why:  Some halt(8) implementations synchronize caches for and spin
-      down libata disks because libata didn't use to spin down disk on
-      system halt (only synchronized caches).
-      Spin down on system halt is now implemented.  sysfs node
-      /sys/class/scsi_disk/h:c:i:l/manage_start_stop is present if
-      spin down support is available.
-      Because issuing spin down command to an already spun down disk
-      makes some disks spin up just to spin down again, libata tracks
-      device spindown status to skip the extra spindown command and
-      warn about it.
-      This is to give userspace tools the time to get updated and will
-      be removed after userspace is reasonably updated.
-Who:  Tejun Heo <htejun@gmail.com>
-
----------------------------
-
 What:	i386/x86_64 bzImage symlinks
 When:	April 2010
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3423160..56f4b3b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1257,23 +1257,6 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 	return queue_depth;
 }
 
-/* XXX: for spindown warning */
-static void ata_delayed_done_timerfn(unsigned long arg)
-{
-	struct scsi_cmnd *scmd = (void *)arg;
-
-	scmd->scsi_done(scmd);
-}
-
-/* XXX: for spindown warning */
-static void ata_delayed_done(struct scsi_cmnd *scmd)
-{
-	static struct timer_list timer;
-
-	setup_timer(&timer, ata_delayed_done_timerfn, (unsigned long)scmd);
-	mod_timer(&timer, jiffies + 5 * HZ);
-}
-
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
@@ -1338,32 +1321,6 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 		     system_entering_hibernation())
 			goto skip;
 
-		/* XXX: This is for backward compatibility, will be
-		 * removed.  Read Documentation/feature-removal-schedule.txt
-		 * for more info.
-		 */
-		if ((qc->dev->flags & ATA_DFLAG_SPUNDOWN) &&
-		    (system_state == SYSTEM_HALT ||
-		     system_state == SYSTEM_POWER_OFF)) {
-			static unsigned long warned;
-
-			if (!test_and_set_bit(0, &warned)) {
-				ata_dev_printk(qc->dev, KERN_WARNING,
-					"DISK MIGHT NOT BE SPUN DOWN PROPERLY. "
-					"UPDATE SHUTDOWN UTILITY\n");
-				ata_dev_printk(qc->dev, KERN_WARNING,
-					"For more info, visit "
-					"http://linux-ata.org/shutdown.html\n");
-
-				/* ->scsi_done is not used, use it for
-				 * delayed completion.
-				 */
-				scmd->scsi_done = qc->scsidone;
-				qc->scsidone = ata_delayed_done;
-			}
-			goto skip;
-		}
-
 		/* Issue ATA STANDBY IMMEDIATE command */
 		tf->command = ATA_CMD_STANDBYNOW1;
 	}
@@ -1764,14 +1721,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 		}
 	}
 
-	/* XXX: track spindown state for spindown skipping and warning */
-	if (unlikely(qc->tf.command == ATA_CMD_STANDBY ||
-		     qc->tf.command == ATA_CMD_STANDBYNOW1))
-		qc->dev->flags |= ATA_DFLAG_SPUNDOWN;
-	else if (likely(system_state != SYSTEM_HALT &&
-			system_state != SYSTEM_POWER_OFF))
-		qc->dev->flags &= ~ATA_DFLAG_SPUNDOWN;
-
 	if (need_sense && !ap->ops->error_handler)
 		ata_dump_status(ap->print_id, &qc->result_tf);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3d501db..36b5470 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -143,7 +143,6 @@ enum {
 
 	ATA_DFLAG_PIO		= (1 << 12), /* device limited to PIO mode */
 	ATA_DFLAG_NCQ_OFF	= (1 << 13), /* device limited to non-NCQ mode */
-	ATA_DFLAG_SPUNDOWN	= (1 << 14), /* XXX: for spindown_compat */
 	ATA_DFLAG_SLEEPING	= (1 << 15), /* device is sleeping */
 	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
 	ATA_DFLAG_NO_UNLOAD	= (1 << 17), /* device doesn't support unload */
