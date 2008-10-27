From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ali14xx: doesn't use shared IRQs
Date: Mon, 27 Oct 2008 20:57:22 +0100
Message-ID: <200810272057.22255.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:29609 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbYJ0UCl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 16:02:41 -0400
Received: by gv-out-0910.google.com with SMTP id e6so301593gvc.37
        for <linux-ide@vger.kernel.org>; Mon, 27 Oct 2008 13:02:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

init_irq() shouldn't use IRQF_SHARED for ali14xx IDE IRQ handler.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1123,8 +1123,7 @@ static int init_irq (ide_hwif_t *hwif)
 		sa = IRQF_SHARED;
 #endif /* __mc68000__ */
 
-		if (hwif->chipset == ide_pci || hwif->chipset == ide_cmd646 ||
-		    hwif->chipset == ide_ali14xx)
+		if (hwif->chipset == ide_pci || hwif->chipset == ide_cmd646)
 			sa = IRQF_SHARED;
 
 		if (io_ports->ctl_addr)
