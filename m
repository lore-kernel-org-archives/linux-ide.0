From: Magnus Damm <damm@opensource.se>
Subject: [PATCH] possible typo in ide-disk.c
Date: Thu, 22 Jul 2004 00:22:12 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1090448532.9480.3.camel@kubu.opensource.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-H8ue9Jc60wc+BPOVIU1t"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.80.72.10] ([213.80.72.10]:2450 "EHLO kubrik.opensource.se")
	by vger.kernel.org with ESMTP id S266758AbUGUWQI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jul 2004 18:16:08 -0400
Received: from [192.168.1.16] (unknown [213.80.72.14])
	by kubrik.opensource.se (Postfix) with ESMTP id 285B33752C
	for <linux-ide@vger.kernel.org>; Thu, 22 Jul 2004 00:04:25 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-H8ue9Jc60wc+BPOVIU1t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

This sure looks like a typo to me.

/ magnus - not subscribed, please cc.



--=-H8ue9Jc60wc+BPOVIU1t
Content-Disposition: attachment; filename=linux-2.6.8-rc2-ide_task_no_data_intr_20040722.patch
Content-Type: text/x-patch; name=linux-2.6.8-rc2-ide_task_no_data_intr_20040722.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.8-rc2/drivers/ide/ide-disk.c	2004-07-22 00:01:26.000000000 +0200
+++ linux-2.6.8-rc2-ide_task_no_data_intr_20040722/drivers/ide/ide-disk.c	2004-07-22 00:01:57.000000000 +0200
@@ -1377,25 +1377,25 @@
 		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_idle:		/* Resume step 1 (idle) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
+		args->handler = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_restore_dma:	/* Resume step 2 (restore DMA) */
 		/*
 		 * Right now, all we do is call hwif->ide_dma_check(drive),
 		 * we could be smarter and check for current xfer_speed
 		 * in struct drive etc...
 		 * Also, this step could be implemented as a generic helper
 		 * as most subdrivers will use it
 		 */
 		if ((drive->id->capability & 1) == 0)
 			break;

--=-H8ue9Jc60wc+BPOVIU1t--

