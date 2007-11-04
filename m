From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/18] ide: add missing #ifdef/#endif CONFIG_IDE_TASK_IOCTL
Date: Mon, 5 Nov 2007 00:18:02 +0100
Message-ID: <200711050018.02648.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:52656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbXKDX3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:33 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219889nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -568,6 +568,7 @@ int ide_no_data_taskfile(ide_drive_t *dr
 
 EXPORT_SYMBOL_GPL(ide_no_data_taskfile);
 
+#ifdef CONFIG_IDE_TASK_IOCTL
 int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
 	ide_task_request_t	*req_task;
@@ -771,6 +772,7 @@ abort:
 
 	return err;
 }
+#endif
 
 int ide_wait_cmd (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *buf)
 {
