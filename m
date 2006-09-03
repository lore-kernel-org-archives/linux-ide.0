From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: [PATCH] sata_sis: support for SiS 966 chipset
Date: Mon, 04 Sep 2006 00:43:12 +0200
Message-ID: <44FB5A80.3030303@gmx.net>
References: <OF4D22CCD9.03BE95A7-ON482571DC.00351C4C@sis.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:50662 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750890AbWICWnP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Sep 2006 18:43:15 -0400
In-Reply-To: <OF4D22CCD9.03BE95A7-ON482571DC.00351C4C@sis.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Wang <touch@sis.com>
Cc: "inux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello David,

Please can you resend the patch. Your mail is partially damaged.
truncation of lines and additional new lines, so patch does not work.

regards,
Uwe Koziolek

David Wang schrieb:
> Hi Uwe,
>
> I modify the sata_sis code to support SiS 966 chipset.
> The SATA IDs could be 0x1180, 0x1182 and 0x1183 in SiS 966 chipset.
>
> Basically, the hardware behavior is same as previous SiS SATA controller.
> Only the port mapping is a little different. 
>
> 1. get_scr_cfg_addr( ) routine: 
> point out where scr register address is, according to the hardware IDs.
>
> 2. sis_scr_cfg_read( ) and sis_scr_cfg_write( ) function: 
> Max two devices (act as mater/salve)can be attached on a channel.
> Per scr_read function is ORed with two scr registers.
> Also per scr_write function need to write two registers.
>
> 3. At init_one( ) function:
> When the sata controller is set as ide (for class code 0101)with legacy
> mode,
> ignore it. I am not sure if this is correct. For unrecognized ide
> controller,
> ide-generic driver will get chance to be loaded. But some boards are
> designed
> with two 0x1180 devices.
>
>
> If you need any resouces( Specification or mother board ), let me know.
> We can prepare it for you. 
>
> David
>
> Signed-off-by: David Wang <touch@sis.com >
> ---
> diff -up a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
> --- a/drivers/scsi/sata_sis.c	2006-08-24 05:16:33.000000000 +0800
> +++ b/drivers/scsi/sata_sis.c	2006-09-01 12:03:16.000000000 +0800
> @@ -71,6 +71,9 @@ static const struct pci_device_id sis_pc
>  	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
>  	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
>  	{ PCI_VENDOR_ID_SI, 0x182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
> +	{ PCI_VENDOR_ID_SI, 0x1180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
>
> +	{ PCI_VENDOR_ID_SI, 0x1182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
> +	{ PCI_VENDOR_ID_SI, 0x1183, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
>
>  	{ }	/* terminate list */
>  };
>  
> @@ -126,7 +129,7 @@ static const struct ata_port_operations 
>  static struct ata_port_info sis_port_info = {
>  	.sht		= &sis_sht,
>  	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
> -			  ATA_FLAG_NO_LEGACY,
> +			  ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS,
>  	.pio_mask	= 0x1f,
>  	.mwdma_mask	= 0x7,
>  	.udma_mask	= 0x7f,
> @@ -140,15 +143,37 @@ MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
>  MODULE_VERSION(DRV_VERSION);
>  
> -static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int
> sc_reg, int device)
> +static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int
> sc_reg, struct pci_dev *pdev)
>  {
>  	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
> +	u32 val = 0;
>  
>  	if (port_no)  {
> -		if (device == 0x182)
> -			addr += SIS182_SATA1_OFS;
> -		else
> -			addr += SIS180_SATA1_OFS;
> +		switch (pdev->device) {
> +			case 0x0180:
> +			case 0x0181:
> +				addr += SIS180_SATA1_OFS;
> +				break;
> +			case 0x0182:
> +			case 0x1182:
> +			case 0x1183:
> +				addr += SIS182_SATA1_OFS;
> +				break;
> +			case 0x1180:
> +				/*
> +				 *  If hw_id == 0x1180
> +				 *  read PCI offset 64h, bit 28 to decide
> what the chip is.
> +				 *  This is the only way to tell SiS966 from
> SiS966L.
> +				 *  1: 966L port0 = c0h, port1 = e0h
> +				 *  0: 966  port0 = c0h, port1 = d0h
> +				 */
> +				pci_read_config_dword(pdev, 0x64, &val);
> +				if (val & (1 << 28))
> +					addr += SIS182_SATA1_OFS; /* SB-966L
> */
> +				else
> +					addr += SIS180_SATA1_OFS; /* 966 */
> +				break;					
> +		}
>  	}
>  
>  	return addr;
> @@ -157,7 +182,7 @@ static unsigned int get_scr_cfg_addr(uns
>  static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
>  {
>  	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
> -	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg,
> pdev->device);
> +	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev);
>  	u32 val, val2 = 0;
>  	u8 pmr;
>  
> @@ -168,16 +193,19 @@ static u32 sis_scr_cfg_read (struct ata_
>  
>  	pci_read_config_dword(pdev, cfg_addr, &val);
>  
> -	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
> +	if ((pdev->device == 0x182) || (pdev->device == 0x1182) ||
> (pdev->device == 0x1183) ||(pmr & SIS_PMR_COMBINED))
>  		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
> -
> -	return val|val2;
> +		
> +	/* Due to the port status is ORed with two SATA ports.
> +	   The unused SATA port might be powered down by BIOS.
> +	   We need to mask 0x3 to report the correct value */
> +	return (val|val2) & 3U;
>  }
>  
>  static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32
> val)
>  {
>  	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
> -	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr,
> pdev->device);
> +	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev);
>  	u8 pmr;
>  
>  	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
> @@ -187,7 +215,7 @@ static void sis_scr_cfg_write (struct at
>  
>  	pci_write_config_dword(pdev, cfg_addr, val);
>  
> -	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
> +	if ((pdev->device == 0x182) || (pdev->device == 0x1182) ||
> (pdev->device == 0x1183) ||(pmr & SIS_PMR_COMBINED))	
>  		pci_write_config_dword(pdev, cfg_addr+0x10, val);
>  }
>  
> @@ -207,10 +235,13 @@ static u32 sis_scr_read (struct ata_port
>  
>  	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
>  
> -	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
> +	if ((pdev->device == 0x182) || (pdev->device == 0x1182) ||
> (pdev->device == 0x1183) ||(pmr & SIS_PMR_COMBINED))
>  		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
> -
> -	return val | val2;
> +		
> +	/* Due to the port status is ORed with two SATA ports.
> +	   The unused SATA port might be powered down by BIOS.
> +	   We need to mask 0x3 to report the correct value */
> +	return (val|val2) & 3U;
>  }
>  
>  static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32
> val)
> @@ -227,7 +258,7 @@ static void sis_scr_write (struct ata_po
>  		sis_scr_cfg_write(ap, sc_reg, val);
>  	else {
>  		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
> -		if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
> +		if ((pdev->device == 0x182) || (pdev->device == 0x1182) ||
> (pdev->device == 0x1183) ||(pmr & SIS_PMR_COMBINED))
>  			outl(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
>  	}
>  }
> @@ -241,11 +272,29 @@ static int sis_init_one (struct pci_dev 
>  	struct ata_port_info *ppi;
>  	int pci_dev_busy = 0;
>  	u8 pmr;
> -	u8 port2_start;
> +	u8 port2_start = 0;
> +	u8 progintf;
> +	u16 classCode;
>  
>  	if (!printed_version++)
>  		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION
> "\n");
>  
> +	/* check if the device's programming interface 09h,
> +	   is compatibility mode
> +	*/
> +	pci_read_config_word(pdev, 0x0A, &classCode);
> +	if (classCode == 0x0101) {
> +		pci_read_config_byte(pdev, 0x09, &progintf);
> +		if ((progintf & 0x5) == 0) {
> +			dev_printk(KERN_INFO, &pdev->dev,
> +				"SiS-%x IDE device is compatibiltiy mode.
> Ignore it\n", 
> +				ent->device);
> +			dev_printk(KERN_INFO, &pdev->dev,
> +				"Try to change BIOS setting with native
> mode..\n");
> +			rc = -1;
> +			return rc;
> +		}
> +	}
>  	rc = pci_enable_device(pdev);
>  	if (rc)
>  		return rc;
> @@ -275,6 +324,10 @@ static int sis_init_one (struct pci_dev 
>  	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
>  		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
>  
> +	/* 0x1180 does not provide SCRs mapping. Set the CFGSCR Flag */
>
> +	if (ent->device == 0x1180)	
> +		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
> +		
>  	/* if hardware thinks SCRs are in IO space, but there are
>  	 * no IO resources assigned, change to PCI cfg space.
>  	 */
> @@ -287,21 +340,31 @@ static int sis_init_one (struct pci_dev 
>  	}
>  
>  	pci_read_config_byte(pdev, SIS_PMR, &pmr);
> -	if (ent->device != 0x182) {
> -		if ((pmr & SIS_PMR_COMBINED) == 0) {
> -			dev_printk(KERN_INFO, &pdev->dev,
> +	switch (ent->device) {
> +		case 0x0180:
> +		case 0x0181:
> +			if ((pmr & SIS_PMR_COMBINED) == 0) {
> +				dev_printk(KERN_INFO, &pdev->dev,
>  				   "Detected SiS 180/181 chipset in SATA
> mode\n");
> -			port2_start = 64;
> -		}
> -		else {
> -			dev_printk(KERN_INFO, &pdev->dev,
> +				port2_start = 64;
> +			}
> +			else {
> +				dev_printk(KERN_INFO, &pdev->dev,
>  				   "Detected SiS 180/181 chipset in combined
> mode\n");
> -			port2_start=0;
> -		}
> -	}
> -	else {
> -		dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182
> chipset\n");
> -		port2_start = 0x20;
> +				port2_start = 0;
> + 		  	}		
> +			break;
> +			
> +		case 0x0182:			
> +		case 0x1182:
> +		case 0x1183:
> +			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS
> 182/1182/1183 SATA controller\n");
> +			port2_start = 0x20;		
> +			break;
> +			
> +		case 0x1180:
> +			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1180
> SATA controller\n");
> +			break;
>  	}
>  
>  	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) {
>
>
>   


-- 
VGER BF report: U 0.5
