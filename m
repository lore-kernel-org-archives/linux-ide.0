From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch ide] fix ide_get_error_location() for LBA28
Date: Sun, 20 Feb 2005 12:34:14 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0502201230250.5252@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:33250 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261816AbVBTLo1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Feb 2005 06:44:27 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:61785 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S29879AbVBTLe0 (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 2 others); Sun, 20 Feb 2005 12:34:26 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@suse.de


Higher bits (16-23) of the address were ignored

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-19 17:38:53 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-19 17:38:53 +01:00
@@ -238,9 +238,10 @@
 		high = ide_read_24(drive);
 	} else {
 		u8 cur = HWIF(drive)->INB(IDE_SELECT_REG);
-		if (cur & 0x40)
+		if (cur & 0x40) {
+			high = cur & 0xf;
 			low = (hcyl << 16) | (lcyl << 8) | sect;
-		else {
+		} else {
 			low = hcyl * drive->head * drive->sect;
 			low += lcyl * drive->sect;
 			low += sect - 1;
