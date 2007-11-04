From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/18] ide-pmac: skip conservative PIO "downgrade"
Date: Mon, 5 Nov 2007 00:17:04 +0100
Message-ID: <200711050017.04599.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbXKDX3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:33 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219894nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Pettersson <mikpe@it.uu.se>, Benjamin Herrenschmidt <benh@kernel.crashing.org>



We can skip conservative PIO "downgrade" (PIO3 becomes PIO2 etc.) on PMAC.

Problem reported by Mikael.

Cc: Mikael Pettersson <mikpe@it.uu.se>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1133,6 +1133,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	hwif->drives[0].autotune = IDE_TUNE_AUTO;
 	hwif->drives[1].autotune = IDE_TUNE_AUTO;
 	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA |
+			   IDE_HFLAG_PIO_NO_DOWNGRADE |
 			   IDE_HFLAG_POST_SET_MODE;
 	hwif->pio_mask = ATA_PIO4;
 	hwif->set_pio_mode = pmac_ide_set_pio_mode;
