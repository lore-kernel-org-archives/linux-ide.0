From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] libata kernel-doc fixes
Date: Tue, 1 Nov 2005 21:29:27 -0800
Message-ID: <20051101212927.6af151f3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:25771 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751510AbVKBFhR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 00:37:17 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 21:37:16 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix all reported kernel-doc errors in libata.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/scsi/libata-core.c |    4 ++--
 drivers/scsi/libata-scsi.c |    7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff -Naurp linux-2614-g4/drivers/scsi/libata-core.c~kdoc_libata linux-2614-g4/drivers/scsi/libata-core.c
--- linux-2614-g4/drivers/scsi/libata-core.c~kdoc_libata	2005-11-01 20:35:13.000000000 -0800
+++ linux-2614-g4/drivers/scsi/libata-core.c	2005-11-01 21:17:42.000000000 -0800
@@ -2620,7 +2620,7 @@ static int ata_sg_setup(struct ata_queue
 /**
  *	ata_poll_qc_complete - turn irq back on and finish qc
  *	@qc: Command to complete
- *	@drv_stat: ATA status register content
+ *	@err_mask: ATA status register content
  *
  *	LOCKING:
  *	None.  (grabs host lock)
@@ -3385,7 +3385,7 @@ void ata_qc_free(struct ata_queued_cmd *
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
- *	@drv_stat: ATA Status register contents
+ *	@err_mask: ATA Status register contents
  *
  *	Indicate to the mid and upper layers that an ATA
  *	command has completed, with either an ok or not-ok status.
diff -Naurp linux-2614-g4/drivers/scsi/libata-scsi.c~kdoc_libata linux-2614-g4/drivers/scsi/libata-scsi.c
--- linux-2614-g4/drivers/scsi/libata-scsi.c~kdoc_libata	2005-11-01 20:35:13.000000000 -0800
+++ linux-2614-g4/drivers/scsi/libata-scsi.c	2005-11-01 21:20:46.000000000 -0800
@@ -131,7 +131,7 @@ int ata_std_bios_param(struct scsi_devic
 
 /**
  *	ata_cmd_ioctl - Handler for HDIO_DRIVE_CMD ioctl
- *	@dev: Device to whom we are issuing command
+ *	@scsidev: Device to which we are issuing command
  *	@arg: User provided data for issuing command
  *
  *	LOCKING:
@@ -217,7 +217,7 @@ error:
 
 /**
  *	ata_task_ioctl - Handler for HDIO_DRIVE_TASK ioctl
- *	@dev: Device to whom we are issuing command
+ *	@scsidev: Device to which we are issuing command
  *	@arg: User provided data for issuing command
  *
  *	LOCKING:
@@ -416,6 +416,7 @@ void ata_dump_status(unsigned id, struct
 
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
+ *	@id: ATA device number
  *	@drv_stat: value contained in ATA status register
  *	@drv_err: value contained in ATA error register
  *	@sk: the sense key we'll fill out
@@ -2221,7 +2222,7 @@ ata_scsi_map_proto(u8 byte1)
 /**
  *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
  *	@qc: command structure to be initialized
- *	@cmd: SCSI command to convert
+ *	@scsicmd: SCSI command to convert
  *
  *	Handles either 12 or 16-byte versions of the CDB.
  *


---
