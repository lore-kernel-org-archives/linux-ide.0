From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Allow per driver taskfile filters
Date: Fri, 05 Nov 2004 16:36:10 +0000
Message-ID: <1099672568.5564.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:11717 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262734AbUKERjD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:39:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

This is needed for the IT8212 merge

diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/include/linux/ide.h linux-2.6.10rc1/include/linux/ide.h
--- linux.vanilla-2.6.10rc1/include/linux/ide.h	2004-11-05 15:42:18.000000000 +0000
+++ linux-2.6.10rc1/include/linux/ide.h	2004-11-05 16:26:18.000000000 +0000
@@ -794,6 +795,7 @@
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
 
 struct ide_pci_device_s;
+struct ide_task_s;
 
 typedef struct hwif_s {
 	struct hwif_s *next;		/* for linked-list in ide_hwgroup_t */
@@ -856,6 +858,8 @@
 //	u8	(*ratemask)(ide_drive_t *);
 //	/* device rate limiter */
 //	u8	(*ratefilter)(ide_drive_t *, u8);
+	/* allow command filter/control */
+	int	(*raw_taskfile)(ide_drive_t *, struct ide_task_s *, u8 *);
 #endif
 
 	void (*ata_input_data)(ide_drive_t *, void *, u32);
@@ -1374,6 +1378,7 @@
 extern ide_startstop_t task_out_intr(ide_drive_t *);
 
 extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
+extern int ide_diag_taskfile(ide_drive_t *, ide_task_t *, unsigned long, u8 *);
 
 int ide_taskfile_ioctl(ide_drive_t *, unsigned int, unsigned long);
 int ide_cmd_ioctl(ide_drive_t *, unsigned int, unsigned long);
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/ide.c linux-2.6.10rc1/drivers/ide/ide.c
--- linux.vanilla-2.6.10rc1/drivers/ide/ide.c	2004-11-05 15:42:15.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/ide.c	2004-11-05 16:06:29.000000000 +0000
@@ -678,6 +678,7 @@
 	hwif->maskproc			= tmp_hwif->maskproc;
 	hwif->quirkproc			= tmp_hwif->quirkproc;
 	hwif->busproc			= tmp_hwif->busproc;
+	hwif->raw_taskfile		= tmp_hwif->raw_taskfile;
 
 	hwif->ata_input_data		= tmp_hwif->ata_input_data;
 	hwif->ata_output_data		= tmp_hwif->ata_output_data;
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/ide-taskfile.c linux-2.6.10rc1/drivers/ide/ide-taskfile.c
--- linux.vanilla-2.6.10rc1/drivers/ide/ide-taskfile.c	2004-11-05 15:42:15.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/ide-taskfile.c	2004-11-05 16:07:34.000000000 +0000
@@ -511,7 +511,11 @@
 
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

