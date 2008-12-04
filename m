From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/6] ide-atapi: add a dev_is_idecd-inline
Date: Thu,  4 Dec 2008 07:43:24 +0100
Message-ID: <1228373010-20249-2-git-send-email-petkovbb@gmail.com>
References: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:58226 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118AbYLDGnj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 01:43:39 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3301606fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 03 Dec 2008 22:43:37 -0800 (PST)
In-Reply-To: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 4e58b9e..33a1534 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -14,6 +14,12 @@
 #define debug_log(fmt, args...) do {} while (0)
 #endif
 
+static inline int dev_is_idecd(ide_drive_t *drive)
+{
+	return (drive->media == ide_cdrom || drive->media == ide_optical) &&
+		!(drive->dev_flags & IDE_DFLAG_SCSI);
+}
+
 /*
  * Check whether we can support a device,
  * based on the ATAPI IDENTIFY command results.
@@ -577,7 +583,7 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 
 	if (scsi)
 		tf_flags = 0;
-	else if (drive->media == ide_cdrom || drive->media == ide_optical)
+	else if (dev_is_idecd(drive))
 		tf_flags = IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL;
 	else
 		tf_flags = IDE_TFLAG_OUT_DEVICE;
-- 
1.6.0.4

