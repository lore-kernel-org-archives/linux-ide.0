From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 17/22] ide-tape: collect module-related macro calls at the end
Date: Mon,  4 Feb 2008 14:40:35 +0100
Message-ID: <1202132440-26648-18-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:19005 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049AbYBDNmg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:42:36 -0500
Received: by py-out-1112.google.com with SMTP id u52so3286457pyb.10
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:42:34 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 24f048f..cfcf5b0 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -3681,9 +3681,6 @@ failed:
 	return -ENODEV;
 }
 
-MODULE_DESCRIPTION("ATAPI Streaming TAPE Driver");
-MODULE_LICENSE("GPL");
-
 static void __exit idetape_exit (void)
 {
 	driver_unregister(&idetape_driver.gen_driver);
@@ -3726,3 +3723,5 @@ MODULE_ALIAS("ide:*m-tape*");
 module_init(idetape_init);
 module_exit(idetape_exit);
 MODULE_ALIAS_CHARDEV_MAJOR(IDETAPE_MAJOR);
+MODULE_DESCRIPTION("ATAPI Streaming TAPE Driver");
+MODULE_LICENSE("GPL");
-- 
1.5.3.7

