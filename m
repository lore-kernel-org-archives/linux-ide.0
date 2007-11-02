From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/9] ide-disk: extend timeout for PIO-in commands
Date: Fri, 2 Nov 2007 23:05:36 +0100
Message-ID: <200711022305.36715.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:60738 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbXKBWIX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:23 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940323nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


s/WAIT_CMD/WAIT_WORSTCASE/ to make the timeout the same as in do_rw_taskfile()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -262,7 +262,8 @@ static ide_startstop_t __ide_do_rw_disk(
 			command = lba48 ? WIN_READ_EXT : WIN_READ;
 		}
 
-		ide_execute_command(drive, command, &task_in_intr, WAIT_CMD, NULL);
+		ide_execute_command(drive, command, &task_in_intr,
+				    WAIT_WORSTCASE, NULL);
 		return ide_started;
 	} else {
 		if (drive->mult_count) {
