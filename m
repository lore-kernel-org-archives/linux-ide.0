From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] libata: fix kernel-doc param name
Date: Thu, 18 Oct 2007 14:12:26 -0700
Message-ID: <20071018141226.9923ff99.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:64123 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762539AbXJRVNb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 17:13:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>, akpm <akpm@linux-foundation.org>, torvalds <torvalds@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix libata kernel-doc parameter name.

Warning(linux-2.6.23-git13//drivers/ata/libata-core.c:1415): No description found for parameter 'sgl'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.23-git13.orig/drivers/ata/libata-core.c
+++ linux-2.6.23-git13/drivers/ata/libata-core.c
@@ -1392,7 +1392,7 @@ static void ata_qc_complete_internal(str
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
  *	@dma_dir: Data tranfer direction of the command
- *	@sg: sg list for the data buffer of the command
+ *	@sgl: sg list for the data buffer of the command
  *	@n_elem: Number of sg entries
  *	@timeout: Timeout in msecs (0 for default)
  *
