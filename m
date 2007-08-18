From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/7] ide: remove "idex=dma" kernel parameter
Date: Sat, 18 Aug 2007 20:48:35 +0200
Message-ID: <200708182048.35285.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:64200 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014AbXHRTTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:19:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1246464mue
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 12:19:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


It has been obsoleted since 1 Nov 2004, is valid only when used together with
"ide=nodma" kernel parameter (which makes no sense) and only for aec62xx,
cmd64x, cs5220, generic, hpt366, sl82c105, tc86c001 and triflex host drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/ide.txt |    2 --
 drivers/ide/ide.c     |    6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

Index: b/Documentation/ide.txt
===================================================================
--- a/Documentation/ide.txt
+++ b/Documentation/ide.txt
@@ -278,8 +278,6 @@ Summary of ide driver parameters for ker
  "idex=four"		: four drives on idex and ide(x^1) share same ports
 			
  "idex=reset"		: reset interface after probe
- 
- "idex=dma"		: automatically configure/use DMA if possible.
 
  "idex=ata66"		: informs the interface that it has an 80c cable
 			  for chipsets that are ATA-66 capable, but the
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1398,7 +1398,7 @@ static int __init ide_setup(char *s)
 		 */
 		static const char *ide_words[] = {
 			"noprobe", "serialize", "minus3", "minus4",
-			"reset", "dma", "ata66", "minus8", "minus9",
+			"reset", "minus6", "ata66", "minus8", "minus9",
 			"minus10", "four", "qd65xx", "ht6560b", "cmd640_vlb",
 			"dtc2278", "umc8672", "ali14xx", NULL };
 		hw = s[3] - '0';
@@ -1477,6 +1477,7 @@ static int __init ide_setup(char *s)
 			case -10: /* minus10 */
 			case -9: /* minus9 */
 			case -8: /* minus8 */
+			case -6:
 			case -4:
 			case -3:
 				goto bad_option;
@@ -1491,9 +1492,6 @@ static int __init ide_setup(char *s)
 #else
 				goto bad_hwif;
 #endif
-			case -6: /* dma */
-				hwif->autodma = 1;
-				goto obsolete_option;
 			case -5: /* "reset" */
 				hwif->reset = 1;
 				goto obsolete_option;
