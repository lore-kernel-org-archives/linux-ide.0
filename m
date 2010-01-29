From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 25/68] it8213: always program control bits
Date: Fri, 29 Jan 2010 17:05:51 +0100
Message-ID: <20100129160551.21495.52656.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:53041 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab0A2QF6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2010 11:05:58 -0500
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] it8213: always program control bits

This matches behavior of libata pata_it8213 host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/it8213.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: b/drivers/ide/it8213.c
===================================================================
--- a/drivers/ide/it8213.c
+++ b/drivers/ide/it8213.c
@@ -55,15 +55,13 @@ static void it8213_set_pio_mode(ide_hwif
 	if (is_slave) {
 		master_data |=  0x4000;
 		master_data &= ~0x0070;
-		if (pio > 1)
-			master_data = master_data | (control << 4);
+		master_data = master_data | (control << 4);
 		pci_read_config_byte(dev, slave_port, &slave_data);
 		slave_data = slave_data & 0xf0;
 		slave_data = slave_data | (timings[pio][0] << 2) | timings[pio][1];
 	} else {
 		master_data &= ~0x3307;
-		if (pio > 1)
-			master_data = master_data | control;
+		master_data = master_data | control;
 		master_data = master_data | (timings[pio][0] << 12) | (timings[pio][1] << 8);
 	}
 	pci_write_config_word(dev, master_port, master_data);
