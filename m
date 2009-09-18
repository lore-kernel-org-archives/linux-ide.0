From: akpm@linux-foundation.org
Subject: [patch 1/1] ide: use printk_once
Date: Fri, 18 Sep 2009 12:49:48 -0700
Message-ID: <200909181949.n8IJnmBN019766@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49796 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752377AbZIRT4F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Sep 2009 15:56:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, marcin.slusarz@gmail.com, bzolnier@gmail.com

From: Marcin Slusarz <marcin.slusarz@gmail.com>

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ide/ide-proc.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff -puN drivers/ide/ide-proc.c~ide-use-printk_once drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c~ide-use-printk_once
+++ a/drivers/ide/ide-proc.c
@@ -273,14 +273,8 @@ static const struct ide_proc_devset ide_
 
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
 
 static int ide_settings_proc_show(struct seq_file *m, void *v)
_
