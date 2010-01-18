From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/64] pata_cs5535: use correct values for PIO1 and PIO2 data timings
Date: Mon, 18 Jan 2010 18:15:38 +0100
Message-ID: <20100118171538.14623.27441.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:53275 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab0ARRQw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:16:52 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cs5535: use correct values for PIO1 and PIO2 data timings

There shouldn't be any problems with it as IDE cs5535 host driver
has been using those values for years and they match values given
in the (publicly available) datasheet.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cs5535.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_cs5535.c
===================================================================
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -98,7 +98,7 @@ static int cs5535_cable_detect(struct at
 static void cs5535_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	static const u16 pio_timings[5] = {
-		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
+		0xF7F4, 0xF173, 0x8141, 0x5131, 0x1131
 	};
 	static const u16 pio_cmd_timings[5] = {
 		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
