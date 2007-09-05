From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/13] triflex: always tune PIO
Date: Wed, 5 Sep 2007 23:56:33 +0200
Message-ID: <200709052356.33887.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65431 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbXIEV67 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:59 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828117nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/triflex.c |    3 +++
 1 file changed, 3 insertions(+)

Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -100,6 +100,9 @@ static void __devinit init_hwif_triflex(
 {
 	hwif->set_pio_mode = &triflex_set_pio_mode;
 	hwif->set_dma_mode = &triflex_set_mode;
+
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
 }
 
 static ide_pci_device_t triflex_device __devinitdata = {
