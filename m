From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 9/13] ide hotplug mark __devinit sc1200.c
Date: Sun, 26 Jun 2005 18:47:16 +0200
Message-ID: <20050626164716.GP12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:53175 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261448AbVFZRE4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:04:56 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

  
mark the __init section __devinit.
Splitted up from the Debian kernel patch. 


Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -aurN a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
--- a/drivers/ide/pci/sc1200.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/sc1200.c	2005-06-15 22:01:23.000000000 -0400
@@ -459,7 +459,7 @@
  * This gets invoked by the IDE driver once for each channel,
  * and performs channel-specific pre-initialization before drive probing.
  */
-static void __init init_hwif_sc1200 (ide_hwif_t *hwif)
+static void __devinit init_hwif_sc1200 (ide_hwif_t *hwif)
 {
 	if (hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
