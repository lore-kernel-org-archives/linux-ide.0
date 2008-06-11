From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] opti621: remove DMA support
Date: Wed, 11 Jun 2008 21:58:18 +0200
Message-ID: <200806112158.18354.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:60265 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbYFKU0J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 16:26:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2234733fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 13:26:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Juergen Kosel <juergen.kosel@gmx.de>

These controllers don't support DMA.

Based on a bugreport from Juergen Kosel & inspired by pata_opti.c code.

Tested-by: Juergen Kosel <juergen.kosel@gmx.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/opti621.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -324,18 +324,14 @@ static const struct ide_port_info opti62
 		.name		= "OPTI621",
 		.enablebits	= { {0x45, 0x80, 0x00}, {0x40, 0x08, 0x00} },
 		.port_ops	= &opti621_port_ops,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
+		.host_flags	= IDE_HFLAG_NO_DMA,
 		.pio_mask	= ATA_PIO3,
-		.swdma_mask	= ATA_SWDMA2,
-		.mwdma_mask	= ATA_MWDMA2,
 	}, {	/* 1 */
 		.name		= "OPTI621X",
 		.enablebits	= { {0x45, 0x80, 0x00}, {0x40, 0x08, 0x00} },
 		.port_ops	= &opti621_port_ops,
-		.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA,
+		.host_flags	= IDE_HFLAG_NO_DMA,
 		.pio_mask	= ATA_PIO3,
-		.swdma_mask	= ATA_SWDMA2,
-		.mwdma_mask	= ATA_MWDMA2,
 	}
 };
 
