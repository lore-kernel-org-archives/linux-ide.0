From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 04/10] ide: cleanup ide_disk_init_mult_count()
Date: Tue, 22 Jul 2008 23:12:28 +0200
Message-ID: <20080722211228.20478.63822.sendpatchset@localhost.localdomain>
References: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:50843 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457AbYGVVOi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 17:14:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so963175fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 14:14:37 -0700 (PDT)
In-Reply-To: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Remove superfluous checks for drive->mult_req.

* No need to zero drive's fields.

* Move the common code out of #ifdef scope.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -89,20 +89,19 @@ static void ide_disk_init_mult_count(ide
 {
 	struct hd_driveid *id = drive->id;
 
-	drive->mult_count = 0;
 	if (id->max_multsect) {
 #ifdef CONFIG_IDEDISK_MULTI_MODE
-		id->multsect = ((id->max_multsect/2) > 1) ? id->max_multsect : 0;
-		id->multsect_valid = id->multsect ? 1 : 0;
-		drive->mult_req = id->multsect_valid ? id->max_multsect : 0;
-		drive->special.b.set_multmode = drive->mult_req ? 1 : 0;
-#else	/* original, pre IDE-NFG, per request of AC */
-		drive->mult_req = 0;
-		if (drive->mult_req > id->max_multsect)
-			drive->mult_req = id->max_multsect;
-		if (drive->mult_req || ((id->multsect_valid & 1) && id->multsect))
-			drive->special.b.set_multmode = 1;
+		if ((id->max_multsect / 2) > 1) {
+			id->multsect = id->max_multsect;
+			id->multsect_valid = 1;
+		} else {
+			id->multsect = 0;
+			id->multsect_valid = 0;
+		}
+		drive->mult_req = id->multsect;
 #endif
+		if ((id->multsect_valid & 1) && id->multsect)
+			drive->special.b.set_multmode = 1;
 	}
 }
 
