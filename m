From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] ahci: disable FPDMA auto-activate optimization on NVIDIA
 AHCI
Date: Tue, 26 Jan 2010 22:33:23 -0600
Message-ID: <4B5FC213.1060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f186.google.com ([209.85.223.186]:52985 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab0A0Edj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2010 23:33:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: Mike Cui <cuicui@gmail.com>, Peer Chen <pchen@nvidia.com>

Mike Cui reported that his system with an NVIDIA MCP79 (aka MCP7A) chipset
stopped working with 2.6.32. The problem appears to be that 2.6.32 now enables
the FPDMA auto-activate optimization in the ahci driver. The drive works fine
with this enabled on an Intel AHCI so this appears to be a chipset bug.
Since MCP79 is a fairly recent NVIDIA chipset and we don't have any info on
whether any other NVIDIA chipsets have this issue, disable FPDMA AA optimization
on all NVIDIA AHCI controllers for now.

Should address http://bugzilla.kernel.org/show_bug.cgi?id=14922

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

---

Mike, can you test this out and make sure this resolves the problem for you?

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b8bea10..47e57dc 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -3067,8 +3067,16 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ahci_save_initial_config(pdev, hpriv);
 
 	/* prepare host */
-	if (hpriv->cap & HOST_CAP_NCQ)
-		pi.flags |= ATA_FLAG_NCQ | ATA_FLAG_FPDMA_AA;
+	if (hpriv->cap & HOST_CAP_NCQ) {
+		pi.flags |= ATA_FLAG_NCQ;
+		/* Auto-activate optimization is supposed to be supported on
+		   all AHCI controllers indicating NCQ support, but it seems
+		   to be broken at least on some NVIDIA MCP79 chipsets.
+		   Until we get info on which NVIDIA chipsets don't have this
+		   issue, if any, disable AA on all NVIDIA AHCIs. */
+		if (pdev->vendor != PCI_VENDOR_ID_NVIDIA)
+			pi.flags |= ATA_FLAG_FPDMA_AA;
+	}
 
 	if (hpriv->cap & HOST_CAP_PMP)
 		pi.flags |= ATA_FLAG_PMP;
