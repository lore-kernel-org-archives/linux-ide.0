From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/14] ide: use ide_complete_cmd() for PM commands
Date: Mon, 02 Feb 2009 22:40:23 +0100
Message-ID: <20090202214023.17960.77399.sendpatchset@localhost.localdomain>
References: <20090202213707.17960.61897.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:9188 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759366AbZBBVj0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Feb 2009 16:39:26 -0500
In-Reply-To: <20090202213707.17960.61897.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: use ide_complete_cmd() for PM commands

* Fixup ->tf_flags in ide_do_park_unpark() and ide_start_power_step()
  to match their current use.

* Use ide_complete_cmd() for PM commands using ATA_PROT_NODATA.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-park.c     |    4 ++--
 drivers/ide/ide-pm.c       |    2 +-
 drivers/ide/ide-taskfile.c |    8 +++-----
 3 files changed, 6 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-park.c
===================================================================
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -74,11 +74,11 @@ ide_startstop_t ide_do_park_unpark(ide_d
 		tf->lbal = 0x4c;
 		tf->lbam = 0x4e;
 		tf->lbah = 0x55;
-		cmd.tf_flags |= IDE_TFLAG_CUSTOM_HANDLER;
 	} else		/* cmd == REQ_UNPARK_HEADS */
 		tf->command = ATA_CMD_CHK_POWER;
 
-	cmd.tf_flags |= IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE |
+		       IDE_TFLAG_CUSTOM_HANDLER;
 	cmd.protocol = ATA_PROT_NODATA;
 
 	cmd.rq = rq;
Index: b/drivers/ide/ide-pm.c
===================================================================
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -163,7 +163,7 @@ ide_startstop_t ide_start_power_step(ide
 	return ide_stopped;
 
 out_do_tf:
-	cmd->tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd->tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 	cmd->protocol = ATA_PROT_NODATA;
 
 	return do_rw_taskfile(drive, cmd);
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -149,13 +149,11 @@ static ide_startstop_t task_no_data_intr
 	if (custom && tf->command == ATA_CMD_SET_MULTI)
 		drive->mult_count = drive->mult_req;
 
-	if (custom == 0 || tf->command == ATA_CMD_IDLEIMMEDIATE) {
-		struct request *rq = hwif->rq;
+	if (custom == 0 || tf->command == ATA_CMD_IDLEIMMEDIATE ||
+	    tf->command == ATA_CMD_CHK_POWER) {
 		u8 err = ide_read_error(drive);
 
-		if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE ||
-		    tf->command == ATA_CMD_IDLEIMMEDIATE)
-			ide_complete_cmd(drive, cmd, stat, err);
+		ide_complete_cmd(drive, cmd, stat, err);
 		ide_complete_rq(drive, err);
 	}
 
