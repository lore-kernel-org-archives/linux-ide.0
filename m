From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch ide-dev 6/9] check capacity in ide_task_init_flush()
Date: Thu, 24 Feb 2005 15:44:34 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0502241544040.13534@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:51105 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262360AbVBXOsD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 09:48:03 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54557 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S28363AbVBXOo6 (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 2 others); Thu, 24 Feb 2005 15:44:58 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Use WIN_FLUSH_CACHE_EXT only if disk requires LBA48.

diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-23 20:58:16 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-23 20:58:16 +01:00
@@ -61,7 +61,8 @@

 	memset(task, 0, sizeof(*task));

-	if (ide_id_has_flush_cache_ext(drive->id)) {
+	if (ide_id_has_flush_cache_ext(drive->id) &&
+	    (drive->capacity64 >= (1UL << 28))) {
 		tf->command = WIN_FLUSH_CACHE_EXT;
 		tf->flags |= ATA_TFLAG_LBA48;
 	} else
