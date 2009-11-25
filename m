From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 37/86] pata_it8213: fix wrong PIO timings being programmed
Date: Wed, 25 Nov 2009 18:06:44 +0100
Message-ID: <20091125170644.5446.73492.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42882 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbZKYRHV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:07:21 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_it8213: fix wrong PIO timings being programmed

* do not clear PIO timings for master when programming slave
* program new PIO timings in the correct register nibble

Both changes should be safe as this is how we have been doing
things in IDE it8213 host driver for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_it8213.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_it8213.c
===================================================================
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -112,13 +112,13 @@ static void it8213_set_piomode (struct a
 	} else {
 		u8 slave_data;
 
-		idetm_data &= 0xCC0F;
+		idetm_data &= 0xFF0F;
 		idetm_data |= (control << 4);
 
 		/* Slave timing in separate register */
 		pci_read_config_byte(dev, 0x44, &slave_data);
 		slave_data &= 0xF0;
-		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << 4;
+		slave_data |= (timings[pio][0] << 2) | timings[pio][1];
 		pci_write_config_byte(dev, 0x44, slave_data);
 	}
 
