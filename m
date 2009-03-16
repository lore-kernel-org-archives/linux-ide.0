From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] ide-disk: use ATA_ERR
Date: Mon, 16 Mar 2009 19:33:08 +0400
Message-ID: <200903161833.08744.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40911 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753027AbZCPPcZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Mar 2009 11:32:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Make use of ATA_ERR instead of hard-coded value in idedisk_set_max_address()
and idedisk_read_native_max_address().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is atop of the latest pata-2.6 series...

 drivers/ide/ide-disk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-disk.c
+++ linux-2.6/drivers/ide/ide-disk.c
@@ -227,7 +227,7 @@ static u64 idedisk_read_native_max_addre
 	ide_no_data_taskfile(drive, &cmd);
 
 	/* if OK, compute maximum address value */
-	if ((tf->status & 0x01) == 0)
+	if (!(tf->status & ATA_ERR))
 		addr = ide_get_lba_addr(tf, lba48) + 1;
 
 	return addr;
@@ -267,7 +267,7 @@ static u64 idedisk_set_max_address(ide_d
 	ide_no_data_taskfile(drive, &cmd);
 
 	/* if OK, compute maximum address value */
-	if ((tf->status & 0x01) == 0)
+	if (!(tf->status & ATA_ERR))
 		addr_set = ide_get_lba_addr(tf, lba48) + 1;
 
 	return addr_set;

