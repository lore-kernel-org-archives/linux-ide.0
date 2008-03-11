From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] ahci: request all PCI BARs
Date: Tue, 11 Mar 2008 19:52:31 +0900
Message-ID: <47D6646F.9070109@gmail.com>
References: <47D6643A.6060001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:46557 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbYCKKwh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 06:52:37 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2785086wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 03:52:37 -0700 (PDT)
In-Reply-To: <47D6643A.6060001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kr>

ahci is often implemented with accompanying SFF compatible interface
and legacy IDE driver may attach to the legacy IO ports when the
controller is already claimed by ahci and vice-versa.  This patch
makes ahci use pcim_iomap_regions_request_all() so that all IO regions
are claimed on attach.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -2234,7 +2234,10 @@ static int ahci_init_one(struct pci_dev 
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 1 << AHCI_PCI_BAR, DRV_NAME);
+	/* AHCI controllers often implement SFF compatible interface.
+	 * Grab all PCI BARs just in case.
+	 */
+	rc = pcim_iomap_regions_request_all(pdev, 1 << AHCI_PCI_BAR, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
