From: Mark Hindley <mark@hindley.org.uk>
Subject: [PATCH] use ARRAY_SIZE in ide-cd.c
Date: Fri, 27 Jul 2007 19:10:39 +0100
Message-ID: <20070727181039.GC24098@hindley.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 83-216-141-215.markhi700.adsl.metronet.co.uk ([83.216.141.215]:4102
	"EHLO mx.hindley.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192AbXG0SYh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2007 14:24:37 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Hi,

ARY_LEN in ide-cd.{c,h} is an unnecessary duplication. Replace with generic ARRAY_SIZE from
kernel.h.

Mark


commit 195695d6135fcc4615b70883c8c1c3cc82c5633c
Author: Mark Hindley <mark@hindley.org.uk>
Date:   Fri Jul 27 18:55:33 2007 +0100

    Replace ARY_LEN with ARRAY_SIZE in drivers/ide/ide-cd.{c,h}.
    
    Signed-off-by: Mark Hindley <mark@hindley.org.uk>

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 252ab82..79ee92a 100644
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
+			int lo=0, mid, hi= ARRAY_SIZE (packet_command_texts);
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
