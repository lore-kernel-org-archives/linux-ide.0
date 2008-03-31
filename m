From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6.25 patch] ide/legacy/falconide.c: add MODULE_LICENSE
Date: Mon, 31 Mar 2008 12:08:01 +0300
Message-ID: <20080331090801.GN28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:55944 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756177AbYCaJIQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 05:08:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

Now that it can be built modular it needs a MODULE_LICENSE.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
b93638a40e3e3d7286c7cfb3254caa9dfe6a0e40 diff --git a/drivers/ide/legacy/falconide.c b/drivers/ide/legacy/falconide.c
index 8949ce7..e950afa 100644
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -93,3 +93,5 @@ static int __init falconide_init(void)
 }
 
 module_init(falconide_init);
+
+MODULE_LICENSE("GPL");

