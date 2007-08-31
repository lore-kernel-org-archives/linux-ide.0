From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: sata_via: write errors on PATA drive connected to VT6421
Date: Sat, 1 Sep 2007 00:55:21 +0200
Message-ID: <200709010055.22200.linux@rainbow-software.org>
References: <200708202242.07290.linux@rainbow-software.org> <20070821132731.6bf10b50@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762617AbXHaWy6@vger.kernel.org>
In-Reply-To: <20070821132731.6bf10b50@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,
I think that I've found and fixed the problem. There is a copy/paste bug in 
vt6421_set_dma_mode() function which causes wrong values to be written to 
PATA_UDMA_TIMING register.


This patch fixes a copy/paste bug that breaks DMA modes on VT6421 PATA port.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.22.3-orig/drivers/ata/sata_via.c	2007-09-01 00:40:22.000000000 +0200
+++ linux-2.6.22.3-router2/drivers/ata/sata_via.c	2007-09-01 00:10:40.000000000 +0200
@@ -370,7 +370,7 @@
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const u8 udma_bits[] = { 0xEE, 0xE8, 0xE6, 0xE4, 0xE2, 0xE1, 0xE0, 0xE0 };
-	pci_write_config_byte(pdev, PATA_UDMA_TIMING, udma_bits[adev->pio_mode - XFER_UDMA_0]);
+	pci_write_config_byte(pdev, PATA_UDMA_TIMING, udma_bits[adev->dma_mode - XFER_UDMA_0]);
 }
 
 static const unsigned int svia_bar_sizes[] = {


-- 
Ondrej Zary
