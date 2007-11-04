From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/18] ide: make 'extra' field in struct ide_port_info u8
Date: Mon, 5 Nov 2007 00:25:03 +0100
Message-ID: <200711050025.03967.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:52656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbXKDX3l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:41 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219889nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:41 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


The maximum value used currently for 'extra' field in struct ide_port_info
is 240.

Make 'extra' u8 so it packs nicely together with enablebits[] and 'chipset'
fields (ide_pci_enablebit_t is 3 bytes and hwif_chipset_t is 1 byte).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1111,7 +1111,7 @@ struct ide_port_info {
 	void			(*fixup)(ide_hwif_t *);
 	ide_pci_enablebit_t	enablebits[2];
 	hwif_chipset_t		chipset;
-	unsigned int		extra;
+	u8			extra;
 	u32			host_flags;
 	u8			pio_mask;
 	u8			swdma_mask;
