From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 11/24] ide-tape: remove pipeline-specific code from idetape_blkdev_ioctl
Date: Sat,  1 Mar 2008 09:58:35 +0100
Message-ID: <1204361928-30229-12-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:12899 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbYCAI7Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:25 -0500
Received: by fk-out-0910.google.com with SMTP id z23so6043882fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:24 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Also, strip struct idetape_config down to a single int due to unused/removed
members.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 447b7b4..0ebb745 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2384,26 +2384,19 @@ static int idetape_blkdev_ioctl(ide_drive_t *drive, unsigned int cmd,
 {
 	idetape_tape_t *tape = drive->driver_data;
 	void __user *argp = (void __user *)arg;
-
-	struct idetape_config {
-		int dsc_rw_frequency;
-		int dsc_media_access_frequency;
-		int nr_stages;
-	} config;
+	int dsc_rw_frequency;
 
 	debug_log(DBG_PROCS, "Enter %s\n", __func__);
 
 	switch (cmd) {
 	case 0x0340:
-		if (copy_from_user(&config, argp, sizeof(config)))
+		if (copy_from_user(&dsc_rw_frequency, argp, sizeof(int)))
 			return -EFAULT;
-		tape->best_dsc_rw_freq = config.dsc_rw_frequency;
-		tape->max_stages = config.nr_stages;
+		tape->best_dsc_rw_freq = dsc_rw_frequency;
 		break;
 	case 0x0350:
-		config.dsc_rw_frequency = (int) tape->best_dsc_rw_freq;
-		config.nr_stages = tape->max_stages;
-		if (copy_to_user(argp, &config, sizeof(config)))
+		dsc_rw_frequency = (int) tape->best_dsc_rw_freq;
+		if (copy_to_user(argp, &dsc_rw_frequency, sizeof(int)))
 			return -EFAULT;
 		break;
 	default:
-- 
1.5.4.1

