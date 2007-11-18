From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/21] macide/q40ide: add missing __init tag to {macide,q40ide}_init()
Date: Sun, 18 Nov 2007 23:12:48 +0100
Message-ID: <200711182312.48921.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbXKRWgb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873016ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:31 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/macide.c |    2 +-
 drivers/ide/legacy/q40ide.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/legacy/macide.c
===================================================================
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -81,7 +81,7 @@ int macide_ack_intr(ide_hwif_t* hwif)
  * Probe for a Macintosh IDE interface
  */
 
-void macide_init(void)
+void __init macide_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
Index: b/drivers/ide/legacy/q40ide.c
===================================================================
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -111,7 +111,7 @@ static const char *q40_ide_names[Q40IDE_
  *  Probe for Q40 IDE interfaces
  */
 
-void q40ide_init(void)
+void __init q40ide_init(void)
 {
     int i;
     ide_hwif_t *hwif;
