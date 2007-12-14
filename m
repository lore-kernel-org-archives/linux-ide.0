From: akpm@linux-foundation.org
Subject: [patch 2/9] pata_hpt37x-fix-outstanding-bug-reports-on-the-hpt374-and-37x-cable-detect-checkpatch-fixes
Date: Thu, 13 Dec 2007 16:01:38 -0800
Message-ID: <200712140001.lBE01ce9025429@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55279 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752671AbXLNABv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 19:01:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk

From: Andrew Morton <akpm@linux-foundation.org>

WARNING: line over 80 characters
#70: FILE: drivers/ata/pata_hpt37x.c:850:
+		struct pci_dev *pdev_0 = pci_get_slot(pdev->bus, pdev->devfn - 1);

ERROR: else should follow close brace '}'
#78: FILE: drivers/ata/pata_hpt37x.c:858:
+	}
+	else

total: 1 errors, 1 warnings, 100 lines checked
Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Please run checkpatch prior to sending patches

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_hpt37x.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/ata/pata_hpt37x.c~pata_hpt37x-fix-outstanding-bug-reports-on-the-hpt374-and-37x-cable-detect-checkpatch-fixes drivers/ata/pata_hpt37x.c
--- a/drivers/ata/pata_hpt37x.c~pata_hpt37x-fix-outstanding-bug-reports-on-the-hpt374-and-37x-cable-detect-checkpatch-fixes
+++ a/drivers/ata/pata_hpt37x.c
@@ -847,15 +847,16 @@ static u32 hpt374_read_freq(struct pci_d
 	u32 freq;
 	unsigned long io_base = pci_resource_start(pdev, 4);
 	if (PCI_FUNC(pdev->devfn) & 1) {
-		struct pci_dev *pdev_0 = pci_get_slot(pdev->bus, pdev->devfn - 1);
+		struct pci_dev *pdev_0;
+
+		pdev_0 = pci_get_slot(pdev->bus, pdev->devfn - 1);
 		/* Someone hot plugged the controller on us ? */
 		if (pdev_0 == NULL)
 			return 0;
 		io_base = pci_resource_start(pdev_0, 4);
 		freq = inl(io_base + 0x90);
 		pci_dev_put(pdev_0);
-	}
-	else
+	} else
 		freq = inl(io_base + 0x90);
 	return freq;
 }
_
