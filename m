From: Alan Cox <alan@redhat.com>
Subject: PATCH: Phil Copeland discovered ide-pnp hadn't been updated
Date: Mon, 16 Aug 2004 08:39:53 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040816123953.GA26430@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:41102 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267576AbUHPMkz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Aug 2004 08:40:55 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

--- drivers/ide/ide-pnp.c~	2004-08-16 13:36:35.531635600 +0100
+++ drivers/ide/ide-pnp.c	2004-08-16 13:36:35.531635600 +0100
@@ -57,7 +57,7 @@
 {
 	ide_hwif_t *hwif = pnp_get_drvdata(dev);
 	if (hwif) {
-		ide_unregister(hwif->index);
+		ide_unregister_hwif(hwif);
 	} else
 		printk(KERN_ERR "idepnp: Unable to remove device, please report.\n");
 }

Signed-off-by: Alan Cox


