From: akpm@linux-foundation.org
Subject: [patch 07/20] pata_pcmcia: recognize 2GB CompactFlash from Transcend
Date: Thu, 10 May 2007 22:48:48 -0700
Message-ID: <200705110548.l4B5mmj0007633@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:46436 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758131AbXEKFtc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:49:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, Fabrice.Aeschbacher@siemens.com, alan@redhat.com, bzolnier@gmail.com, fabrice.aeschbacher@siemens.com, stuge-linux-pcmcia@cdy.org

From: "Aeschbacher, Fabrice" <Fabrice.Aeschbacher@siemens.com>

Allow the pata_pcmcia driver to automatically detect 2GB CompactFlash cards
from Transcend.

Signed-off-by: Fabrice Aeschbacher <fabrice.aeschbacher@siemens.com>
Cc: "Peter Stuge" <stuge-linux-pcmcia@cdy.org>
Acked-by: Alan Cox <alan@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_pcmcia.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/ata/pata_pcmcia.c~pata_pcmcia-recognize-2gb-compactflash-from-transcend drivers/ata/pata_pcmcia.c
--- a/drivers/ata/pata_pcmcia.c~pata_pcmcia-recognize-2gb-compactflash-from-transcend
+++ a/drivers/ata/pata_pcmcia.c
@@ -397,6 +397,7 @@ static struct pcmcia_device_id pcmcia_de
 	PCMCIA_DEVICE_PROD_ID12("TOSHIBA", "MK2001MPL", 0xb4585a1a, 0x3489e003),
 	PCMCIA_DEVICE_PROD_ID1("TRANSCEND    512M   ", 0xd0909443),
 	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS1GCF80", 0x709b1bf1, 0x2a54d4b1),
+	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS2GCF120", 0x709b1bf1, 0x969aa4f2),
 	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS4GCF120", 0x709b1bf1, 0xf54a91c8),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
 	PCMCIA_DEVICE_PROD_ID12("WEIDA", "TWTTI", 0xcc7cf69c, 0x212bb918),
_
