From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide: remove superfluous SELECT_MASK() call from ide_driveid_update()
Date: Mon, 1 Jun 2009 23:52:57 +0200
Message-ID: <200906012352.57741.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:60692 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758958AbZFAVz7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2009 17:55:59 -0400
Received: by ewy24 with SMTP id 24so8197862ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2009 14:56:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

We always call SELECT_MASK(drive, 0) after ide_dev_read_id() call
so there is no need to do it again in the error path.

Moreover with the combination of HPT36x controller and the drive on
the quirk_drives[] list this can result in superfluous enable_irq()
call which in turn will trigger WARN() in __enable_irq().

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Sergei, after re-audit of my recent changes: these three patches should go
before "hpt366: sync quirk_drives[] list with pdc202xx_{new,old}.c" one.

 drivers/ide/ide-iops.c |    1 -
 1 file changed, 1 deletion(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -311,7 +311,6 @@ int ide_driveid_update(ide_drive_t *driv
 
 	return 1;
 out_err:
-	SELECT_MASK(drive, 0);
 	if (rc == 2)
 		printk(KERN_ERR "%s: %s: bad status\n", drive->name, __func__);
 	kfree(id);
