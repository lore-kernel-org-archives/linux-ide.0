From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] libata: fix kernel-doc parameters
Date: Tue, 1 May 2007 17:35:55 -0700
Message-ID: <20070501173555.6e95c3bb.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:51323 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992533AbXEBAb5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 20:31:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Warning(linux-2.6.21-git4//drivers/ata/libata-core.c:904): No description found for parameter 'new_sectors'
Warning(linux-2.6.21-git4//drivers/ata/libata-core.c:941): No description found for parameter 'new_sectors'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-core.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.21-git4.orig/drivers/ata/libata-core.c
+++ linux-2.6.21-git4/drivers/ata/libata-core.c
@@ -895,6 +895,7 @@ static u64 ata_read_native_max_address(s
 /**
  *	ata_set_native_max_address_ext	-	LBA48 native max set
  *	@dev: Device to query
+ *	@new_sectors: new max sectors value to set for the device
  *
  *	Perform an LBA48 size set max upon the device in question. Return the
  *	actual LBA48 size or zero if the command fails.
@@ -932,6 +933,7 @@ static u64 ata_set_native_max_address_ex
 /**
  *	ata_set_native_max_address	-	LBA28 native max set
  *	@dev: Device to query
+ *	@new_sectors: new max sectors value to set for the device
  *
  *	Perform an LBA28 size set max upon the device in question. Return the
  *	actual LBA28 size or zero if the command fails.
