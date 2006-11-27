From: Elias Oltmanns <eo@nebensachen.de>
Subject: [PATCH] IDE: typo in ide-io.c leads to faulty assignment
Date: Mon, 27 Nov 2006 15:51:33 +0100
Message-ID: <87k61h3pu2.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.225.107.202]:53485 "EHLO nebensachen.de")
	by vger.kernel.org with ESMTP id S1758250AbWK0Ovl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Nov 2006 09:51:41 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org

--=-=-=

Due to a typo in ide_start_power_step, the result of a function rather
than its pointer is assigned to args->handler. The patch applies to
2.6.19-rc6 but the problem exists in the stable branch as well.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=ide-io.c.patch

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 2614f41..48a249d 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -213,7 +213,7 @@ static ide_startstop_t ide_start_power_s
 	case idedisk_pm_idle:		/* Resume step 2 (idle) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
+		args->handler = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case ide_pm_restore_dma:	/* Resume step 3 (restore DMA) */

--=-=-=--
