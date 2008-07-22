From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/10] ide: remove superfluous check from ide_disk_special()
Date: Tue, 22 Jul 2008 23:12:20 +0200
Message-ID: <20080722211220.20478.34892.sendpatchset@localhost.localdomain>
References: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:50809 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbYGVVOc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 17:14:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so963151fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 14:14:30 -0700 (PDT)
In-Reply-To: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

This condition is checked by both ide_disk_init_mult_count()
and set_multcount() so no need to do it again in ide_disk_special().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -540,8 +540,6 @@ static ide_startstop_t ide_disk_special(
 		ide_tf_set_restore_cmd(drive, &args.tf);
 	} else if (s->b.set_multmode) {
 		s->b.set_multmode = 0;
-		if (drive->mult_req > drive->id->max_multsect)
-			drive->mult_req = drive->id->max_multsect;
 		ide_tf_set_setmult_cmd(drive, &args.tf);
 	} else if (s->all) {
 		int special = s->all;
