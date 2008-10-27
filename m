From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] libata: add missing kernel-doc
Date: Sun, 26 Oct 2008 20:19:32 -0700
Message-ID: <20081026201932.d012e8dc.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:15928 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbYJ0DT7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Oct 2008 23:19:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>, akpm <akpm@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix libata missing kernel-doc:

Warning(lin2628-rc2//drivers/ata/libata-core.c:4562): No description found for parameter 'tag'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

--- lin2628-rc2.orig/drivers/ata/libata-core.c
+++ lin2628-rc2/drivers/ata/libata-core.c
@@ -4553,6 +4553,7 @@ void swap_buf_le16(u16 *buf, unsigned in
 /**
  *	ata_qc_new_init - Request an available ATA command, and initialize it
  *	@dev: Device from whom we request an available command structure
+ *	@tag: command tag
  *
  *	LOCKING:
  *	None.
