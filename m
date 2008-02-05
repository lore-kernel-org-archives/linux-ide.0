From: akpm@linux-foundation.org
Subject: [patch 1/1] ata: drivers/ata/sata_mv.c needs dmapool.h
Date: Mon, 04 Feb 2008 23:43:44 -0800
Message-ID: <200802050743.m157hPsJ010259@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57159 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753053AbYBEHnh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 02:43:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org

From: Andrew Morton <akpm@linux-foundation.org>

mips:

drivers/ata/sata_mv.c: In function `mv_port_free_dma_mem':
drivers/ata/sata_mv.c:1080: error: implicit declaration of function `dma_pool_free'

Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/sata_mv.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/ata/sata_mv.c~ata-drivers-ata-sata_mvc-needs-dmapoolh drivers/ata/sata_mv.c
--- a/drivers/ata/sata_mv.c~ata-drivers-ata-sata_mvc-needs-dmapoolh
+++ a/drivers/ata/sata_mv.c
@@ -69,6 +69,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/dmapool.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
_
