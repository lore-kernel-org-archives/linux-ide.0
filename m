From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH v2] libata: Don't trust current capacity values in identify
 words 57-58
Date: Mon, 16 Feb 2009 20:15:08 -0600
Message-ID: <499A1DAC.6090200@gmail.com>
References: <4999CA54.1060306@gmail.com> <4999CFEB.3030204@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f222.google.com ([209.85.217.222]:53152 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbZBQCPM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2009 21:15:12 -0500
In-Reply-To: <4999CFEB.3030204@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, =?UTF-8?B?SGFubm8gQsO2Y2s=?= <hanno@hboeck.de>

Hanno B=C3=B6ck reported a problem where an old Conner CP30254 240MB ha=
rd drive
was reported as 1.1TB in capacity by libata:

http://lkml.org/lkml/2009/2/13/134

This was caused by libata trusting the drive's reported current capacit=
y in=20
sectors in identify words 57 and 58 if the drive does not support LBA a=
nd the
current CHS translation values appear valid. Unfortunately it seems old=
er
ATA specs were vague about what this field should contain and a number =
of drives
used values with wrong byte order or that were totally bogus. There's n=
o
unique information that it conveys and so we can just calculate the num=
ber
of sectors from the reported current CHS values.

While we're at it, clean up this function to use named constants for th=
e
identify word values.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9fbf059..33b5549 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1322,14 +1322,16 @@ static u64 ata_id_n_sectors(const u16 *id)
 {
 	if (ata_id_has_lba(id)) {
 		if (ata_id_has_lba48(id))
-			return ata_id_u64(id, 100);
+			return ata_id_u64(id, ATA_ID_LBA_CAPACITY_2);
 		else
-			return ata_id_u32(id, 60);
+			return ata_id_u32(id, ATA_ID_LBA_CAPACITY);
 	} else {
 		if (ata_id_current_chs_valid(id))
-			return ata_id_u32(id, 57);
+			return id[ATA_ID_CUR_CYLS] * id[ATA_ID_CUR_HEADS] *
+			       id[ATA_ID_CUR_SECTORS];
 		else
-			return id[1] * id[3] * id[6];
+			return id[ATA_ID_CYLS] * id[ATA_ID_HEADS] *
+			       id[ATA_ID_SECTORS];
 	}
 }
=20
