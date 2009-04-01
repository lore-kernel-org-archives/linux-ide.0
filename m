From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide-h8300: remove mm_{inw|outw}()
Date: Wed, 1 Apr 2009 21:34:51 +0400
Message-ID: <200904012134.51604.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:49560 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752316AbZDAReX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 13:34:23 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Remove two no longer used functions that I've overlooked...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the pata-2.6 series...

 drivers/ide/ide-h8300.c |   22 ----------------------
 1 files changed, 22 deletions(-)

Index: linux-2.6/drivers/ide/ide-h8300.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-h8300.c
+++ linux-2.6/drivers/ide/ide-h8300.c
@@ -22,28 +22,6 @@
 	(r);				\
 })
 
-static void mm_outw(u16 d, unsigned long a)
-{
-	__asm__("mov.b %w0,r2h\n\t"
-		"mov.b %x0,r2l\n\t"
-		"mov.w r2,@%1"
-		:
-		:"r"(d),"r"(a)
-		:"er2");
-}
-
-static u16 mm_inw(unsigned long a)
-{
-	register u16 r __asm__("er0");
-	__asm__("mov.w @%1,r2\n\t"
-		"mov.b r2l,%x0\n\t"
-		"mov.b r2h,%w0"
-		:"=r"(r)
-		:"r"(a)
-		:"er2");
-	return r;
-}
-
 static void h8300_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	ide_hwif_t *hwif = drive->hwif;

