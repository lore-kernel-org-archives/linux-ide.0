From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-portmap: Remove unused definitions
Date: Wed, 22 Aug 2007 23:12:50 +0100
Message-ID: <20070822231250.0ddc6b46@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48137 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764413AbXHVWE7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 18:04:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

With the PCI layer properly handling legacy IDE and the kernel now using
it these can go

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/include/asm-generic/libata-portmap.h linux-2.6.23rc3-mm1/include/asm-generic/libata-portmap.h
--- linux.vanilla-2.6.23rc3-mm1/include/asm-generic/libata-portmap.h	2007-07-23 12:53:58.000000000 +0100
+++ linux-2.6.23rc3-mm1/include/asm-generic/libata-portmap.h	2007-08-22 17:48:32.000000000 +0100
@@ -1,12 +1,7 @@
 #ifndef __ASM_GENERIC_LIBATA_PORTMAP_H
 #define __ASM_GENERIC_LIBATA_PORTMAP_H
 
-#define ATA_PRIMARY_CMD		0x1F0
-#define ATA_PRIMARY_CTL		0x3F6
 #define ATA_PRIMARY_IRQ(dev)	14
-
-#define ATA_SECONDARY_CMD	0x170
-#define ATA_SECONDARY_CTL	0x376
 #define ATA_SECONDARY_IRQ(dev)	15
 
 #endif
