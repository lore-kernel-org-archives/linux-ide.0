From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] pci: VT3336 can't do MSI either
Date: Tue, 24 Jun 2008 14:35:14 +0900
Message-ID: <48608792.7090909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53553 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbYFXFgI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jun 2008 01:36:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz

It seems VT3336 can't do msi either as with its bro 3351.  Disable it.
Reported in the following SUSE bug.

  https://bugzilla.novell.com/show_bug.cgi?id=300001

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Anyone interested in queuing this for -rc8?  Thanks.

 drivers/pci/quirks.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dabb563..9d95f0b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1685,6 +1685,7 @@ static void __init quirk_disable_all_msi(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS400_200, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS480, quirk_disable_all_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3336, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3351, quirk_disable_all_msi);
 
 /* Disable MSI on chipsets that are known to not support it */
