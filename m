From: yulin <yulin@starsoftcomm.com>
Subject: Re: [PATCH 2.6.22-rc4]: libata: PATA-mode fixes for sis_sata
Date: Mon, 16 Jul 2007 10:34:35 +0800
Message-ID: <469AD93B.6090509@starsoftcomm.com>
References: <200706142340.44068.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.starsoftcomm.com ([211.100.62.25]:56559 "EHLO
	mail.starsoftcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbXGPChY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jul 2007 22:37:24 -0400
In-Reply-To: <200706142340.44068.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Jeff Garzik <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, micha.biermann@gmx.de

Hi,all,

I have a question about Generic int13h driver.

There is a message about it,=20
http://lists.freebsd.org/pipermail/freebsd-drivers/2007-May/000403.html=
=2E

Because our product is to maintain Windows Desktop in Linux, so it=20
requires the great compatibility of hardware. Now we have solved the=20
problem of display, but harddisk still is a problem.

The motherboards from OEM always have some problem, for example, the=20
same SiS671 motherboards from ASUS and FOXCONN have different phenomeno=
n.

So one leader of our IT, who is a Windows expert, suggested we can use=20
int 13h and I/O in Linux. But int 13h just is used in real mode.

Can you give me some advice to persuade him? If it is feasible, can you=
=20
introduce me?

Even can you give some good solutions to solve the compatibility proble=
m?


 From YuLin


Uwe Koziolek =E5=86=99=E9=81=93:
> Changed PATA handler for PATA-ports used by sata_sis.
> This patch was originally submitted by Jeff Garzik.
>
> Added PCI-ID 1180 for SiS966 Controller in pata_sis.
> The 1180 mode is fully compatible to other SiS PATA-controller.
>
> The PCI-ID 1183 is SATA in PATA-emulation, but not fully compatible
> to SiS5513/5518. sata_sis.c is forwarding this ID to pata_sis.
> 1183 is not working if simply added to pata_sis.
> This handling fixes issues with SiS968.
>
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>
>
> --- a/drivers/ata/pata_sis.c	2007-06-14 22:41:34.000000000 +0200
> +++ b/drivers/ata/pata_sis.c	2007-06-12 22:15:04.000000000 +0200
> @@ -560,6 +560,40 @@
>  	.port_start		=3D ata_port_start,
>  };
> =20
> +static const struct ata_port_operations sis_133_for_sata_ops =3D {
> +	.port_disable		=3D ata_port_disable,
> +	.set_piomode		=3D sis_133_set_piomode,
> +	.set_dmamode		=3D sis_133_set_dmamode,
> +	.mode_filter		=3D ata_pci_default_filter,
> +
> +	.tf_load		=3D ata_tf_load,
> +	.tf_read		=3D ata_tf_read,
> +	.check_status		=3D ata_check_status,
> +	.exec_command		=3D ata_exec_command,
> +	.dev_select		=3D ata_std_dev_select,
> +
> +	.freeze			=3D ata_bmdma_freeze,
> +	.thaw			=3D ata_bmdma_thaw,
> +	.error_handler		=3D ata_bmdma_error_handler,
> +	.post_internal_cmd	=3D ata_bmdma_post_internal_cmd,
> +	.cable_detect		=3D sis_133_cable_detect,
> +
> +	.bmdma_setup		=3D ata_bmdma_setup,
> +	.bmdma_start		=3D ata_bmdma_start,
> +	.bmdma_stop		=3D ata_bmdma_stop,
> +	.bmdma_status		=3D ata_bmdma_status,
> +	.qc_prep		=3D ata_qc_prep,
> +	.qc_issue		=3D ata_qc_issue_prot,
> +	.data_xfer		=3D ata_data_xfer,
> +
> +	.irq_handler		=3D ata_interrupt,
> +	.irq_clear		=3D ata_bmdma_irq_clear,
> +	.irq_on			=3D ata_irq_on,
> +	.irq_ack		=3D ata_irq_ack,
> +
> +	.port_start		=3D ata_port_start,
> +};
> +
>  static const struct ata_port_operations sis_133_early_ops =3D {
>  	.port_disable		=3D ata_port_disable,
>  	.set_piomode		=3D sis_100_set_piomode,
> @@ -733,13 +767,20 @@
>  	.pio_mask	=3D 0x1f,	/* pio0-4 */
>  	.port_ops	=3D &sis_66_ops,
>  };
> -const struct ata_port_info sis_info133 =3D {
> +static const struct ata_port_info sis_info133 =3D {
>  	.sht		=3D &sis_sht,
>  	.flags		=3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
>  	.pio_mask	=3D 0x1f,	/* pio0-4 */
>  	.udma_mask	=3D ATA_UDMA6,
>  	.port_ops	=3D &sis_133_ops,
>  };
> +const struct ata_port_info sis_info133_for_sata =3D {
> +	.sht		=3D &sis_sht,
> +	.flags		=3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
> +	.pio_mask	=3D 0x1f,	/* pio0-4 */
> +	.udma_mask	=3D ATA_UDMA6,
> +	.port_ops	=3D &sis_133_for_sata_ops,
> +};
>  static const struct ata_port_info sis_info133_early =3D {
>  	.sht		=3D &sis_sht,
>  	.flags		=3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
> @@ -749,7 +790,7 @@
>  };
> =20
>  /* Privately shared with the SiS180 SATA driver, not for use elsewhe=
re */
> -EXPORT_SYMBOL_GPL(sis_info133);
> +EXPORT_SYMBOL_GPL(sis_info133_for_sata);
> =20
>  static void sis_fixup(struct pci_dev *pdev, struct sis_chipset *sis)
>  {
> @@ -975,6 +1016,7 @@
>  static const struct pci_device_id sis_pci_tbl[] =3D {
>  	{ PCI_VDEVICE(SI, 0x5513), },	/* SiS 5513 */
>  	{ PCI_VDEVICE(SI, 0x5518), },	/* SiS 5518 */
> +	{ PCI_VDEVICE(SI, 0x1180), },	/* SiS 1180 */
> =20
>  	{ }
>  };
> --- a/drivers/ata/sata_sis.c	2007-06-14 22:41:34.000000000 +0200
> +++ b/drivers/ata/sata_sis.c	2007-06-12 22:16:11.000000000 +0200
> @@ -72,8 +72,8 @@
>  	{ PCI_VDEVICE(SI, 0x0181), sis_180 },		/* SiS 964/180 */
>  	{ PCI_VDEVICE(SI, 0x0182), sis_180 },		/* SiS 965/965L */
>  	{ PCI_VDEVICE(SI, 0x0183), sis_180 },		/* SiS 965/965L */
> -	{ PCI_VDEVICE(SI, 0x1182), sis_180 },		/* SiS 966/966L */
> -	{ PCI_VDEVICE(SI, 0x1183), sis_180 },		/* SiS 966/966L */
> +	{ PCI_VDEVICE(SI, 0x1182), sis_180 },		/* SiS 966/680 */
> +	{ PCI_VDEVICE(SI, 0x1183), sis_180 },		/* SiS 966/966L/968/680 */
> =20
>  	{ }	/* terminate list */
>  };
> @@ -161,7 +161,6 @@
>  			case 0x0182:
>  			case 0x0183:
>  			case 0x1182:
> -			case 0x1183:
>  				addr +=3D SIS182_SATA1_OFS;
>  				break;
>  		}
> @@ -183,8 +182,8 @@
> =20
>  	pci_read_config_dword(pdev, cfg_addr, &val);
> =20
> -	if ((pdev->device =3D=3D 0x0182) || (pdev->device =3D=3D 0x0183) ||=
 (pdev->device =3D=3D 0x1182) ||
> -	    (pdev->device =3D=3D 0x1183) || (pmr & SIS_PMR_COMBINED))
> +	if ((pdev->device =3D=3D 0x0182) || (pdev->device =3D=3D 0x0183) ||
> +	    (pdev->device =3D=3D 0x1182) || (pmr & SIS_PMR_COMBINED))
>  		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
> =20
>  	return (val|val2) &  0xfffffffb; /* avoid problems with powerdowned=
 ports */
