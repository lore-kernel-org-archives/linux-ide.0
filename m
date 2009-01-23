From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Fri, 23 Jan 2009 17:15:37 +0400
Message-ID: <200901231615.38011.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:58224 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755402AbZAWNPH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2009 08:15:07 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, gdu@mns.spb.ru

When checking for CFA feature set support, ata_id_is_cfa() tests bit 2 in word
82 of the identify data instead the word 83.  It also checks the ATA revision
in the  word 80 instead of usual validity check for the words 82-83 -- word 83
bit 14 set, bit 15 cleared.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
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

