From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_inic162x
Date: Sat, 30 Aug 2008 12:29:04 +0200
Message-ID: <48B920F0.7090405@kernel.org>
References: <48AD9EAD.1010204@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010709010609020503010005"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51841 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbYH3KaR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 06:30:17 -0400
In-Reply-To: <48AD9EAD.1010204@yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: echo6 <echo6_uk@yahoo.com>
Cc: linux-ide@vger.kernel.org, linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------010709010609020503010005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

echo6 wrote:
> I'm experiencing difficulties with this controller
> 
> 04:00.0 SATA controller: Initio Corporation INI-1623 PCI SATA-II
> Controller (rev 02) (prog-if 00 [Vendor specific])
>     Subsystem: Initio Corporation Unknown device 1626
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>     Latency: 64
>     Interrupt: pin A routed to IRQ 21
>     Region 0: I/O ports at b000 [size=256]
>     Region 1: Memory at 8c420000 (32-bit, non-prefetchable) [size=4K]
>     [virtual] Expansion ROM at 8c400000 [disabled] [size=128K]
>     Capabilities: [dc] Power Management version 2
>         Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1+,D2+,D3hot+,D3cold-)
>         Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> Branded as an A.C.Ryan, http://www.acryan.com
> 
> I'm using Ubuntu 8.04;
> Linux toshiba 2.6.24-16-generic
> Linux toshiba 2.6.24-19-generic
> Produces an error
> [  608.944941] pccard: CardBus card inserted into slot 0
> [  609.062663] sata_inic162x 0000:04:00.0: version 0.3
> [  609.062933] PCI: Enabling device 0000:04:00.0 (0000 -> 0003)
> [  609.062945] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 21 (level,
> low) -> IRQ 18
> [  609.062977] ACPI: PCI interrupt for device 0000:04:00.0 disabled
> [  609.063615] sata_inic162x: probe of 0000:04:00.0 failed with error -22

BAR 5 non-existent.  sata_inic162x should then use BAR 1 which
should seems fine.  Hmmm... ENOENT.  Can you please try the attached
patch?

-- 
tejun

--------------010709010609020503010005
Content-Type: text/x-patch;
 name="sata_inic162x-cardbus-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_inic162x-cardbus-debug.patch"

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 3ead02f..be7eb4e 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -840,10 +840,15 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	if (pci_resource_flags(pdev, MMIO_BAR_PCI) & IORESOURCE_MEM)
+	if (pci_resource_len(pdev, MMIO_BAR_PCI) &&
+	    (pci_resource_flags(pdev, MMIO_BAR_PCI) & IORESOURCE_MEM))
 		mmio_bar = MMIO_BAR_PCI;
 	else
 		mmio_bar = MMIO_BAR_CARDBUS;
+	dev_printk(KERN_INFO, &pdev->dev, "XXX: BAR5 flags=0x%lx len=%lu, mmio_bar=%d\n",
+		   pci_resource_flags(pdev, MMIO_BAR_PCI),
+		   (unsigned long)pci_resource_len(pdev, MMIO_BAR_PCI),
+		   mmio_bar);
 
 	rc = pcim_iomap_regions(pdev, 1 << mmio_bar, DRV_NAME);
 	if (rc)

--------------010709010609020503010005--
