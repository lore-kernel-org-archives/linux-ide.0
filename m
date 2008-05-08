From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] ide: use ->OUTBSYNC in init_irq()
Date: Thu, 8 May 2008 21:36:19 +0200
Message-ID: <200805082136.19742.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:25235 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbYEHTV4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 15:21:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so617346fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 12:21:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1068,7 +1068,7 @@ static int init_irq (ide_hwif_t *hwif)
 
 		if (io_ports->ctl_addr)
 			/* clear nIEN */
-			hwif->OUTB(0x08, io_ports->ctl_addr);
+			hwif->OUTBSYNC(hwif, 0x08, io_ports->ctl_addr);
 
 		if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup))
 	       		goto out_unlink;
