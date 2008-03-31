From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6.25 patch] ide/legacy/buddha.c: add MODULE_LICENSE
Date: Mon, 31 Mar 2008 12:07:59 +0300
Message-ID: <20080331090759.GM28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:54075 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756164AbYCaJIO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 05:08:14 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

Now that it can be built modular it needs a MODULE_LICENSE.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
ad95e79a38660c07764910df78924adc877f609a diff --git a/drivers/ide/legacy/buddha.c b/drivers/ide/legacy/buddha.c
index 50ffa87..fdd3791 100644
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -241,3 +241,5 @@ fail_base2:
 }
 
 module_init(buddha_init);
+
+MODULE_LICENSE("GPL");

