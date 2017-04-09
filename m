From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] ide: use setup_timer
Date: Sun,  9 Apr 2017 09:41:32 +0800
Message-ID: <964230281324b7c18ec70296a8a3cd1caae13cb6.1490602149.git.geliangtang@gmail.com>
References: <0ff6e139159043e3416b0e5bc89e9aa5399bbb8e.1490601847.git.geliangtang@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36658 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbdDIBl7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 8 Apr 2017 21:41:59 -0400
In-Reply-To: <0ff6e139159043e3416b0e5bc89e9aa5399bbb8e.1490601847.git.geliangtang@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Use setup_timer() instead of init_timer() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/ide/ide-probe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index a74ae8df..0235625 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1183,9 +1183,7 @@ static void ide_init_port_data(ide_hwif_t *hwif, unsigned int index)
 
 	spin_lock_init(&hwif->lock);
 
-	init_timer(&hwif->timer);
-	hwif->timer.function = &ide_timer_expiry;
-	hwif->timer.data = (unsigned long)hwif;
+	setup_timer(&hwif->timer, &ide_timer_expiry, (unsigned long)hwif);
 
 	init_completion(&hwif->gendev_rel_comp);
 
-- 
2.9.3

