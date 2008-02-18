From: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Subject: [PATCH] ht6560b can only do up to PIO mode 4
Date: Mon, 18 Feb 2008 14:58:20 +0100
Message-ID: <47B98EFC.8080507@caiway.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040405020105030802010703"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pelian.kabelfoon.nl ([62.45.45.43]:53386 "EHLO
	pelian.kabelfoon.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYBRN6V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 08:58:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@gmail.com

This is a multi-part message in MIME format.
--------------040405020105030802010703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

According to the datasheet, ht6560b only supports up to PIO mode 4.

Signed-off-by: Jan Evert van Grootheest <janevert@caiway.nl>


--------------040405020105030802010703
Content-Type: text/x-patch;
 name="ht.pio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ht.pio.patch"

--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -343,7 +343,7 @@ int __init ht6560b_init(void)
 	hwif->chipset = ide_ht6560b;
 	hwif->selectproc = &ht6560b_selectproc;
 	hwif->host_flags = IDE_HFLAG_ABUSE_PREFETCH;
-	hwif->pio_mask = ATA_PIO5;
+	hwif->pio_mask = ATA_PIO4;
 	hwif->set_pio_mode = &ht6560b_set_pio_mode;
 	hwif->serialized = 1;	/* is this needed? */
 	hwif->mate = mate;
@@ -351,7 +351,7 @@ int __init ht6560b_init(void)
 	mate->chipset = ide_ht6560b;
 	mate->selectproc = &ht6560b_selectproc;
 	mate->host_flags = IDE_HFLAG_ABUSE_PREFETCH;
-	mate->pio_mask = ATA_PIO5;
+	mate->pio_mask = ATA_PIO4;
 	mate->set_pio_mode = &ht6560b_set_pio_mode;
 	mate->serialized = 1;	/* is this needed? */
 	mate->mate = hwif;


--------------040405020105030802010703--
