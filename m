From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 6/6] ide-atapi: teach ide atapi about drive->waiting_for_dma
Date: Thu,  4 Dec 2008 07:43:29 +0100
Message-ID: <1228373010-20249-7-git-send-email-petkovbb@gmail.com>
References: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:37198 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbYLDGnl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 01:43:41 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2725976fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 03 Dec 2008 22:43:40 -0800 (PST)
In-Reply-To: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

In addition, we wait for DRQ to be asserted by repeatedly polling
device status no matter what DRQ type each device implements.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index bb867a0..a43bed3 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -543,6 +543,11 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 		return startstop;
 	}
 
+	if (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT) {
+		if (drive->dma)
+			drive->waiting_for_dma = 1;
+	}
+
 	ireason = ide_read_ireason(drive);
 	if (drive->media == ide_tape &&
 	    (drive->dev_flags & IDE_DFLAG_SCSI) == 0)
@@ -639,6 +644,8 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout)
 
 	/* Issue the packet command */
 	if (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT) {
+		if (drive->dma)
+			drive->waiting_for_dma = 0;
 		ide_execute_command(drive, ATA_CMD_PACKET, ide_transfer_pc,
 				    timeout, expiry);
 		return ide_started;
-- 
1.6.0.4

