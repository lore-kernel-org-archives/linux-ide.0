From: Ben Gardner <gardner.ben@gmail.com>
Subject: [PATCH] ata: Detect Delkin Devices compact flash
Date: Tue, 23 Feb 2010 12:41:22 -0600
Message-ID: <808c8e9d1002231041la0d2cd9y35e9bce347d4d2db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61712 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab0BWSlY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Feb 2010 13:41:24 -0500
Received: by wwf26 with SMTP id 26so881275wwf.19
        for <linux-ide@vger.kernel.org>; Tue, 23 Feb 2010 10:41:22 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

I have a Delkin Devices compact flash card that isn't being recognized using the
SATA/PATA drivers.
The card is recognized and works with the deprecated ATA drivers.

The error I am seeing is:
ata1.00: failed to IDENTIFY (device reports invalid type, err_mask=0x0)

I tracked it down to ata_id_is_cfa() in include/linux/ata.h.
The Delkin card has id[0] set to 0x844a and id[83] set to 0.
This isn't what the kernel expects and is probably incorrect.

The simplest work-around is to add a check for 0x844a to ata_id_is_cfa().

Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
---
--- linux-2.6.33-rc8.orig/include/linux/ata.h
+++ linux-2.6.33-rc8/include/linux/ata.h
@@ -841,7 +841,8 @@

 static inline int ata_id_is_cfa(const u16 *id)
 {
-	if (id[ATA_ID_CONFIG] == 0x848A)	/* Traditional CF */
+	if ((id[ATA_ID_CONFIG] == 0x848A) ||	/* Traditional CF */
+	    (id[ATA_ID_CONFIG] == 0x844A))	/* Delkin Devices CF */
 		return 1;
 	/*
 	 * CF specs don't require specific value in the word 0 anymore and yet
