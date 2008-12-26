From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/8] ide-cd: first conversion batch
Date: Fri, 26 Dec 2008 14:46:21 +0100
Message-ID: <20081226134621.GB23503@gollum.tnic>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com> <200812192115.41068.bzolnier@gmail.com> <20081220062849.GA14770@gollum.tnic> <200812212005.56973.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:47186 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbYLZNqY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Dec 2008 08:46:24 -0500
Content-Disposition: inline
In-Reply-To: <200812212005.56973.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Borislav Petkov <petkovbb@gmail.com>
Date: Thu, 25 Dec 2008 18:46:35 +0100
Subject: [PATCH 10/11] ide-cd: start DMA before sending the actual packet command

as it is done for all other IDE ATAPI devices.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 1c1ba43..2cb301d 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -593,13 +593,13 @@ static ide_startstop_t cdrom_transfer_packet_command(ide_drive_t *drive)
 	if (cmd_len < ATAPI_MIN_CDB_BYTES)
 		cmd_len = ATAPI_MIN_CDB_BYTES;
 
-	/* send the command to the device */
-	hwif->tp_ops->output_data(drive, NULL, rq->cmd, cmd_len);
-
 	/* start the DMA if need be */
 	if (drive->dma)
 		hwif->dma_ops->dma_start(drive);
 
+	/* send the command to the device */
+	hwif->tp_ops->output_data(drive, NULL, rq->cmd, cmd_len);
+
 	return ide_started;
 }
 
-- 
1.6.0.4

-- 
Regards/Gruss,
    Boris.
