From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/40] ide-scsi: remove superfluous BUG_ON() from idescsi_transfer_pc()
Date: Sun, 18 May 2008 20:55:22 +0200
Message-ID: <20080518185522.5636.90985.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:24872 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492AbYERSh6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:37:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1425123fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:37:56 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

ide_set_handler() bugs on ->handler == NULL so no need to do it
in idescsi_transfer_pc().

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -469,7 +469,7 @@ static ide_startstop_t idescsi_transfer_
 				"issuing a packet command\n");
 		return ide_do_reset (drive);
 	}
-	BUG_ON(HWGROUP(drive)->handler != NULL);
+
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 
