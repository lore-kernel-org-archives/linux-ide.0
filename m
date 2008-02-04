From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 19/22] ide-tape: fix syntax error in idetape_identify_device()
Date: Mon,  4 Feb 2008 14:40:37 +0100
Message-ID: <1202132440-26648-20-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.241]:1135 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756058AbYBDNmh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:42:37 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1918852hsz.5
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:42:36 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Spotted by Sergei Shtylyov.

CC: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 4a12c0b..7e998c4 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -3273,8 +3273,8 @@ static int idetape_identify_device(ide_drive_t *drive)
 	else if (!removable)
 		printk(KERN_ERR "ide-tape: The removable flag is not set\n");
 	else if (packet_size != 0) {
-		printk(KERN_ERR "ide-tape: Packet size (0x%02x) is not 12 "
-				"bytes long\n", packet_size);
+		printk(KERN_ERR "ide-tape: Packet size (0x%02x) is not 12"
+				" bytes\n", packet_size);
 	} else
 		return 1;
 	return 0;
-- 
1.5.3.7

