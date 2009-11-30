From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] slc90e66: fix UDMA handling
Date: Mon, 30 Nov 2009 19:55:18 +0100
Message-ID: <200911301955.18158.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:34914 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbZK3S4U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2009 13:56:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>

Fix checking of the currently programmed UDMA mode.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/slc90e66.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/ide/slc90e66.c
===================================================================
--- a/drivers/ide/slc90e66.c
+++ b/drivers/ide/slc90e66.c
@@ -92,8 +92,7 @@ static void slc90e66_set_dma_mode(ide_hw
 
 		if (!(reg48 & u_flag))
 			pci_write_config_word(dev, 0x48, reg48|u_flag);
-		/* FIXME: (reg4a & a_speed) ? */
-		if ((reg4a & u_speed) != u_speed) {
+		if ((reg4a & a_speed) != u_speed) {
 			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
 			pci_read_config_word(dev, 0x4a, &reg4a);
 			pci_write_config_word(dev, 0x4a, reg4a|u_speed);
