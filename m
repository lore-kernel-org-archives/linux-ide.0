From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/6] pata_sis: Implement MWDMA for the UDMA 133 capable chips
Date: Mon, 7 Dec 2009 16:05:28 +0100
Message-ID: <200912071605.28364.bzolnier@gmail.com>
References: <20091130132005.27236.77890.stgit@localhost.localdomain> <20091130132248.27236.35287.stgit@localhost.localdomain> <4B1D0268.4090508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:52176 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422AbZLGPGi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 10:06:38 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1311175fgg.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2009 07:06:44 -0800 (PST)
In-Reply-To: <4B1D0268.4090508@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

On Monday 07 December 2009 02:26:00 pm Sergei Shtylyov wrote:
> Hello.
> 
> Alan Cox wrote:
> 
> > Bartlomiej pointed out that while this got fixed in the old driver whoever
> > did it didn't port it across.
> 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> [...]
> 
> > +static int mwdma_clip_to_pio(struct ata_device *adev)
> > +{
> > +	const int mwdma_to_pio[3] = {
> > +		XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
> > +	};
> > +	return min(mwdma_to_pio[adev->dma_mode - XFER_MW_DMA_0],
> > +				adev->pio_mode - XFER_PIO_0);
> > +}
> 
>     You call min() on uncomparables, i.e. mwdma_to_pio[] contains XFER_PIO_* 
> and adev->pio_mode - XFER_PIO_0 yields you a mode number. Thus the second 
> argument will always "win" as a minimal one.

There are more issues with the patch related to mwdma_clip_to_pio().

The function can return values between 0 and 4 which obviously won't work
well for the new code below for values > 2 (i.e. resulting in out-of-bounds
array access for the common-case of dev->pio_mode == 4).

@@ -400,21 +439,25 @@ static void sis_100_set_dmamode (struct ata_port *ap, struct ata_device *adev)
        struct pci_dev *pdev    = to_pci_dev(ap->host->dev);
        int speed = adev->dma_mode - XFER_MW_DMA_0;
        int drive_pci = sis_old_port_base(adev);
-       u8 timing;
+       u16 timing;
 
-       const u8 udma_bits[]  = { 0x8B, 0x87, 0x85, 0x83, 0x82, 0x81};
+       const u16 udma_bits[]  = {
+               0x8B00, 0x8700, 0x8500, 0x8300, 0x8200, 0x8100};
+       const u8 mwdma_bits[] = { 0x08, 0x32, 0x31 };
 
-       pci_read_config_byte(pdev, drive_pci + 1, &timing);
+       pci_read_config_word(pdev, drive_pci, &timing);
 
        if (adev->dma_mode < XFER_UDMA_0) {
-               /* NOT SUPPORTED YET: NEED DATA SHEET. DITTO IN OLD DRIVER */
+               speed = mwdma_clip_to_pio(adev);
+               timing &= ~0x80FF;
+               timing |= mwdma_bits[speed];
        } else {
                /* Bit 7 is UDMA on/off, bit 0-3 are cycle time */
                speed = adev->dma_mode - XFER_UDMA_0;
-               timing &= ~0x8F;
+               timing &= ~0x8F00;
                timing |= udma_bits[speed];
        }
-       pci_write_config_byte(pdev, drive_pci + 1, timing);
+       pci_write_config_word(pdev, drive_pci, timing);
 }
 
 /**
@@ -434,21 +477,26 @@ static void sis_133_early_set_dmamode (struct ata_port *ap, struct ata_device *a
        struct pci_dev *pdev    = to_pci_dev(ap->host->dev);
        int speed = adev->dma_mode - XFER_MW_DMA_0;
        int drive_pci = sis_old_port_base(adev);
-       u8 timing;
-       /* Low 4 bits are timing */
-       static const u8 udma_bits[]  = { 0x8F, 0x8A, 0x87, 0x85, 0x83, 0x82, 0x81};
+       u16 timing;
+       /* Bits 15-12  are timing */
+       static const u16 udma_bits[]  = {
+               0x8F00, 0x8A00, 0x8700, 0x8500, 0x8300, 0x8200, 0x8100
+       };
+       static const u8 mwdma_bits[] = { 0x08, 0x32, 0x31 };
 
-       pci_read_config_byte(pdev, drive_pci + 1, &timing);
+       pci_read_config_word(pdev, drive_pci, &timing);
 
        if (adev->dma_mode < XFER_UDMA_0) {
-               /* NOT SUPPORTED YET: NEED DATA SHEET. DITTO IN OLD DRIVER */
+               speed = mwdma_clip_to_pio(adev);
+               timing &= ~0x80FF;
+               timing = mwdma_bits[speed];
        } else {
                /* Bit 7 is UDMA on/off, bit 0-3 are cycle time */
                speed = adev->dma_mode - XFER_UDMA_0;
-               timing &= ~0x8F;
+               timing &= ~0x8F00;
                timing |= udma_bits[speed];
        }
-       pci_write_config_byte(pdev, drive_pci + 1, timing);
+       pci_write_config_word(pdev, drive_pci, timing);
 }
 
 /**


--
Bartlomiej Zolnierkiewicz
