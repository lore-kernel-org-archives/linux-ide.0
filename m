From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] libata: kernel-doc fix
Date: Fri, 16 Mar 2007 19:55:47 -0700
Message-ID: <20070316195547.cd3bb5ca.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:39482 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbXCQC4D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 22:56:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Warning(linux-2621-rc3g7/drivers/ata/libata-core.c:842): No description found for parameter 'unknown'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2621-rc4.orig/drivers/ata/libata-core.c
+++ linux-2621-rc4/drivers/ata/libata-core.c
@@ -826,7 +826,7 @@ static u64 ata_id_n_sectors(const u16 *i
 /**
  *	ata_id_to_dma_mode	-	Identify DMA mode from id block
  *	@dev: device to identify
- *	@mode: mode to assume if we cannot tell
+ *	@unknown: mode to assume if we cannot tell
  *
  *	Set up the timing values for the device based upon the identify
  *	reported values for the DMA mode. This function is used by drivers
