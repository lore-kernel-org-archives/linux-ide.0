From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] pata_pdc202xx_old: fix UDMA mode for PDC2026x chipsets
Date: Sat, 13 Feb 2010 14:35:59 +0100
Message-ID: <20100213133559.11564.54028.sendpatchset@localhost>
References: <20100213133538.11564.94218.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:38074 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701Ab0BMNoX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Feb 2010 08:44:23 -0500
In-Reply-To: <20100213133538.11564.94218.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_pdc202xx_old: fix UDMA mode for PDC2026x chipsets

PDC2026x chipsets need the same treatment as PDC20246 one.

This is completely untested but will hopefully fix UDMA issues
that people have been reporting against pata_pdc202xx_old for
the last couple of years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_pdc202xx_old.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_pdc202xx_old.c
===================================================================
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -26,7 +26,7 @@
 
 #include "pata_pdc202xx_old.h"
 
-static void pdc20246_exec_command(struct ata_port *ap,
+static void pdc202xx_exec_command(struct ata_port *ap,
 				  const struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
@@ -181,7 +181,7 @@ static struct ata_port_operations pdc202
 	.set_piomode		= pdc202xx_set_piomode,
 	.set_dmamode		= pdc202xx_set_dmamode,
 
-	.sff_exec_command	= pdc20246_exec_command,
+	.sff_exec_command	= pdc202xx_exec_command,
 };
 
 static struct ata_port_operations pdc2026x_port_ops = {
