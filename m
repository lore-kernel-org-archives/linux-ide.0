From: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: [PATCH] Replace C code with call to ARRAY_SIZE() macro.
Date: Sun, 3 Jun 2007 13:43:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706031339110.24621@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nic.NetDirect.CA ([216.16.235.2]:54762 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbXFCRos (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jun 2007 13:44:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org


Delete the unnecessary macro ARY_LEN and use ARRAY_SIZE directly.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

 drivers/ide/ide-cd.c |    6 +++---
 drivers/ide/ide-cd.h |    2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 252ab82..1486eb2 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -481,7 +481,7 @@ void cdrom_analyze_sense_data(ide_drive_t *drive,
 		else
 			printk("  Unknown Error Type: ");

-		if (sense->sense_key < ARY_LEN(sense_key_texts))
+		if (sense->sense_key < ARRAY_SIZE(sense_key_texts))
 			s = sense_key_texts[sense->sense_key];

 		printk("%s -- (Sense key=0x%02x)\n", s, sense->sense_key);
@@ -491,7 +491,7 @@ void cdrom_analyze_sense_data(ide_drive_t *drive,
 				 sense->ascq);
 			s = buf;
 		} else {
-			int lo = 0, mid, hi = ARY_LEN(sense_data_texts);
+			int lo = 0, mid, hi = ARRAY_SIZE(sense_data_texts);
 			unsigned long key = (sense->sense_key << 16);
 			key |= (sense->asc << 8);
 			if (!(sense->ascq >= 0x80 && sense->ascq <= 0xdd))
@@ -524,7 +524,7 @@ void cdrom_analyze_sense_data(ide_drive_t *drive,

 		if (failed_command != NULL) {

-			int lo=0, mid, hi= ARY_LEN (packet_command_texts);
+			int lo=0, mid, hi= ARRAY_SIZE(packet_command_texts);
 			s = NULL;

 			while (hi > lo) {
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index ad1f2ed..228b29c 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -498,8 +498,6 @@ struct cdrom_info {
  * Descriptions of ATAPI error codes.
  */

-#define ARY_LEN(a) ((sizeof(a) / sizeof(a[0])))
-
 /* This stuff should be in cdrom.h, since it is now generic... */

 /* ATAPI sense keys (from table 140 of ATAPI 2.6) */
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
