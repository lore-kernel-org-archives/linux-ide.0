From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] libata-core: fix kernel-doc warning
Date: Fri, 22 Feb 2008 12:21:37 -0800
Message-ID: <20080222122137.bd81d2a0.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:62581 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758793AbYBVUXg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 15:23:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix libata-core kernel-doc warning:
Warning(linux-2.6.25-rc2-git6//drivers/ata/libata-core.c:168): No description found for parameter 'ap'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.25-rc2-git6.orig/drivers/ata/libata-core.c
+++ linux-2.6.25-rc2-git6/drivers/ata/libata-core.c
@@ -153,7 +153,7 @@ MODULE_VERSION(DRV_VERSION);
 
 /**
  *	ata_force_cbl - force cable type according to libata.force
- *	@link: ATA link of interest
+ *	@ap: ATA port of interest
  *
  *	Force cable type according to libata.force and whine about it.
  *	The last entry which has matching port number is used, so it
