From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/12] ide-disk: add get_smart_data() helper
Date: Mon, 8 Oct 2007 23:09:24 +0200
Message-ID: <200710082309.24243.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:59004 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbXJHVju (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:50 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370186nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Merge get_smart_values() and get_smart_thresholds()
into get_smart_data() helper.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -593,28 +593,12 @@ static int smart_enable(ide_drive_t *dri
 	return ide_raw_taskfile(drive, &args, NULL);
 }
 
-static int get_smart_values(ide_drive_t *drive, u8 *buf)
+static int get_smart_data(ide_drive_t *drive, u8 *buf, u8 sub_cmd)
 {
 	ide_task_t args;
 
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_READ_VALUES;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
-	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
-	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
-	args.command_type			= IDE_DRIVE_TASK_IN;
-	args.data_phase				= TASKFILE_IN;
-	args.handler				= &task_in_intr;
-	(void) smart_enable(drive);
-	return ide_raw_taskfile(drive, &args, buf);
-}
-
-static int get_smart_thresholds(ide_drive_t *drive, u8 *buf)
-{
-	ide_task_t args;
-	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_READ_THRESHOLDS;
+	args.tfRegister[IDE_FEATURE_OFFSET]	= sub_cmd;
 	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
 	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
@@ -656,7 +640,7 @@ static int proc_idedisk_read_smart_thres
 	ide_drive_t	*drive = (ide_drive_t *)data;
 	int		len = 0, i = 0;
 
-	if (!get_smart_thresholds(drive, page)) {
+	if (get_smart_data(drive, page, SMART_READ_THRESHOLDS) == 0) {
 		unsigned short *val = (unsigned short *) page;
 		char *out = ((char *)val) + (SECTOR_WORDS * 4);
 		page = out;
@@ -675,7 +659,7 @@ static int proc_idedisk_read_smart_value
 	ide_drive_t	*drive = (ide_drive_t *)data;
 	int		len = 0, i = 0;
 
-	if (!get_smart_values(drive, page)) {
+	if (get_smart_data(drive, page, SMART_READ_VALUES) == 0) {
 		unsigned short *val = (unsigned short *) page;
 		char *out = ((char *)val) + (SECTOR_WORDS * 4);
 		page = out;
