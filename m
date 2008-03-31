From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6.25 patch] ide-pnp.c: add MODULE_LICENSE
Date: Mon, 31 Mar 2008 12:07:38 +0300
Message-ID: <20080331090738.GE28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:54007 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594AbYCaJHx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 05:07:53 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

Now that it's in an own module it needs a MODULE_LICENSE.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
02ad186399ae21a561044df043732ffddc40f9b2 diff --git a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
index b163b2e..c14bb53 100644
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -86,3 +86,5 @@ static void __exit pnpide_exit(void)
 
 module_init(pnpide_init);
 module_exit(pnpide_exit);
+
+MODULE_LICENSE("GPL");

