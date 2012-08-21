From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] libata-core: use ATA_LBA in ata_build_rw_tf()
Date: Tue, 21 Aug 2012 22:18:50 +0400
Message-ID: <201208212218.51059.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47998 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932196Ab2HUS1V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2012 14:27:21 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Since READ/WRITE FPDMA QUEUED commands are 48-bit, bit 6 of the device register
means LBA, the same as for READ/WRITE DMA EXT commands. So use ATA_LBA instead
of the bare number in ata_build_rw_tf()'s branch dedicated to the NCQ commands.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the 'upstream' branch of libata-dev.git...

 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: libata-dev/drivers/ata/libata-core.c
===================================================================
--- libata-dev.orig/drivers/ata/libata-core.c
+++ libata-dev/drivers/ata/libata-core.c
@@ -774,7 +774,7 @@ int ata_build_rw_tf(struct ata_taskfile 
 		tf->lbam = (block >> 8) & 0xff;
 		tf->lbal = block & 0xff;
 
-		tf->device = 1 << 6;
+		tf->device = ATA_LBA;
 		if (tf->flags & ATA_TFLAG_FUA)
 			tf->device |= 1 << 7;
 	} else if (dev->flags & ATA_DFLAG_LBA) {
