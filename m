From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH UPDATED] devres: implement pcim_iomap_regions_request_all()
Date: Wed, 12 Mar 2008 15:26:34 +0900
Message-ID: <47D7779A.3070005@gmail.com>
References: <47D6643A.6060001@gmail.com> <20080311230825.fd631e29.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.234]:56223 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbYCLG0l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 02:26:41 -0400
Received: by qb-out-0506.google.com with SMTP id e11so2787278qbe.15
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 23:26:40 -0700 (PDT)
In-Reply-To: <20080311230825.fd631e29.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Some drivers need to reserve all PCI BARs to prevent other drivers
misusing unoccupied BARs.  pcim_iomap_regions_request_all() requests
all BARs and iomap specified BARs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>
---
Aieee...  Sorry Andrew.  I forgot doing "quilt add" on the file and
subsequently missed that pci.h was modified while gitting the repo.

Here's the corrected version.

 include/linux/pci.h |    2 ++
 lib/devres.c        |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

Index: work/lib/devres.c
===================================================================
--- work.orig/lib/devres.c
+++ work/lib/devres.c
@@ -298,6 +298,31 @@ int pcim_iomap_regions(struct pci_dev *p
 EXPORT_SYMBOL(pcim_iomap_regions);
 
 /**
+ * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
+ * @pdev: PCI device to map IO resources for
+ * @mask: Mask of BARs to iomap
+ * @name: Name used when requesting regions
+ *
+ * Request all PCI BARs and iomap regions specified by @mask.
+ */
+int pcim_iomap_regions_request_all(struct pci_dev *pdev, u16 mask,
+				   const char *name)
+{
+	int request_mask = ((1 << 6) - 1) & ~mask;
+	int rc;
+
+	rc = pci_request_selected_regions(pdev, request_mask, name);
+	if (rc)
+		return rc;
+
+	rc = pcim_iomap_regions(pdev, mask, name);
+	if (rc)
+		pci_release_selected_regions(pdev, request_mask);
+	return rc;
+}
+EXPORT_SYMBOL(pcim_iomap_regions_request_all);
+
+/**
  * pcim_iounmap_regions - Unmap and release PCI BARs
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to unmap and release
Index: work/include/linux/pci.h
===================================================================
--- work.orig/include/linux/pci.h
+++ work/include/linux/pci.h
@@ -1044,6 +1044,8 @@ void __iomem *pcim_iomap(struct pci_dev 
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_iomap_regions(struct pci_dev *pdev, u16 mask, const char *name);
+int pcim_iomap_regions_request_all(struct pci_dev *pdev, u16 mask,
+				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, u16 mask);
 
 extern int pci_pci_problems;
