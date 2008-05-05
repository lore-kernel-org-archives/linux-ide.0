From: Adrian Bunk <bunk@kernel.org>
Subject: [2,6 patch] make ide-iops.c:SELECT_MASK() static
Date: Mon, 5 May 2008 21:21:39 +0300
Message-ID: <20080505182139.GD17139@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:60889 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbYEESWq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 May 2008 14:22:46 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

SELECT_MASK() can now become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/ide/ide-iops.c |    2 +-
 include/linux/ide.h    |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

a40b494f0b7f057a6cb143ab2846cfe3f58417ee diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index 57d9a9a..200eb2a 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -95,7 +95,7 @@ void SELECT_DRIVE (ide_drive_t *drive)
 	hwif->OUTB(drive->select.all, hwif->io_ports.device_addr);
 }
 
-void SELECT_MASK (ide_drive_t *drive, int mask)
+static void SELECT_MASK (ide_drive_t *drive, int mask)
 {
 	const struct ide_port_ops *port_ops = drive->hwif->port_ops;
 
diff --git a/include/linux/ide.h b/include/linux/ide.h
index b0135b0..19ec852 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -965,7 +965,6 @@ typedef struct ide_task_s {
 void ide_tf_dump(const char *, struct ide_taskfile *);
 
 extern void SELECT_DRIVE(ide_drive_t *);
-extern void SELECT_MASK(ide_drive_t *, int);
 
 extern int drive_is_ready(ide_drive_t *);
 

