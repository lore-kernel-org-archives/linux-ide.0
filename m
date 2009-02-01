From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide/libata: fix ata_id_is_cfa() (take 4)
Date: Sun, 1 Feb 2009 20:43:36 +0400
Message-ID: <200902011943.36880.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:46544 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752297AbZBAQnM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 11:43:12 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, gdu@mns.spb.ru

When checking for the CFA feature set support, ata_id_is_cfa() tests bit 2 in
word 82 of the identify data instead the word 83;  it also checks the ATA/PI
version support in the word 80 (which the CompactFlash specifications have as
reserved), this having no slightest chance to work on the modern CF cards that
don't have 0x848A in the word 0...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
So, here's fourth version of this simplistic patch. I've dropped the paranoid
ATA version check since apparently not all cards follow the CF spec. in this
respect and it seems wrong to blacklist a card that does report CFA support.

 include/linux/ata.h |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6/include/linux/ata.h
===================================================================
--- linux-2.6.orig/include/linux/ata.h
+++ linux-2.6/include/linux/ata.h
@@ -731,12 +731,17 @@ static inline int ata_id_current_chs_val
 
 static inline int ata_id_is_cfa(const u16 *id)
 {
-	if (id[ATA_ID_CONFIG] == 0x848A)	/* Standard CF */
+	if (id[ATA_ID_CONFIG] == 0x848A)	/* Traditional CF */
 		return 1;
-	/* Could be CF hiding as standard ATA */
-	if (ata_id_major_version(id) >= 3 &&
-	    id[ATA_ID_COMMAND_SET_1] != 0xFFFF &&
-	   (id[ATA_ID_COMMAND_SET_1] & (1 << 2)))
+	/*
+	 * CF specs don't require specific value in the word 0 anymore and yet
+	 * they forbid to report the ATA version in the word 80 and require the
+	 * CFA feature set support to be indicated in the word 83 in this case.
+	 * Unfortunately, some cards only follow either of this requirements,
+	 * and while those that don't indicated CFA feature support, need some
+	 * sort of quirk list, it seems impractical for the ones that do...
+	 */
+	if ((id[ATA_ID_COMMAND_SET_2] & 0xC004) == 0x4004)
 		return 1;
 	return 0;
 }

