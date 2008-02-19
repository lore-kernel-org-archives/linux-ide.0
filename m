From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] libata: fix kernel-doc parameter warning
Date: Tue, 19 Feb 2008 13:43:21 -0800
Message-ID: <20080219134321.68047fa6.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:58089 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbYBSVrg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 16:47:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix libata kernel-doc parameter:

Warning(linux-2.6.25-rc2-git3//drivers/ata/libata-scsi.c:845): No description found for parameter 'rq'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.25-rc2-git3.orig/drivers/ata/libata-scsi.c
+++ linux-2.6.25-rc2-git3/drivers/ata/libata-scsi.c
@@ -828,7 +828,7 @@ static void ata_scsi_sdev_config(struct 
 
 /**
  *	atapi_drain_needed - Check whether data transfer may overflow
- *	@request: request to be checked
+ *	@rq: request to be checked
  *
  *	ATAPI commands which transfer variable length data to host
  *	might overflow due to application error or hardare bug.  This
