From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/7] ide: BUG() on unknown flags in ide_disk_special()
Date: Wed, 13 May 2009 22:51:53 +0200
Message-ID: <20090513205153.28638.52533.sendpatchset@localhost.localdomain>
References: <20090513205139.28638.87226.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:40473 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761474AbZEMUrW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 16:47:22 -0400
In-Reply-To: <20090513205139.28638.87226.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -201,12 +201,8 @@ static ide_startstop_t ide_disk_special(
 	} else if (s->b.set_multmode) {
 		s->b.set_multmode = 0;
 		ide_tf_set_setmult_cmd(drive, &cmd.tf);
-	} else if (s->all) {
-		int special = s->all;
-		s->all = 0;
-		printk(KERN_ERR "%s: bad special flag: 0x%02x\n", drive->name, special);
-		return ide_stopped;
-	}
+	} else
+		BUG();
 
 	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
 	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
