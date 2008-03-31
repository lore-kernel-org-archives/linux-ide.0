From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6.25 patch] ide/legacy/gayle.c: add MODULE_LICENSE
Date: Mon, 31 Mar 2008 12:07:57 +0300
Message-ID: <20080331090757.GL28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:51821 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756097AbYCaJIL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 05:08:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

Now that it can be built modular it needs a MODULE_LICENSE.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
4bd68e53bc0477dd694b87acacc27bac412b9bf4 diff --git a/drivers/ide/legacy/gayle.c b/drivers/ide/legacy/gayle.c
index b7d8109..e3b4638 100644
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -195,3 +195,5 @@ found:
 }
 
 module_init(gayle_init);
+
+MODULE_LICENSE("GPL");

