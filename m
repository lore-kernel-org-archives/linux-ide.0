From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] libata: fix libata-scsi kernel-doc notation
Date: Wed, 30 Apr 2008 12:57:00 -0700
Message-ID: <20080430125700.6d1d24b1.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:47286 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758727AbYD3T5Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 15:57:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix libata-scsi kernel-doc notation:

Warning(linux-2.6.25-git15//drivers/ata/libata-scsi.c:1659): No description found for parameter 'cmd'
Warning(linux-2.6.25-git15//drivers/ata/libata-scsi.c:1971): No description found for parameter 'buf'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-scsi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.25-git15.orig/drivers/ata/libata-scsi.c
+++ linux-2.6.25-git15/drivers/ata/libata-scsi.c
@@ -1643,6 +1643,7 @@ defer:
 
 /**
  *	ata_scsi_rbuf_get - Map response buffer.
+ *	@cmd: SCSI command containing buffer to be mapped.
  *	@flags: unsigned long variable to store irq enable status
  *	@copy_in: copy in from user buffer
  *
@@ -1960,7 +1961,7 @@ static unsigned int ata_msense_ctl_mode(
 
 /**
  *	ata_msense_rw_recovery - Simulate MODE SENSE r/w error recovery page
- *	@bufp: output buffer
+ *	@buf: output buffer
  *
  *	Generate a generic MODE SENSE r/w error recovery page.
  *
