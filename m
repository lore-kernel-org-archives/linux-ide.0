From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6.25 patch] ide/cris/ide-cris.c: add MODULE_LICENSE
Date: Mon, 31 Mar 2008 12:07:52 +0300
Message-ID: <20080331090752.GJ28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:51815 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756068AbYCaJIH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 05:08:07 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

Now that it can be built modular it needs a MODULE_LICENSE.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
cbc5dc05788857e71ef988c835436d1eb523ebcb diff --git a/drivers/ide/cris/ide-cris.c b/drivers/ide/cris/ide-cris.c
index e79bf8f..c8ffbaf 100644
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -1067,3 +1067,5 @@ static void cris_dma_start(ide_drive_t *drive)
 }
 
 module_init(init_e100_ide);
+
+MODULE_LICENSE("GPL");

