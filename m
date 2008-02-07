From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] palm_bk3710: fix ide_unregister() usage
Date: Thu, 7 Feb 2008 15:42:00 +0100
Message-ID: <200802071542.00438.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:49613 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946AbYBGO3j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 09:29:39 -0500
Received: by wx-out-0506.google.com with SMTP id h31so3673520wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 06:29:37 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Anton Salnikov <asalnikov@ru.mvista.com>


Don't set 'restore' flag for ide_unregister() when initializing new
interface.

[ identical change as done to bast-ide/ide-cs/delkin_cb host drivers
  by commit 909f4369bca30f9a186316a3bf2b4a9c1e702a25 ]

Cc: Anton Salnikov <asalnikov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/palm_bk3710.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/arm/palm_bk3710.c
===================================================================
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -363,7 +363,7 @@ static int __devinit palm_bk3710_probe(s
 	i = hwif->index;
 
 	if (hwif->present)
-		ide_unregister(i, 0, 1);
+		ide_unregister(i, 0, 0);
 	else if (!hwif->hold)
 		ide_init_port_data(hwif, i);
 
