From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] drivers/ide/ide-io.c: make __ide_end_request() static
Date: Sat, 7 Jan 2006 19:14:15 +0100
Message-ID: <20060107181415.GN3774@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32773 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030531AbWAGSOQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jan 2006 13:14:16 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Since there's no longer any external user, we can make 
__ide_end_request() static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ide/ide-io.c |    5 ++---
 include/linux/ide.h  |    1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.15-mm2-full/include/linux/ide.h.old	2006-01-07 17:49:26.000000000 +0100
+++ linux-2.6.15-mm2-full/include/linux/ide.h	2006-01-07 17:49:31.000000000 +0100
@@ -1000,7 +1000,6 @@
 extern int noautodma;
 
 extern int ide_end_request (ide_drive_t *drive, int uptodate, int nrsecs);
-extern int __ide_end_request (ide_drive_t *drive, struct request *rq, int uptodate, int nrsecs);
 
 /*
  * This is used on exit from the driver to designate the next irq handler
--- linux-2.6.15-mm2-full/drivers/ide/ide-io.c.old	2006-01-07 17:49:38.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/ide/ide-io.c	2006-01-07 17:50:13.000000000 +0100
@@ -55,8 +55,8 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
-int __ide_end_request(ide_drive_t *drive, struct request *rq, int uptodate,
-		      int nr_sectors)
+static int __ide_end_request(ide_drive_t *drive, struct request *rq,
+			     int uptodate, int nr_sectors)
 {
 	int ret = 1;
 
@@ -94,7 +94,6 @@
 	}
 	return ret;
 }
-EXPORT_SYMBOL(__ide_end_request);
 
 /**
  *	ide_end_request		-	complete an IDE I/O

