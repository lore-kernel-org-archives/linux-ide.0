From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] ide: make wait_drive_not_busy() static again
Date: Tue, 29 Jan 2008 00:10:06 +0200
Message-ID: <20080128221006.GK8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:46394 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759392AbYA1WJk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 17:09:40 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.o

After commit 7267c3377443322588cddaf457cf106839a60463 
wait_drive_not_busy() can become static again.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/ide/ide-taskfile.c |    2 +-
 include/linux/ide.h        |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 5eb6fa1..d320001 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -260,7 +260,7 @@ static ide_startstop_t task_no_data_intr(ide_drive_t *drive)
 	return ide_stopped;
 }
 
-u8 wait_drive_not_busy(ide_drive_t *drive)
+static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	int retries;
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 27cb39d..5d3d88e 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -986,8 +986,6 @@ ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
 
 void task_end_request(ide_drive_t *, struct request *, u8);
 
-u8 wait_drive_not_busy(ide_drive_t *);
-
 int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *, u16);
 int ide_no_data_taskfile(ide_drive_t *, ide_task_t *);
 

