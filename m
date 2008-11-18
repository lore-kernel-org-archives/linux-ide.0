From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide: remove "paranoia" checks for hwgroup->busy
Date: Tue, 18 Nov 2008 21:14:29 +0100
Message-ID: <200811182114.29226.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:14607 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbYKRUWV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Nov 2008 15:22:21 -0500
Received: by gv-out-0910.google.com with SMTP id e6so584263gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 12:22:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Elias Oltmanns <eo@nebensachen.de>

Remove "paranoia" checks for hwgroup->busy from ide_timer_expiry()
and ide_intr().  This is a preparation for future changes.

Cc: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Elias Oltmanns <eo@nebensachen.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against current pata-2.6 tree (should also apply fine to linux-next)

 drivers/ide/ide-io.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1018,10 +1018,7 @@ void ide_timer_expiry (unsigned long dat
 		} else {
 			ide_hwif_t *hwif;
 			ide_startstop_t startstop = ide_stopped;
-			if (!hwgroup->busy) {
-				hwgroup->busy = 1;	/* paranoia */
-				printk(KERN_ERR "%s: ide_timer_expiry: hwgroup->busy was 0 ??\n", drive->name);
-			}
+
 			if ((expiry = hwgroup->expiry) != NULL) {
 				/* continue */
 				if ((wait = expiry(drive)) > 0) {
@@ -1234,10 +1231,6 @@ irqreturn_t ide_intr (int irq, void *dev
 		 */
 		goto out;
 
-	if (!hwgroup->busy) {
-		hwgroup->busy = 1;	/* paranoia */
-		printk(KERN_ERR "%s: ide_intr: hwgroup->busy was 0 ??\n", drive->name);
-	}
 	hwgroup->handler = NULL;
 	hwgroup->req_gen++;
 	del_timer(&hwgroup->timer);
