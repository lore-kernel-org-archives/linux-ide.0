From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] libata: Don't trust current capacity values in identify words
 57-58
Date: Mon, 16 Feb 2009 14:19:32 -0600
Message-ID: <4999CA54.1060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.180]:52581 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbZBPUUE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2009 15:20:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Mark Lord <liml@rtr.ca>, =?UTF-8?B?SGFubm8gQsO2Y2s=?= <hanno@hboeck.de>

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

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

---

Should likely go into -next for testing for a while. Of course, the fac=
t that
this problem showed up in the first place shows that the number of peop=
le
that test libata with such boat anchors is fairly small :-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9fbf059..5389cbc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1327,7 +1327,7 @@ static u64 ata_id_n_sectors(const u16 *id)
 			return ata_id_u32(id, 60);
 	} else {
 		if (ata_id_current_chs_valid(id))
-			return ata_id_u32(id, 57);
+			return id[54] * id[55] * id[56];
 		else
 			return id[1] * id[3] * id[6];
 	}


