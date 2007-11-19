From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core: List more documentation sources for reference
Date: Mon, 19 Nov 2007 14:30:16 +0000
Message-ID: <20071119143016.6880a37f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33652 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753317AbXKSOcH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 09:32:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

And next time I'll be able to find the ata tape spec easily...

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/libata-core.c linux-2.6.24-rc2-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/libata-core.c	2007-11-16 17:55:11.000000000 +0000
+++ linux-2.6.24-rc2-mm1/drivers/ata/libata-core.c	2007-11-16 23:42:27.000000000 +0000
@@ -27,9 +27,17 @@
  *  libata documentation is available via 'make {ps|pdf}docs',
  *  as Documentation/DocBook/libata.*
  *
- *  Hardware documentation available from http://www.t13.org/ and
+ *  Hardware documentation available from http://www.t13.org/ and
  *  http://www.sata-io.org/
  *
+ *  Standards documents from:
+ *	http://www.t13.org (ATA standards, PCI DMA IDE spec)
+ *	http://www.t10.org (SCSI MMC - for ATAPI MMC)
+ *	http://www.sata-io.org (SATA)
+ *	http://www.compactflash.org (CF)
+ *	http://www.qic.org (QIC157 - Tape and DSC)
+ *	http://www.ce-ata.org (CE-ATA: not supported)
+ *
  */
 
 #include <linux/kernel.h>
