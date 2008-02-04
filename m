From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 18/22] ide-tape: remove leftover OnStream support warning
Date: Mon,  4 Feb 2008 14:40:36 +0100
Message-ID: <1202132440-26648-19-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.249]:3803 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758249AbYBDNsi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:48:38 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1919777hsz.5
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:48:37 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index cfcf5b0..4a12c0b 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -3629,10 +3629,6 @@ static int ide_tape_probe(ide_drive_t *drive)
 		printk("ide-tape: passing drive %s to ide-scsi emulation.\n", drive->name);
 		goto failed;
 	}
-	if (strstr(drive->id->model, "OnStream DI-")) {
-		printk(KERN_WARNING "ide-tape: Use drive %s with ide-scsi emulation and osst.\n", drive->name);
-		printk(KERN_WARNING "ide-tape: OnStream support will be removed soon from ide-tape!\n");
-	}
 	tape = kzalloc(sizeof (idetape_tape_t), GFP_KERNEL);
 	if (tape == NULL) {
 		printk(KERN_ERR "ide-tape: %s: Can't allocate a tape structure\n", drive->name);
-- 
1.5.3.7

