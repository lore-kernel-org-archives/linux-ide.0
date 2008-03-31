From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6.25 patch] ide/pci/cmd640.c: add MODULE_LICENSE
Date: Mon, 31 Mar 2008 12:07:40 +0300
Message-ID: <20080331090740.GF28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:55916 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841AbYCaJH4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 05:07:56 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

Now that it can be built it needs a MODULE_LICENSE.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
0003c773de94ff762c2a774ad784836bc6f13eb9 diff --git a/drivers/ide/pci/cmd640.c b/drivers/ide/pci/cmd640.c
index ec66798..29fbc5e 100644
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -881,3 +881,5 @@ module_param_named(probe_vlb, cmd640_vlb, bool, 0);
 MODULE_PARM_DESC(probe_vlb, "probe for VLB version of CMD640 chipset");
 
 module_init(cmd640x_init);
+
+MODULE_LICENSE("GPL");
