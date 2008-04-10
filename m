From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide-{floppy,tape,scsi}: 400ns delay is required after executing the command
Date: Thu, 10 Apr 2008 22:26:48 +0200
Message-ID: <200804102226.48763.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:19658 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757879AbYDJUMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 16:12:15 -0400
Received: by mu-out-0910.google.com with SMTP id i10so212464mue.5
        for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 13:12:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |    1 +
 drivers/ide/ide-tape.c   |    1 +
 drivers/scsi/ide-scsi.c  |    1 +
 3 files changed, 3 insertions(+)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -698,6 +698,7 @@ static ide_startstop_t idefloppy_issue_p
 		/* Issue the packet command */
 		hwif->OUTBSYNC(drive, WIN_PACKETCMD,
 			       hwif->io_ports.command_addr);
+		ndelay(400);
 		return (*pkt_xfer_routine) (drive);
 	}
 }
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1058,6 +1058,7 @@ static ide_startstop_t idetape_issue_pc(
 	} else {
 		hwif->OUTBSYNC(drive, WIN_PACKETCMD,
 			       hwif->io_ports.command_addr);
+		ndelay(400);
 		return idetape_transfer_pc(drive);
 	}
 }
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -576,6 +576,7 @@ static ide_startstop_t idescsi_issue_pc(
 		/* Issue the packet command */
 		hwif->OUTBSYNC(drive, WIN_PACKETCMD,
 			       hwif->io_ports.command_addr);
+		ndelay(400);
 		return idescsi_transfer_pc(drive);
 	}
 }
