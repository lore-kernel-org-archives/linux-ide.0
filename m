From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: remove superfluous SELECT_MASK() call from do_rw_taskfile()
Date: Mon, 1 Jun 2009 23:53:07 +0200
Message-ID: <200906012353.07374.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:51303 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759173AbZFAVz7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2009 17:55:59 -0400
Received: by mail-ew0-f176.google.com with SMTP id 24so8197834ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2009 14:56:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

With ->write_devctl method call (which unmasks drive IRQ) preceding
SELECT_MASK() call there is really no need for the latter.

Moreover with the combination of HPT36x controller and the drive on
the quirk_drives[] list this can result in superfluous enable_irq()
call which in turn will trigger WARN() in __enable_irq().

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    1 -
 1 file changed, 1 deletion(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -98,7 +98,6 @@ ide_startstop_t do_rw_taskfile(ide_drive
 	if ((cmd->tf_flags & IDE_TFLAG_DMA_PIO_FALLBACK) == 0) {
 		ide_tf_dump(drive->name, cmd);
 		tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
-		SELECT_MASK(drive, 0);
 
 		if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
 			u8 data[2] = { cmd->tf.data, cmd->hob.data };
