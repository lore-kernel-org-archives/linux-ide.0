From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/63] ide-cd: remove stale cdrom_transfer_packet_command() comment
Date: Thu, 20 Dec 2007 02:04:25 +0100
Message-ID: <200712200204.25234.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:11604 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858AbXLTBeR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:17 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389244ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    4 ----
 1 file changed, 4 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -684,10 +684,6 @@ static ide_startstop_t cdrom_start_packe
    by cdrom_start_packet_command.
    HANDLER is the interrupt handler to call when the command completes
    or there's data ready. */
-/*
- * changed 5 parameters to 3 for dvd-ram
- * struct packet_command *pc; now packet_command_t *pc;
- */
 #define ATAPI_MIN_CDB_BYTES 12
 static ide_startstop_t cdrom_transfer_packet_command (ide_drive_t *drive,
 					  struct request *rq,
