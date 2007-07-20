From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] iomap: Allow space for 64bit I/O ports
Date: Fri, 20 Jul 2007 15:38:37 +0100
Message-ID: <20070720153837.6635387e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38267 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750714AbXGTOke (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 10:40:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc6-mm1/include/asm-generic/iomap.h linux-2.6.22-rc6-mm1/include/asm-generic/iomap.h
--- linux.vanilla-2.6.22-rc6-mm1/include/asm-generic/iomap.h	2007-07-02 20:47:33.000000000 +0100
+++ linux-2.6.22-rc6-mm1/include/asm-generic/iomap.h	2007-07-20 14:08:07.310897944 +0100
@@ -65,4 +65,9 @@
 extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
+/* Convert an iomap to text for this platform */
+extern char *iomap_name(void __iomem *addr, char *buf, size_t len);
+#define IOMAP_NAMELEN	20
+
+
 #endif
