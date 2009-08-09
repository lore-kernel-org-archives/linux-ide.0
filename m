From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: [PATCH 09/14] ide: use printk_once
Date: Sun,  9 Aug 2009 21:54:04 +0200
Message-ID: <1249847649-11631-10-git-send-email-marcin.slusarz@gmail.com>
References: <1249847649-11631-1-git-send-email-marcin.slusarz@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:46204 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbZHITyx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 15:54:53 -0400
In-Reply-To: <1249847649-11631-1-git-send-email-marcin.slusarz@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-proc.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 3242698..6e58e7e 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -236,14 +236,8 @@ static const struct ide_proc_devset ide_generic_settings[] = {
 
 static void proc_ide_settings_warn(void)
 {
-	static int warned;
-
-	if (warned)
-		return;
-
-	printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
+	printk_once(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
 			    "obsolete, and will be removed soon!\n");
-	warned = 1;
 }
 
 static int proc_ide_read_settings
-- 
1.6.3.3

