From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide/libata: fix ata_id_is_cfa() (take 2)
Date: Tue, 27 Jan 2009 00:09:31 +0400
Message-ID: <200901262309.31771.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:19107 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751641AbZAZUJE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 15:09:04 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, gdu@mns.spb.ru

When checking for the CFA feature set support, ata_id_is_cfa() tests bit 2 in
word 82 of the identify data instead the word 83;  it also checks the ATA/PI
standard support in the word 80 -- which the CompactFlash specification has
as reserved, this having no slightest chance to work on CF drives that don't
have 0x848A in the word 0. Use instead the usual validity check: word 83 bit
14 must be set, bit 15 cleared.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch itself hasn't changed, only the description has.
I'm not sure who should queue this patch... it's against Linus' tree.

 include/linux/ata.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/ata.h
===================================================================
--- linux-2.6.orig/include/linux/ata.h
+++ linux-2.6/include/linux/ata.h
@@ -734,9 +734,8 @@ static inline int ata_id_is_cfa(const u1
 	if (id[ATA_ID_CONFIG] == 0x848A)	/* Standard CF */
 		return 1;
 	/* Could be CF hiding as standard ATA */
-	if (ata_id_major_version(id) >= 3 &&
-	    id[ATA_ID_COMMAND_SET_1] != 0xFFFF &&
-	   (id[ATA_ID_COMMAND_SET_1] & (1 << 2)))
+	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) == 0x4000 &&
+	    (id[ATA_ID_COMMAND_SET_2] & (1 << 2)))
 		return 1;
 	return 0;
 }

