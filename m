From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: iomap (Corrected - ignore last one)
Date: Fri, 20 Jul 2007 15:42:16 +0100
Message-ID: <20070720154216.259f1d14@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44640 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761976AbXGTOfq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 10:35:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Allow for 64bit MMIO ports in the iomap printing buffer

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux-2.6.22-rc6-mm1/include/asm-generic/iomap.h~	2007-07-20 14:08:07.000000000 +0100
+++ linux-2.6.22-rc6-mm1/include/asm-generic/iomap.h	2007-07-20 14:08:07.310897944 +0100
@@ -67,7 +67,7 @@
 
 /* Convert an iomap to text for this platform */
 extern char *iomap_name(void __iomem *addr, char *buf, size_t len);
-#define IOMAP_NAMELEN	12
+#define IOMAP_NAMELEN	20
 
 
 #endif
