From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/15] ide: remove stale comments from ide-taskfile.c
Date: Mon, 1 Oct 2007 23:42:49 +0200
Message-ID: <200710012342.49466.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757254AbXJAVjx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:53 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977009ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   23 -----------------------
 1 file changed, 23 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -8,23 +8,6 @@
  *  Copyright (C) 2003-2004	Bartlomiej Zolnierkiewicz
  *
  *  The big the bad and the ugly.
- *
- *  Problems to be fixed because of BH interface or the lack therefore.
- *
- *  Fill me in stupid !!!
- *
- *  HOST:
- *	General refers to the Controller and Driver "pair".
- *  DATA HANDLER:
- *	Under the context of Linux it generally refers to an interrupt handler.
- *	However, it correctly describes the 'HOST'
- *  DATA BLOCK:
- *	The amount of data needed to be transfered as predefined in the
- *	setup of the device.
- *  STORAGE ATOMIC:
- *	The 'DATA BLOCK' associated to the 'DATA HANDLER', and can be as
- *	small as a single sector or as large as the entire command block
- *	request.
  */
 
 #include <linux/module.h>
@@ -685,9 +668,6 @@ int ide_wait_cmd (ide_drive_t *drive, u8
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-/*
- * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
- */
 int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
@@ -751,9 +731,6 @@ static int ide_wait_cmd_task(ide_drive_t
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-/*
- * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
- */
 int ide_task_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
 	void __user *p = (void __user *)arg;
