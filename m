From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_serverworks hangs
Date: Fri, 2 Nov 2007 17:41:48 +0000
Message-ID: <20071102174148.49358f7e@the-village.bc.nu>
References: <Pine.LNX.4.64.0711021415300.1316@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53060 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753015AbXKBRkm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 13:40:42 -0400
In-Reply-To: <Pine.LNX.4.64.0711021415300.1316@bizon.gios.gov.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-ide@vger.kernel.org

On Fri, 2 Nov 2007 14:29:17 +0100 (CET)
Krzysztof Oledzki <olel@ans.pl> wrote:

> Hello,
> 
> I just tried to switch from old IDE to libata but unfortunately kernel 
> (2.6.22.10) hangs during boot:
> 
> ata1: PATA max UDMA/66 cmd 0x000101e8 ctl 0x000103ee bmdma 0x00012c40 irq 11
> ata2: DUMMY
> ata1.00: ATAPI: HL-DT-ST CD-ROM GCR-8482B, 1.00, max MWDMA2
> ara1.01: ATAPI: LITE-ON LTR-62327S, QS75, max UDMA/33
> ata1.00: configured for MWDMA2
> ata1.00: configured for UDMA/33
> scsi 2:0:0:0: CDROM             HL-DT-ST CDROM GCR-8482B 1.00 PQ: 0 ANSI 5
> (kernel hangs)
> 
> Attaching lspci and dmesg from working system, with pata_serverworks 
> disabled.

Try the following patch and let me know if it helps:


--- drivers/ata/pata_serverworks.c~	2007-11-02 17:25:41.078936752 +0000
+++ drivers/ata/pata_serverworks.c	2007-11-02 17:25:41.078936752 +0000
@@ -274,28 +274,27 @@
 {
 	static const u8 dma_mode[] = { 0x77, 0x21, 0x20 };
 	int offset = 1 + 2 * ap->port_no - adev->devno;
-	int devbits = (2 * ap->port_no + adev->devno);
+	int devbits = 2 * ap->port_no + adev->devno;
 	u8 ultra;
 	u8 ultra_cfg;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, 0x54, &ultra_cfg);
+	pci_read_config_byte(pdev, 0x56 + ap->port_no, &ultra);
+	ultra &= ~(0x0F << (adev->devno * 4));
 
 	if (adev->dma_mode >= XFER_UDMA_0) {
 		pci_write_config_byte(pdev, 0x44 + offset,  0x20);
 
-		pci_read_config_byte(pdev, 0x56 + ap->port_no, &ultra);
-		ultra &= ~(0x0F << (ap->port_no * 4));
 		ultra |= (adev->dma_mode - XFER_UDMA_0)
-					<< (ap->port_no * 4);
-		pci_write_config_byte(pdev, 0x56 + ap->port_no, ultra);
-
+					<< (adev->devno * 4);
 		ultra_cfg |=  (1 << devbits);
 	} else {
 		pci_write_config_byte(pdev, 0x44 + offset,
 			dma_mode[adev->dma_mode - XFER_MW_DMA_0]);
 		ultra_cfg &= ~(1 << devbits);
 	}
+	pci_write_config_byte(pdev, 0x56 + ap->port_no, ultra);
 	pci_write_config_byte(pdev, 0x54, ultra_cfg);
 }
 
