From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #stable] ahci: disable 64bit DMA by default on SB600s
Date: Mon, 12 Oct 2009 16:28:26 +0900
Message-ID: <4AD2DA9A.7080503@kernel.org>
References: <4AC71901.6010005@kernel.org> <4ACAC646.9050606@garzik.org> <20091009220248.GA28123@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45662 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbZJLH3X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Oct 2009 03:29:23 -0400
In-Reply-To: <20091009220248.GA28123@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, balducci@units.it, Shane Huang <Shane.Huang@amd.com>, stable@kernel.org, maierp@informatik.tu-muenchen.de

Till now only one board, ASUS M2A-VM, can do 64bit dma with recent
BIOSen.  Enabling 64bit DMA by default already broke three boards.
Enabling 64bit DMA isn't worth these regressions.  Disable 64bit DMA
by default and enable it only on boards which are known to work.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Gabriele Balducci <balducci@units.it>
Reported-by: maierp@informatik.tu-muenchen.de
Cc: Shane Huang <shane.huang@amd.com>
Cc: stable@kernel.org
---
> This doesn't apply to the 2.6.31-stable tree.
> 
> Tejun, could you respin this for the stable release, if you feel it
> needs to be there?

Yeap, here's minimal backport.

Thanks.

 drivers/ata/ahci.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: tree0/drivers/ata/ahci.c
===================================================================
--- tree0.orig/drivers/ata/ahci.c
+++ tree0/drivers/ata/ahci.c
@@ -433,7 +433,8 @@ static const struct ata_port_info ahci_p
 	[board_ahci_sb600] =
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
-				 AHCI_HFLAG_NO_MSI | AHCI_HFLAG_SECT255),
+				 AHCI_HFLAG_NO_MSI | AHCI_HFLAG_SECT255 |
+				 AHCI_HFLAG_32BIT_ONLY),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
@@ -2608,7 +2609,7 @@ static void ahci_p5wdh_workaround(struct
  * 1501 which was released on 2007-10-26.  Force 32bit DMA on anything
  * older than 1501.  Please read bko#9412 for more info.
  */
-static bool ahci_asus_m2a_vm_32bit_only(struct pci_dev *pdev)
+static bool ahci_asus_m2a_vm_enable_64bit(struct pci_dev *pdev)
 {
 	static const struct dmi_system_id sysids[] = {
 		{
@@ -2639,12 +2640,12 @@ static bool ahci_asus_m2a_vm_32bit_only(
 	if (date && strlen(date) >= 10 && date[2] == '/' && date[5] == '/' &&
 	    (year > 2007 ||
 	     (year == 2007 && strncmp(date, cutoff_mmdd, 5) >= 0)))
-		return false;
+		return true;

 	dev_printk(KERN_WARNING, &pdev->dev, "ASUS M2A-VM: BIOS too old, "
 		   "forcing 32bit DMA, update BIOS\n");

-	return true;
+	return false;
 }

 static bool ahci_broken_system_poweroff(struct pci_dev *pdev)
@@ -2858,8 +2859,8 @@ static int ahci_init_one(struct pci_dev
 		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;

 	/* apply ASUS M2A_VM quirk */
-	if (ahci_asus_m2a_vm_32bit_only(pdev))
-		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
+	if (ahci_asus_m2a_vm_enable_64bit(pdev))
+		hpriv->flags &= ~AHCI_HFLAG_32BIT_ONLY;

 	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
 		pci_intx(pdev, 1);
