From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-cd: fix another NULL ptr in debug statement
Date: Thu, 25 Sep 2008 09:51:33 +0200
Message-ID: <20080925075133.GC13100@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:28378 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbYIYHvj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Sep 2008 03:51:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so215761fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 25 Sep 2008 00:51:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Bart,

here's another null ptr fix in the debugging code. I'll be auditing all the
debug fragments in case I've missed some.

---
From: Borislav Petkov <petkovbb@gmail.com>
Date: Thu, 25 Sep 2008 09:36:26 +0200
Subject: [PATCH] ide-cd: fix another NULL ptr in debug statement

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 5ed925d..c830817 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -166,10 +166,13 @@ static void cdrom_analyze_sense_data(ide_drive_t *drive,
 	unsigned long bio_sectors;
 	struct cdrom_info *info = drive->driver_data;
 
-	ide_debug_log(IDE_DBG_SENSE, "Call %s, failed cmd: 0x%x, "
-		      "error_code: 0x%x, sense_key: 0x%x\n",
-		      __func__, failed_command->cmd[0], sense->error_code,
-		      sense->sense_key);
+	ide_debug_log(IDE_DBG_SENSE, "Call %s, error_code: 0x%x, "
+			"sense_key: 0x%x\n", __func__, sense->error_code,
+			sense->sense_key);
+
+	if (failed_command)
+		ide_debug_log(IDE_DBG_SENSE, "%s: failed cmd: 0x%x\n",
+				__func__, failed_command->cmd[0]);
 
 	if (!cdrom_log_sense(drive, failed_command, sense))
 		return;
-- 
1.5.5.4

-- 
Regards/Gruss,
    Boris.
