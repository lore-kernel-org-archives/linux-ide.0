From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH] ide: fix serverworks.c UDMA regression
Date: Mon, 15 Oct 2007 15:05:30 -0400
Message-ID: <4713B9FA.8050803@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host06.cybernetics.com ([206.246.200.22]:4628 "EHLO
	mail.cybernetics.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1759894AbXJOT1u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 15:27:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

The patch described by the following excerpt from ChangeLog-2.6.22 makes
it impossible to use UDMA on a Tyan S2707 motherboard (SvrWks CSB5):

commit 2d5eaa6dd744a641e75503232a01f52d0768884c
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Thu May 10 00:01:08 2007 +0200

    ide: rework the code for selecting the best DMA transfer mode (v3)

    ...

This one-line patch against 2.6.23 fixes the problem.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
--- linux-2.6.23/drivers/ide/pci/serverworks.c.orig	2007-10-15 12:15:01.000000000 -0400
+++ linux-2.6.23/drivers/ide/pci/serverworks.c	2007-10-15 13:47:29.000000000 -0400
@@ -97,6 +97,7 @@ static u8 svwks_udma_filter(ide_drive_t 
 			mode = 2;
 
 		switch(mode) {
+		case 3:	 mask = 0x3f; break;
 		case 2:	 mask = 0x1f; break;
 		case 1:	 mask = 0x07; break;
 		default: mask = 0x00; break;


