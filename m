From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Wed, 20 Apr 2011 18:54:41 +0400
Message-ID: <4DAEF3B1.6020304@ru.mvista.com>
References: <1303152147.7167.12.camel@mulgrave.site>	 <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>	 <1303159802.7167.30.camel@mulgrave.site>	 <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>	 <4DADF798.6010705@ru.mvista.com>	 <20110419221900.67528a07@lxorguk.ukuu.org.uk>	 <4DADFD2E.9070809@ru.mvista.com>	 <20110419222838.6a6f36aa@lxorguk.ukuu.org.uk>	 <1303254709.11237.34.camel@mulgrave.site>  <4DAEAF9A.1020704@ru.mvista.com> <1303309698.2587.10.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303309698.2587.10.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello.

On 20-04-2011 18:28, James Bottomley wrote:

>>> +		dev_printk(KERN_NOTICE,&pdev->dev, "Mobility Bridge detected, ig=
noring CNTRL port enable/disable\n");
>>> +	/* 643 and 646 no UDMA, primary port always enabled */
>>> +	if (port_ok&&  id->driver_data>  1&&   !(reg&  CNTRL_PRIMARY)) {

    This should probably be:

	if (port_ok && !(id->driver_data =3D=3D 0 || id->driver_data =3D=3D 1 =
&&
	    pdev->revision < 3) && !(reg & CNTRL_PRIMARY)) {

>>      PCI0646U and later revisions on PCI0646 do have the primary por=
t enable
>> bit. The same about UltraDMA -- PCI0646U2 has it. Look at what cmd64=
x does in
>> cmd64x_init_one()...

> Where?  All I see in drivers/ide/cmd64x.c is that it only ignores the
> primary for the id->driver_data =3D=3D 0 case, which is what I origin=
ally
> coded.

    Hm, are we looking at the same driver?

static const struct ide_port_info cmd64x_chipsets[] __devinitdata =3D {
	{	/* 0: CMD643 */
		.name		=3D DRV_NAME,
		.init_chipset	=3D init_chipset_cmd64x,
		.enablebits	=3D {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
		.port_ops	=3D &cmd64x_port_ops,
		.host_flags	=3D IDE_HFLAG_CLEAR_SIMPLEX |
				  IDE_HFLAG_ABUSE_PREFETCH |
				  IDE_HFLAG_SERIALIZE,
		.pio_mask	=3D ATA_PIO5,
		.mwdma_mask	=3D ATA_MWDMA2,
		.udma_mask	=3D 0x00, /* no udma */
	},
	{	/* 1: CMD646 */
		.name		=3D DRV_NAME,
		.init_chipset	=3D init_chipset_cmd64x,
		.enablebits	=3D {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
		.port_ops	=3D &cmd648_port_ops,
		.host_flags	=3D IDE_HFLAG_ABUSE_PREFETCH |
				  IDE_HFLAG_SERIALIZE,
		.pio_mask	=3D ATA_PIO5,
		.mwdma_mask	=3D ATA_MWDMA2,
		.udma_mask	=3D ATA_UDMA2,
	},
	{	/* 2: CMD648 */
		.name		=3D DRV_NAME,
		.init_chipset	=3D init_chipset_cmd64x,
		.enablebits	=3D {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
		.port_ops	=3D &cmd648_port_ops,
		.host_flags	=3D IDE_HFLAG_ABUSE_PREFETCH,
		.pio_mask	=3D ATA_PIO5,
		.mwdma_mask	=3D ATA_MWDMA2,
		.udma_mask	=3D ATA_UDMA4,
	},
	{	/* 3: CMD649 */
		.name		=3D DRV_NAME,
		.init_chipset	=3D init_chipset_cmd64x,
		.enablebits	=3D {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
		.port_ops	=3D &cmd648_port_ops,
		.host_flags	=3D IDE_HFLAG_ABUSE_PREFETCH,
		.pio_mask	=3D ATA_PIO5,
		.mwdma_mask	=3D ATA_MWDMA2,
		.udma_mask	=3D ATA_UDMA5,
	}
};

static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct=20
pci_device_id *id)
{
	struct ide_port_info d;
	u8 idx =3D id->driver_data;

	d =3D cmd64x_chipsets[idx];

	if (idx =3D=3D 1) {
		/*
		 * UltraDMA only supported on PCI646U and PCI646U2, which
		 * correspond to revisions 0x03, 0x05 and 0x07 respectively.
		 * Actually, although the CMD tech support people won't
		 * tell me the details, the 0x03 revision cannot support
		 * UDMA correctly without hardware modifications, and even
		 * then it only works with Quantum disks due to some
		 * hold time assumptions in the 646U part which are fixed
		 * in the 646U2.
		 *
		 * So we only do UltraDMA on revision 0x05 and 0x07 chipsets.
		 */
		if (dev->revision < 5) {
			d.udma_mask =3D 0x00;
			/*
			 * The original PCI0646 didn't have the primary
			 * channel enable bit, it appeared starting with
			 * PCI0646U (i.e. revision ID 3).
			 */
			if (dev->revision < 3) {
				d.enablebits[0].reg =3D 0;
				d.port_ops =3D &cmd64x_port_ops;
				if (dev->revision =3D=3D 1)
					d.dma_ops =3D &cmd646_rev1_dma_ops;
			}
		}
	}

	return ide_pci_init_one(dev, &d, NULL);
}

static const struct pci_device_id cmd64x_pci_tbl[] =3D {
	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_646), 1 },
	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_648), 2 },
	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_649), 3 },
	{ 0, },
};
MODULE_DEVICE_TABLE(pci, cmd64x_pci_tbl);

    "=C3=AFdx =3D=3D 1" corresponds to PCI0646. See this "dev->revision=
 < 3" check=20
(this is true for the original PCI0646), where it then zeroes the 'reg'=
 field=20
of 'enablebits' to disable its checking?

> James

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
