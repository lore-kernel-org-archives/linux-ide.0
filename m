From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: remove libata.spindown_compat
Date: Thu, 17 May 2007 16:43:26 +0200
Message-ID: <464C6A0E.7020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:45683 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbXEQOoC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 10:44:02 -0400
Received: by nz-out-0506.google.com with SMTP id r28so977992nza
        for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 07:44:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Daniel Drake <dsd@gentoo.org>, Francesco Pretto <ceztko@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, hmh@hmh.eng.br, pkg-sysvinit-devel@lists.alioth.debian.orgpkg-sysvinit-devel@lists.alioth.debian.org

With STANDBYDOWN tracking added, libata.spindown_compat isn't
necessary anymore.  If userspace shutdown(8) issues STANDBYNOW, libata
warns.  If userspace shutdown(8) doesn't issue STANDBYNOW, libata does
the right thing.  Userspace can tell whether kernel supports spindown
by testing whether sysfs node manage_start_stop exists as before.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

As many distros don't do anything to libata devices on shutdown which
means we can avoid a lot of trouble by tracking spindown status (done)
and which, in turn, obsoletes libata.spindown_compat.  I should have
researched better before staring this mess.  Sorry but the situation
is much better now.  :-)

I'll attach the updated version of http://linux-ata.org/shutdown.html
as a reply to this mail.

If you find any problem in the updated scheme, please let me know.

Thanks.

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 498ff31..5c8695a 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -328,21 +328,20 @@ Who:   Adrian Bunk <bunk@stusta.de>
 
 ---------------------------
 
-What: libata.spindown_compat module parameter
+What: libata spindown skipping and warning
 When: Dec 2008
-Why:  halt(8) synchronizes caches for and spins down libata disks
-      because libata didn't use to spin down disk on system halt
-      (only synchronized caches).
-      Spin down on system halt is now implemented and can be tested
-      using sysfs node /sys/class/scsi_disk/h:c:i:l/manage_start_stop.
+Why:  Some halt(8) implementations synchronize caches for and spin
+      down libata disks because libata didn't use to spin down disk on
+      system halt (only synchronized caches).
+      Spin down on system halt is now implemented.  sysfs node
+      /sys/class/scsi_disk/h:c:i:l/manage_start_stop is present if
+      spin down support is available.
       Because issuing spin down command to an already spun down disk
-      makes some disks spin up just to spin down again, the old
-      behavior needs to be maintained till userspace tool is updated
-      to check the sysfs node and not to spin down disks with the
-      node set to one.
-      This module parameter is to give userspace tool the time to
-      get updated and should be removed after userspace is
-      reasonably updated.
+      makes some disks spin up just to spin down again, libata tracks
+      device spindown status to skip the extra spindown command and
+      warn about it.
+      This is to give userspace tools the time to get updated and will
+      be removed after userspace is reasonably updated.
 Who:  Tejun Heo <htejun@gmail.com>
 
 ---------------------------
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d5939e6..d3ea7f5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -101,12 +101,6 @@ int libata_noacpi = 1;
 module_param_named(noacpi, libata_noacpi, int, 0444);
 MODULE_PARM_DESC(noacpi, "Disables the use of ACPI in suspend/resume when set");
 
-int ata_spindown_compat = 1;
-module_param_named(spindown_compat, ata_spindown_compat, int, 0644);
-MODULE_PARM_DESC(spindown_compat, "Enable backward compatible spindown "
-		 "behavior.  Will be removed.  More info can be found in "
-		 "Documentation/feature-removal-schedule.txt\n");
-
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b6a1de8..242c43e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -893,7 +893,7 @@ int ata_scsi_change_queue_depth(struct s
 	return queue_depth;
 }
 
-/* XXX: for ata_spindown_compat */
+/* XXX: for spindown warning */
 static void ata_delayed_done_timerfn(unsigned long arg)
 {
 	struct scsi_cmnd *scmd = (void *)arg;
@@ -901,7 +901,7 @@ static void ata_delayed_done_timerfn(uns
 	scmd->scsi_done(scmd);
 }
 
-/* XXX: for ata_spindown_compat */
+/* XXX: for spindown warning */
 static void ata_delayed_done(struct scsi_cmnd *scmd)
 {
 	static struct timer_list timer;
@@ -966,8 +966,7 @@ static unsigned int ata_scsi_start_stop_
 		 * removed.  Read Documentation/feature-removal-schedule.txt
 		 * for more info.
 		 */
-		if (ata_spindown_compat &&
-		    (qc->dev->flags & ATA_DFLAG_SPUNDOWN) &&
+		if ((qc->dev->flags & ATA_DFLAG_SPUNDOWN) &&
 		    (system_state == SYSTEM_HALT ||
 		     system_state == SYSTEM_POWER_OFF)) {
 			static unsigned long warned = 0;
@@ -1395,7 +1394,7 @@ static void ata_scsi_qc_complete(struct
 		}
 	}
 
-	/* XXX: track spindown state for spindown_compat */
+	/* XXX: track spindown state for spindown skipping and warning */
 	if (unlikely(qc->tf.command == ATA_CMD_STANDBY ||
 		     qc->tf.command == ATA_CMD_STANDBYNOW1))
 		qc->dev->flags |= ATA_DFLAG_SPUNDOWN;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 13cb0c9..5e24666 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -58,7 +58,6 @@ extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
 extern int libata_noacpi;
-extern int ata_spindown_compat;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
