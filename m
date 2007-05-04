From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] libata: implement libata.spindown_compat
Date: Fri, 04 May 2007 21:28:48 +0200
Message-ID: <463B8970.9070105@gmail.com>
References: <463B88EC.1080304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:21813 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423073AbXEDT3C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 15:29:02 -0400
Received: by nz-out-0506.google.com with SMTP id o1so967477nzf
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 12:29:02 -0700 (PDT)
In-Reply-To: <463B88EC.1080304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <lkml@rtr.ca>, hancockr@shaw.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Stephen.Clark@seclark.us, fabio.comolli@gmail.com, a.p.zijlstra@chello.nl

Now that libata uses sd->manage_start_stop, libata spins down disk on
shutdown.  In an attempt to compensate libata's previous shortcoming,
some distros sync and spin down disks attached via libata in their
shutdown(8).  Some disks spin back up just to spin down again on
STANDBYNOW1 if the command is issued when the disk is spun down, so
this double spinning down causes problem.

This patch implements module parameter libata.spindown_compat which,
when set to one (default value), prevents libata from spinning down
disks on shutdown thus avoiding double spinning down.  Note that
libata spins down disks for suspend to mem and disk, so with
libata.spindown_compat set to one, disks should be properly spun down
in all cases without modifying shutdown(8).

shutdown(8) should be fixed eventually.  Some drive do spin up on
SYNCHRONZE_CACHE even when their cache is clean.  Those disks
currently spin up briefly when sd tries to shutdown the device and
then the machine powers off immediately, which can't be good for the
head.  We can't skip SYNCHRONIZE_CACHE during shudown as it can be
dangerous data integrity-wise.

So, this spindown_compat parameter is already scheduled for removal by
the end of the next year and here's what shutdown(8) should do.

  * Check whether /sys/modules/libata/parameters/spindown_compat
    exists.  If it does, write 0 to it.

  * For each libata harddisk {
	* Check whether /sys/class/scsi_disk/h:c:i:l/manage_start_stop
	  exists.  Iff it doesn't, synchronize cache and spin the disk
	  down as before.
  }

The above procedure will make shutdown(8) work properly with kernels
before this change, ones with this workaround and later ones without
it.

To accelerate shutdown(8) updates, if the compat mode is in use, this
patch prints BIG FAT warning for five seconds during shutdown (the
optimal interval to annoy the user just the right amount discovered by
hours of tireless usability testing).

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 Documentation/feature-removal-schedule.txt |   19 +++++++++++++++++++
 drivers/ata/libata-core.c                  |    6 ++++++
 drivers/ata/libata-scsi.c                  |   28 +++++++++++++++++++++++++++-
 drivers/ata/libata.h                       |    1 +
 4 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 5c88ba1..78b3aa6 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -314,3 +314,22 @@ Why:	Code was merged, then submitter imm
 Who:	David S. Miller <davem@davemloft.net>
 
 ---------------------------
+
+What:	libata.spindown_compat module parameter
+When:	Dec 2008
+Why:	halt(8) synchronizes caches for and spins down libata disks
+	because libata didn't use to spin down disk on system halt
+	(only synchronized caches).
+	Spin down on system halt is now implemented and can be tested
+	using sysfs node /sys/class/scsi_disk/h:c:i:l/manage_start_stop.
+	Because issuing spin down command to an already spun down disk
+	makes some disks spin up just to spin down again, the old
+	behavior needs to be maintained till userspace tool is updated
+	to check the sysfs node and not to spin down disks with the
+	node set to one.
+	This module parameter is to give userspace tool the time to
+	get updated and should be removed after userspace is
+	reasonably updated.
+Who:	Tejun Heo <htejun@gmail.com>
+
+---------------------------
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ce5e080..4a81549 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -101,6 +101,12 @@ int libata_noacpi = 1;
 module_param_named(noacpi, libata_noacpi, int, 0444);
 MODULE_PARM_DESC(noacpi, "Disables the use of ACPI in suspend/resume when set");
 
+int ata_spindown_compat = 1;
+module_param_named(spindown_compat, ata_spindown_compat, int, 0644);
+MODULE_PARM_DESC(spindown_compat, "Enable backward compatible spindown "
+		 "behavior.  Will be removed.  More info can be found in "
+		 "Documentation/feature-removal-schedule.txt\n");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8f80019..dd81fa7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -944,9 +944,35 @@ static unsigned int ata_scsi_start_stop_
 		}
 
 		tf->command = ATA_CMD_VERIFY;	/* READ VERIFY */
-	} else
+	} else {
+		/* XXX: This is for backward compatibility, will be
+		 * removed.  Read Documentation/feature-removal-schedule.txt
+		 * for more info.
+		 */
+		if (ata_spindown_compat &&
+		    (system_state == SYSTEM_HALT ||
+		     system_state == SYSTEM_POWER_OFF)) {
+			static int warned = 0;
+
+			if (!warned) {
+				spin_unlock_irq(qc->ap->lock);
+				ata_dev_printk(qc->dev, KERN_WARNING,
+					"DISK MIGHT NOT BE SPUN DOWN PROPERLY. "
+					"UPDATE SHUTDOWN UTILITY\n");
+				ata_dev_printk(qc->dev, KERN_WARNING,
+					"For more info, visit "
+					"http://linux-ata.org/shutdown.html\n");
+				warned = 1;
+				ssleep(5);
+				spin_lock_irq(qc->ap->lock);
+			}
+			scmd->result = SAM_STAT_GOOD;
+			return 1;
+		}
+
 		/* Issue ATA STANDBY IMMEDIATE command */
 		tf->command = ATA_CMD_STANDBYNOW1;
+	}
 
 	/*
 	 * Standby and Idle condition timers could be implemented but that
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5f4d40c..316bf8a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -58,6 +58,7 @@ extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
 extern int libata_noacpi;
+extern int ata_spindown_compat;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
-- 
1.4.3.4

