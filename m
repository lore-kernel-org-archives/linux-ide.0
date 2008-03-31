From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6.25 patch] ide/ppc/mpc8xx.c: add MODULE_LICENSE
Date: Mon, 31 Mar 2008 12:07:43 +0300
Message-ID: <20080331090743.GG28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:51804 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216AbYCaJH6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 05:07:58 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

Now that it can be built modular it needs a MODULE_LICENSE.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
6697627a251c333407e8df17f34edabc7e9b2d22 diff --git a/drivers/ide/ppc/mpc8xx.c b/drivers/ide/ppc/mpc8xx.c
index 38fbfb8..ebaba01 100644
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -853,3 +853,5 @@ static int __init mpc8xx_ide_probe(void)
 }
 
 module_init(mpc8xx_ide_probe);
+
+MODULE_LICENSE("GPL");
