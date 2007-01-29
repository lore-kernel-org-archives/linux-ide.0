From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC] libata IORDY handling
Date: Mon, 29 Jan 2007 17:28:19 +0300
Message-ID: <45BE0483.4070409@ru.mvista.com>
References: <200701282024.17518.sshtylyov@ru.mvista.com>	<45BCEA03.8070901@ru.mvista.com> <20070129133423.75aa208e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050205080503000602020808"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:23961 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752509AbXA2O2Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jan 2007 09:28:25 -0500
In-Reply-To: <20070129133423.75aa208e@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050205080503000602020808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Alan wrote:

>>    It's sad to say but there's another bug in this function (even a 
>>regression from drivers/ide/pci/siimage.c) -- the 16-bit IORDY is not enabled 
>>when setting PIO mode (there's code that twiddles IORDY enable but that's 
>>actually only for *taskfile* accesses, 16-bit IORDY is controlled by the same 
>>PCI  config. registers 80h/84h that enable DMA/UDMA transfer on SiI 680).

> Fixed - also fixed clearing the bits when going into PIO mode from DMA,
> which fixes a potential DMA changedown bug.

     Yeah, this is an issue in siimage.c...

> Also redone the iordy stuff as your emails reminded me that it needed
> finishing off and sorting out.

     Atttaching my (already obsolete) patch, just in case...

> Alan

MBR, Sergei


--------------050205080503000602020808
Content-Type: text/x-patch;
 name="sil680_iordy-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sil680_iordy-fixes.patch"

Index: linux-2.6/drivers/ata/pata_sil680.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sil680.c
+++ linux-2.6/drivers/ata/pata_sil680.c
@@ -139,9 +139,12 @@ static void sil680_set_piomode(struct at
 
 	unsigned long tfaddr = sil680_selreg(ap, 0x02);
 	unsigned long addr = sil680_seldev(ap, adev, 0x04);
+	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	int port_shift = adev->devno * 4;
 	int pio = adev->pio_mode - XFER_PIO_0;
 	int lowest_pio = pio;
+	u8  mode;
 	u16 reg;
 
 	struct ata_device *pair = ata_dev_pair(adev);
@@ -152,11 +155,31 @@ static void sil680_set_piomode(struct at
 	pci_write_config_word(pdev, addr, speed_p[pio]);
 	pci_write_config_word(pdev, tfaddr, speed_t[lowest_pio]);
 
-	pci_read_config_word(pdev, tfaddr-2, &reg);
-	reg &= ~0x0200;			/* Clear IORDY */
+	/*
+	 * Let's see if we need to enable IORDY checking on data transfer...
+	 *
+	 * NOTE: Selecting any DMA mode also enables IORDY  checkign,
+	 * so we must first check if not already in DMA mode beforehand
+	 * to avoid disabling it...
+	 */
+	pci_read_config_byte(pdev, addr_mask, &mode);
+	if (ata_pio_need_iordy(adev) && ((mode >> port_shift) & 0x03) == 0x00)
+		mode |= 0x01 << port_shift;
+	else if (((mode >> port_shift) & 0x03) == 0x01)
+		mode &= ~(0x03 << port_shift);
+	pci_write_config_byte(pdev, addr_mask, mode);
+
+	/*
+	 * Let's see if we need to enable IORDY checking on taskfile.
+	 *
+	 * NOTE: We can only disable IORDY if both drives agree to it.
+	 */
+	pci_read_config_word(pdev, tfaddr - 2, &reg);
 	if (ata_pio_need_iordy(adev))
-		reg |= 0x0200;		/* Enable IORDY */
-	pci_write_config_word(pdev, tfaddr-2, reg);
+		reg |=  0x0200;
+	else if (pair == NULL || !ata_pio_need_iordy(pair))
+		reg &= ~0x0200;
+	pci_write_config_word(pdev, tfaddr - 2, reg);
 }
 
 /**


--------------050205080503000602020808--
