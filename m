From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 8/13] ide hotplug mark __devinit opti621.c
Date: Sun, 26 Jun 2005 18:47:06 +0200
Message-ID: <20050626164706.GO12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:61367 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261461AbVFZRFF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:05:05 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

mark the __init section __devinit.
Splitted up from the Debian kernel patch. 


Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -aurN a/drivers/ide/pci/opti621.c b/drivers/ide/pci/opti621.c
--- a/drivers/ide/pci/opti621.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/opti621.c	2005-06-15 22:01:23.000000000 -0400
@@ -326,7 +326,7 @@
 /*
  * init_hwif_opti621() is called once for each hwif found at boot.
  */
-static void __init init_hwif_opti621 (ide_hwif_t *hwif)
+static void __devinit init_hwif_opti621 (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 	hwif->drives[0].drive_data = PIO_DONT_KNOW;
