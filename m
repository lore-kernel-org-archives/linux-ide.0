From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] 2.6.x libata build fix
Date: Sun, 14 Nov 2004 05:24:02 -0500
Message-ID: <20041114102402.GA31550@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:21407 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261279AbUKNKZP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Nov 2004 05:25:15 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, hch@infradead.org


Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/sata_svw.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

through these ChangeSets:

<hch@lst.de> (04/11/14 1.2138)
   [PATCH] fix sata_svw compile
   
   Current BK doesn't compile with the G5 defconfig because the last
   libata updated missed to change sata_svw to the new conventions.
   
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-11-14 05:23:31 -05:00
+++ b/drivers/scsi/sata_svw.c	2004-11-14 05:23:31 -05:00
@@ -245,7 +245,7 @@
 		return 0;
 
 	/* Find the OF node for the PCI device proper */
-	np = pci_device_to_OF_node(ap->host_set->pdev);
+	np = pci_device_to_OF_node(to_pci_dev(ap->host_set->dev));
 	if (np == NULL)
 		return 0;
 
