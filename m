From: "Cai, Crane" <Crane.Cai@amd.com>
Subject: RE: [PATCH] PCI subsystem: AMD SATA IDE mode quirk
Date: Wed, 13 Feb 2008 16:31:07 +0800
Message-ID: <206C6845C72CAE439DC3D9D413C571A487B751@ssuzexmb3.amd.com>
References: <206C6845C72CAE439DC3D9D413C571A487B327@ssuzexmb3.amd.com>
 <47A40B8C.6080303@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:33623 "EHLO
	outbound5-wa4-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226AbYBMIcM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Feb 2008 03:32:12 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47A40B8C.6080303@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Hi Jeff, 
	Sorry to diturb you. However, it is a long time for me to submit this patch. Can you tell me when this patch can be upsteamed to the kernel tree?
Thanks,
Crane

-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org] 
Sent: Saturday, February 02, 2008 2:20 PM
To: Cai, Crane
Cc: gregkh@suse.de; linux-kernel@vger.kernel.org; linux-pci@atrey.karlin.mff.cuni.cz; Linux IDE mailing list
Subject: Re: [PATCH] PCI subsystem: AMD SATA IDE mode quirk

Cai, Crane wrote:
> From: Crane Cai <crane.cai@amd.com>
> 
> PCI: modify SATA IDE mode quirk
> When initialize and resume, SB600/700/800 need to set SATA mode 
> correctly.
> 
> Signed-off-by: Crane Cai <crane.cai@amd.com>
> --------------------------------------------
> --- a/drivers/pci/quirks.c	2007-09-24 14:16:32.000000000 -0400
> +++ b/drivers/pci/quirks.c	2008-02-02 11:23:47.000000000 -0500
> @@ -859,12 +859,13 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb );
>  
>  
> -static void __devinit quirk_sb600_sata(struct pci_dev *pdev)
> +static void __devinit quirk_amd_ide_mode(struct pci_dev *pdev)
>  {
> -	/* set sb600 sata to ahci mode */
> -	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
> -		u8 tmp;
> +	/* set sb600/sb700/sb800 sata to ahci mode */
> +	u8 tmp;
>  
> +	pci_read_config_byte(pdev, PCI_CLASS_DEVICE, &tmp);
> +	if (tmp == 0x01) {
>  		pci_read_config_byte(pdev, 0x40, &tmp);
>  		pci_write_config_byte(pdev, 0x40, tmp|1);
>  		pci_write_config_byte(pdev, 0x9, 1); @@ -872,10 +873,13 @@ static 
> void __devinit quirk_sb600_sata(s
>  		pci_write_config_byte(pdev, 0x40, tmp);
>  
>  		pdev->class = PCI_CLASS_STORAGE_SATA_AHCI;
> +		printk(KERN_INFO "PCI: set SATA to AHCI mode\n");
>  	}
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI,
> PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_sb600_sata); 
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI,
> PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_sb600_sata);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI,
> PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_ATI,
> PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI,
> PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_ATI,
> PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);

ACK

In the future, please also CC linux-ide@vger.kernel.org, as that's where the ATA folks hang out :)

	Jeff






