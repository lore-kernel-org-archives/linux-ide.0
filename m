From: akpm@linux-foundation.org
Subject: [patch 10/11] iomap: sort out the broken address reporting caused by the iomap layer
Date: Mon, 09 Jul 2007 11:46:22 -0700
Message-ID: <200707091846.l69IkNop001393@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46949 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754184AbXGISzE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 14:55:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Add an iomap_name() function which translates an I/O map into a string to
print.

Use it for the Libata layer

For now we use 0xXXXX for I/O and 0xXXXXXXXX for MMIO.  I'm assuming that
eventually some other platforms will want to use their own iomap_name() and
we can add ARCH_HAVE_IOMAP_NAME later as such a platform needs it.

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/asm-generic/iomap.h |    5 +++++
 lib/iomap.c                 |   12 ++++++++++++
 2 files changed, 17 insertions(+)

diff -puN include/asm-generic/iomap.h~iomap-sort-out-the-broken-address-reporting-caused-by-the-iomap-layer include/asm-generic/iomap.h
--- a/include/asm-generic/iomap.h~iomap-sort-out-the-broken-address-reporting-caused-by-the-iomap-layer
+++ a/include/asm-generic/iomap.h
@@ -65,4 +65,9 @@ struct pci_dev;
 extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
+/* Convert an iomap to text for this platform */
+extern char *iomap_name(void __iomem *addr, char *buf, size_t len);
+#define IOMAP_NAMELEN	12
+
+
 #endif
diff -puN lib/iomap.c~iomap-sort-out-the-broken-address-reporting-caused-by-the-iomap-layer lib/iomap.c
--- a/lib/iomap.c~iomap-sort-out-the-broken-address-reporting-caused-by-the-iomap-layer
+++ a/lib/iomap.c
@@ -268,3 +268,15 @@ void pci_iounmap(struct pci_dev *dev, vo
 }
 EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
+
+char *iomap_name(void __iomem *port, char *buf, size_t len)
+{
+	if (port == NULL) {
+		snprintf(buf, len, "None");
+		return buf;
+	}
+	IO_COND(port, snprintf(buf, len, "0x%04lx", port),
+		snprintf(buf, len, "%08lx", port));
+	return buf;
+}
+EXPORT_SYMBOL(iomap_name);
_
