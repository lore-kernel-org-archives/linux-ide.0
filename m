From: Alan Cox <alan@redhat.com>
Subject: PATCH: enable the hwif->raw_taskfile hook
Date: Sun, 15 Aug 2004 11:05:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040815150538.GA13244@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266781AbUHOPLI@vger.kernel.org>
Content-Disposition: inline
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
List-Id: linux-ide@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide-taskfile.c linux-2.6.8-rc3/drivers/ide/ide-taskfile.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-taskfile.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-taskfile.c	2004-08-12 16:43:49.000000000 +0100
@@ -604,7 +604,11 @@
 
 int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *args, u8 *buf)
 {
-	return ide_diag_taskfile(drive, args, 0, buf);
+	ide_hwif_t *hwif = HWIF(drive);
+	if(hwif->raw_taskfile)
+		return hwif->raw_taskfile(drive, args, buf);
+	else
+		return ide_diag_taskfile(drive, args, 0, buf);
 }
 
 EXPORT_SYMBOL(ide_raw_taskfile);

Signed-off-by: Alan Cox <alan@redhat.com>

--
Xenophobia: fear of paravirtualization
