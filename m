From: Olaf Hering <olh@suse.de>
Subject: [PATCH] add missing space to printk in ide_allocate_dma_engine
Date: Wed, 2 Feb 2005 21:36:52 +0100
Message-ID: <20050202203652.GA14615@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Received: from mail-ex.suse.de ([195.135.220.2]:17344 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262437AbVBBUgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 15:36:53 -0500
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 2A6A413F419F
	for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2005 21:36:53 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


a space is missing.


diff -p -purN linux-2.6.11-rc2.orig/drivers/ide/ide-dma.c linux-2.6.11-rc2/drivers/ide/ide-dma.c
--- linux-2.6.11-rc2.orig/drivers/ide/ide-dma.c	2005-01-22 02:48:03.000000000 +0100
+++ linux-2.6.11-rc2/drivers/ide/ide-dma.c	2005-02-02 21:32:55.000000000 +0100
@@ -829,7 +829,7 @@ int ide_allocate_dma_engine (ide_hwif_t 
 	if (hwif->dmatable_cpu)
 		return 0;
 
-	printk(KERN_ERR "%s: -- Error, unable to allocate%s DMA table(s).\n",
+	printk(KERN_ERR "%s: -- Error, unable to allocate %s DMA table(s).\n",
 		(hwif->dmatable_cpu == NULL) ? " CPU" : "",
 		hwif->cds->name);
 
