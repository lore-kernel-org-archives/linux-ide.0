From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 01/18] ide-cd: remove wait-for-idle-controller bit in cdrom_start_packet_command
Date: Thu, 12 Jun 2008 08:40:53 +0200
Message-ID: <1213252870-20474-2-git-send-email-petkovbb@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:9538 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbYFLGlF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:41:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2381793fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:41:02 -0700 (PDT)
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

This is done in the request issue path anyway

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index d998471..92a8a36 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -517,14 +517,9 @@ static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
 						  int xferlen,
 						  ide_handler_t *handler)
 {
-	ide_startstop_t startstop;
 	struct cdrom_info *info = drive->driver_data;
 	ide_hwif_t *hwif = drive->hwif;
 
-	/* wait for the controller to be idle */
-	if (ide_wait_stat(&startstop, drive, 0, BUSY_STAT, WAIT_READY))
-		return startstop;
-
 	/* FIXME: for Virtual DMA we must check harder */
 	if (info->dma)
 		info->dma = !hwif->dma_ops->dma_setup(drive);
-- 
1.5.5.1

