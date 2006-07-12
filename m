From: Jeff Garzik <jeff@garzik.org>
Subject: Re: + sata-add-pci-id.patch added to -mm tree
Date: Wed, 12 Jul 2006 13:46:54 -0400
Message-ID: <44B5358E.4050301@garzik.org>
References: <200607090039.k690d4j0005100@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34003 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932178AbWGLRrC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jul 2006 13:47:02 -0400
In-Reply-To: <200607090039.k690d4j0005100@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, Jason Gaston <jason.d.gaston@intel.com>
Cc: helms.adam@gmail.com, htejun@gmail.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

akpm@osdl.org wrote:
> Subject: SATA: Add PCI-ID
> From: "Adam Helms" <helms.adam@gmail.com>
> 
> Makes the AHCI driver detect the PCI ID 8086:27c0 (IDE interface: Intel
> Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controller IDE
> (rev 01)) as an AHCI chipset.
> 
> 8086:27c0 also works with ata_piix but it's much slower.  8086:27c0 is
> shipped with - among others - new HP Proliant servers.

> diff -puN drivers/scsi/ahci.c~sata-add-pci-id drivers/scsi/ahci.c
> --- a/drivers/scsi/ahci.c~sata-add-pci-id
> +++ a/drivers/scsi/ahci.c
> @@ -291,6 +291,8 @@ static const struct pci_device_id ahci_p
>  	  board_ahci }, /* ICH6 */
>  	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_ahci }, /* ICH6M */
> +	{ PCI_VENDOR_ID_INTEL, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_ahci }, /* ICH7 */
>  	{ PCI_VENDOR_ID_INTEL, 0x27c1, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_ahci }, /* ICH7 */
>  	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,

This patch needs discussing with Intel.

0x27c0 was intentionally omitted, because it is only supposed to show up 
when the device is configured into IDE mode.

If the user (read: BIOS) has chosen to configure the device in AHCI 
mode, it should show up as a different PCI ID, which ahci.c already 
contains.

I'm inclined to NAK the patch, since things appear to be working as 
expected.

	Jeff


