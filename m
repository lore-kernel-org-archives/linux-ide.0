From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 09/24] ide-tape: remove pipeline-specific code from idetape_mtioctop
Date: Sat,  1 Mar 2008 09:58:33 +0100
Message-ID: <1204361928-30229-10-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:65331 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756878AbYCAI72 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:28 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2626833nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:27 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index d4a2e73..dd11c7b 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2693,7 +2693,6 @@ static int idetape_mtioctop(ide_drive_t *drive, short mt_op, int mt_count)
 	case MTWEOF:
 		if (tape->write_prot)
 			return -EACCES;
-		idetape_discard_read_pipeline(drive, 1);
 		for (i = 0; i < mt_count; i++) {
 			retval = idetape_write_filemark(drive);
 			if (retval)
@@ -2701,12 +2700,10 @@ static int idetape_mtioctop(ide_drive_t *drive, short mt_op, int mt_count)
 		}
 		return 0;
 	case MTREW:
-		idetape_discard_read_pipeline(drive, 0);
 		if (idetape_rewind_tape(drive))
 			return -EIO;
 		return 0;
 	case MTLOAD:
-		idetape_discard_read_pipeline(drive, 0);
 		idetape_create_load_unload_cmd(drive, &pc,
 					       IDETAPE_LU_LOAD_MASK);
 		return idetape_queue_pc_tail(drive, &pc);
@@ -2721,7 +2718,6 @@ static int idetape_mtioctop(ide_drive_t *drive, short mt_op, int mt_count)
 				if (!idetape_queue_pc_tail(drive, &pc))
 					tape->door_locked = DOOR_UNLOCKED;
 		}
-		idetape_discard_read_pipeline(drive, 0);
 		idetape_create_load_unload_cmd(drive, &pc,
 					      !IDETAPE_LU_LOAD_MASK);
 		retval = idetape_queue_pc_tail(drive, &pc);
@@ -2729,10 +2725,8 @@ static int idetape_mtioctop(ide_drive_t *drive, short mt_op, int mt_count)
 			clear_bit(IDETAPE_FLAG_MEDIUM_PRESENT, &tape->flags);
 		return retval;
 	case MTNOP:
-		idetape_discard_read_pipeline(drive, 0);
 		return idetape_flush_tape_buffers(drive);
 	case MTRETEN:
-		idetape_discard_read_pipeline(drive, 0);
 		idetape_create_load_unload_cmd(drive, &pc,
 			IDETAPE_LU_RETENSION_MASK | IDETAPE_LU_LOAD_MASK);
 		return idetape_queue_pc_tail(drive, &pc);
@@ -2754,11 +2748,9 @@ static int idetape_mtioctop(ide_drive_t *drive, short mt_op, int mt_count)
 			set_bit(IDETAPE_FLAG_DETECT_BS, &tape->flags);
 		return 0;
 	case MTSEEK:
-		idetape_discard_read_pipeline(drive, 0);
 		return idetape_position_tape(drive,
 			mt_count * tape->user_bs_factor, tape->partition, 0);
 	case MTSETPART:
-		idetape_discard_read_pipeline(drive, 0);
 		return idetape_position_tape(drive, 0, mt_count, 0);
 	case MTFSR:
 	case MTBSR:
-- 
1.5.4.1

