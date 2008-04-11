From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make ali_atapi_dma static
Date: Fri, 11 Apr 2008 20:28:27 +0300
Message-ID: <20080411172827.GC25788@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761489AbYDKR3i@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This patch makes the needlessly global ali_atapi_dma static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
de012fdf57e025cf243181cb3fce87f890ccc955 diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index ce830fe..511a830 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -36,7 +36,7 @@
 #define DRV_NAME "pata_ali"
 #define DRV_VERSION "0.7.5"
 
-int ali_atapi_dma = 0;
+static int ali_atapi_dma = 0;
 module_param_named(atapi_dma, ali_atapi_dma, int, 0644);
 MODULE_PARM_DESC(atapi_dma, "Enable ATAPI DMA (0=disable, 1=enable)");
 