> @@ -203,8 +202,8 @@
> =20
>  	pci_write_config_dword(pdev, cfg_addr, val);
> =20
> -	if ((pdev->device =3D=3D 0x0182) || (pdev->device =3D=3D 0x0183) ||=
 (pdev->device =3D=3D 0x1182) ||
> -	    (pdev->device =3D=3D 0x1183) || (pmr & SIS_PMR_COMBINED))
> +	if ((pdev->device =3D=3D 0x0182) || (pdev->device =3D=3D 0x0183) ||
> +	    (pdev->device =3D=3D 0x1182) || (pmr & SIS_PMR_COMBINED))
>  		pci_write_config_dword(pdev, cfg_addr+0x10, val);
>  }
> =20
> @@ -224,8 +223,8 @@
> =20
>  	val =3D ioread32(ap->ioaddr.scr_addr + (sc_reg * 4));
> =20
> -	if ((pdev->device =3D=3D 0x0182) || (pdev->device =3D=3D 0x0183) ||=
 (pdev->device =3D=3D 0x1182) ||
> -	    (pdev->device =3D=3D 0x1183) || (pmr & SIS_PMR_COMBINED))
> +	if ((pdev->device =3D=3D 0x0182) || (pdev->device =3D=3D 0x0183) ||
> +	    (pdev->device =3D=3D 0x1182) || (pmr & SIS_PMR_COMBINED))
>  		val2 =3D ioread32(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
> =20
>  	return (val | val2) &  0xfffffffb;
> @@ -245,8 +244,8 @@
>  		sis_scr_cfg_write(ap, sc_reg, val);
>  	else {
>  		iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4));
> -		if ((pdev->device =3D=3D 0x0182) || (pdev->device =3D=3D 0x0183) |=
| (pdev->device =3D=3D 0x1182) ||
> -		    (pdev->device =3D=3D 0x1183) || (pmr & SIS_PMR_COMBINED))
> +		if ((pdev->device =3D=3D 0x0182) || (pdev->device =3D=3D 0x0183) |=
|
> +		    (pdev->device =3D=3D 0x1182) || (pmr & SIS_PMR_COMBINED))
>  			iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
>  	}
>  }
> @@ -293,11 +292,11 @@
>  		/* The PATA-handling is provided by pata_sis */
>  		switch (pmr & 0x30) {
>  		case 0x10:
> -			ppi[1] =3D &sis_info133;
> +			ppi[1] =3D &sis_info133_for_sata;
>  			break;
> =20
>  		case 0x30:
> -			ppi[0] =3D &sis_info133;
> +			ppi[0] =3D &sis_info133_for_sata;
>  			break;
>  		}
>  		if ((pmr & SIS_PMR_COMBINED) =3D=3D 0) {
> @@ -324,14 +323,14 @@
>  		break;
> =20
>  	case 0x1182:
> +		dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/966/680 SATA =
controller\n");
> +		pi.flags |=3D ATA_FLAG_SLAVE_POSS;
> +		break;
> +
>  	case 0x1183:
> -		pci_read_config_dword(pdev, 0x64, &val);
> -		if (val & 0x10000000) {
> -			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966L SA=
TA controller\n");
> -		} else {
> -			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966 SAT=
A controller\n");
> -			pi.flags |=3D ATA_FLAG_SLAVE_POSS;
> -		}
> +		dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1183/966/966L/968/=
680 controller in PATA mode\n");
> +		ppi[0] =3D &sis_info133_for_sata;
> +		ppi[1] =3D &sis_info133_for_sata;
>  		break;
>  	}
> =20
> --- a/drivers/ata/sis.h	2007-06-14 22:41:34.000000000 +0200
> +++ b/drivers/ata/sis.h	2007-06-09 22:30:43.000000000 +0200
> @@ -2,4 +2,4 @@
>  struct ata_port_info;
> =20
>  /* pata_sis.c */
> -extern const struct ata_port_info sis_info133;
> +extern const struct ata_port_info sis_info133_for_sata;
>
>
>
>  =20

