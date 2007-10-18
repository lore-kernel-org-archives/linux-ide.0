From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] ide: Fix cs5535 driver accessing beyond array boundary
Date: Thu, 18 Oct 2007 10:56:21 +1000
Message-ID: <20071018005624.DC749DDEAB@ozlabs.org>
References: <1192668978.21882.719539599813.qpush@grosgo>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:36527 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761447AbXJRA40 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 20:56:26 -0400
In-Reply-To: <1192668978.21882.719539599813.qpush@grosgo>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

The cs5535 use an incorrect construct to access the other drive
of a pair, causing it to access beyond an array boundary on non-0
interfaces. This fixes it by using the new ide_get_paired_drive()
hepler instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/ide/pci/cs5535.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-work/drivers/ide/pci/cs5535.c
===================================================================
--- linux-work.orig/drivers/ide/pci/cs5535.c	2007-10-18 10:43:39.000000000 +1000
+++ linux-work/drivers/ide/pci/cs5535.c	2007-10-18 10:44:00.000000000 +1000
@@ -84,7 +84,7 @@ static void cs5535_set_speed(ide_drive_t
 
 	/* Set the PIO timings */
 	if ((speed & XFER_MODE) == XFER_PIO) {
-		ide_drive_t *pair = &drive->hwif->drives[drive->dn ^ 1];
+		ide_drive_t *pair = ide_get_paired_drive(drive);
 		u8 cmd, pioa;
 
 		cmd = pioa = speed - XFER_PIO_0;
