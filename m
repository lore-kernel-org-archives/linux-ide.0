From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/12] ide: fix ->data_phase in taskfile_load_raw()
Date: Mon, 8 Oct 2007 23:08:42 +0200
Message-ID: <200710082308.42511.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:59889 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbXJHVjt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:49 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370209nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


It should be TASKFILE_NO_DATA, not TASKFILE_IN.  Luckily ATM ->data_phase is
unused if ->command_type == IDE_DRIVE_TASK_NO_DATA but this may change in the
future.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -350,7 +350,7 @@ static int taskfile_load_raw(ide_drive_t
 
 	memset(&args, 0, sizeof(ide_task_t));
 	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-	args.data_phase   = TASKFILE_IN;
+	args.data_phase   = TASKFILE_NO_DATA;
 	args.handler      = &task_no_data_intr;
 
 	/* convert gtf to IDE Taskfile */
