From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/14] ide-h8300: use struct ide_port_info
Date: Tue, 10 Jun 2008 22:51:40 +0200
Message-ID: <20080610205140.18469.72633.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:30333 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751AbYFJUuE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:50:04 -0400
Received: by gv-out-0910.google.com with SMTP id e6so669647gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:50:02 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Convert the driver to use struct ide_port_info.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/h8300/ide-h8300.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -176,6 +176,10 @@ static inline void hwif_setup(ide_hwif_t
 	hwif->output_data = h8300_output_data;
 }
 
+static const struct ide_port_info h8300_port_info = {
+	.host_flags		= IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_NO_DMA,
+};
+
 static int __init h8300_ide_init(void)
 {
 	hw_regs_t hw;
@@ -201,12 +205,11 @@ static int __init h8300_ide_init(void)
 	index = hwif->index;
 	ide_init_port_hw(hwif, &hw);
 	hwif_setup(hwif);
-	hwif->host_flags = IDE_HFLAG_NO_IO_32BIT;
 	printk(KERN_INFO "ide%d: H8/300 generic IDE interface\n", index);
 
 	idx[0] = index;
 
-	ide_device_add(idx, NULL);
+	ide_device_add(idx, &h8300_port_info);
 
 	return 0;
 
