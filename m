From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: [PATCH resend] ide: use printk_once
Date: Sun, 23 Aug 2009 20:26:11 +0200
Message-ID: <4A9189C3.2020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62122 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933448AbZHWS0M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Aug 2009 14:26:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: ide: use printk_once

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
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
