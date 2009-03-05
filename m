From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide-iops: fix odd-length ATAPI PIO transfers
Date: Thu, 5 Mar 2009 18:36:33 +0400
Message-ID: <200903051736.34002.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.79.90.228] ([213.79.90.228]:45826 "EHLO
	buildserver.ru.mvista.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751593AbZCEOgG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 09:36:06 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org

Commit 9567b349f7e7dd7e2483db99ee8e4a6fe0caca38 (ide: merge ->atapi_*put_bytes
and ->ata_*put_data methods) introduced a regression  WRT the odd-length ATAPI
PIO transfers -- the final word didn't get written (causing command timeouts).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree...

 drivers/ide/ide-iops.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -315,6 +315,8 @@ void ide_output_data(ide_drive_t *drive,
 	u8 io_32bit = drive->io_32bit;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
+	len++;
+
 	if (io_32bit) {
 		unsigned long uninitialized_var(flags);
 

