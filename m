From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] scsi/ahci: Add support for ULi M5287
Date: Sat, 05 Feb 2005 23:49:41 -0500
Message-ID: <4205A1E5.9090808@pobox.com>
References: <OFFB59EB4E.1CCBBD25-ON48256F70.003999B0@uli.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64432 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S269069AbVBFEt4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Feb 2005 23:49:56 -0500
In-Reply-To: <OFFB59EB4E.1CCBBD25-ON48256F70.003999B0@uli.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer.Chen@uli.com.tw
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andrebalsa@mailingaddress.org, Clear.Zhang@uli.com.tw, Emily.Jiang@uli.com.tw, Eric.Lo@uli.com.tw

Peer.Chen@uli.com.tw wrote:
> Hi,Jeff
> 
> We add the support for ULi's AHCI controller M5287 in drivers/scsi/ahci.c,
> This patch is applied to kernel 2.6.10-rc3. Please apply to new kernels.

Ideally I would like to eliminate vendor-specific code, where possible.

Does the AHCI driver work at all, with simply the addition of the PCI ID?

Detailed comments below.


> --- linux-2.6.10-rc3/drivers/scsi/ahci.c.orig   2004-12-11
> 03:14:17.170955840 +0800
> +++ linux-2.6.10-rc3/drivers/scsi/ahci.c  2004-12-11 03:31:40.979272856
> +0800
> @@ -241,6 +241,8 @@ static struct pci_device_id ahci_pci_tbl
>         board_ahci },
>       { PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>         board_ahci },
> +     { PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +       board_ahci },
>       { }   /* terminate list */
>  };

OK


> @@ -555,7 +557,6 @@ static void ahci_intr_error(struct ata_p
>             writel(0x300, port_mmio + PORT_SCR_CTL);
>             readl(port_mmio + PORT_SCR_CTL); /* flush */
>       }
> -
>       /* re-start DMA */
>       tmp = readl(port_mmio + PORT_CMD);
>       tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
> @@ -711,12 +712,29 @@ static int ahci_host_init(struct ata_pro
>       unsigned int i, j, using_dac;
>       int rc;
>       void __iomem *port_mmio;
> +     u8 rev_id;        //peer add for m5287 rev 02h
> 
> +     pci_read_config_byte(pdev, PCI_REVISION_ID, &rev_id);
>       cap_save = readl(mmio + HOST_CAP);
>       cap_save &= ( (1<<28) | (1<<17) );
>       cap_save |= (1 << 27);
> 
>       /* global controller reset */
> +//peer add for m5287 rev 02h
> +     if(pdev->vendor==PCI_VENDOR_ID_AL && pdev->device==0x5287 && rev_id
> ==0x02)
> +     {
> +           tmp = readl(mmio + HOST_CTL);
> +           writel(tmp & ~HOST_RESET, mmio + HOST_CTL);
> +           readl(mmio + HOST_CTL); /* flush */
> +           writel(tmp | HOST_RESET, mmio + HOST_CTL);
> +           readl(mmio + HOST_CTL); /* flush */
> +           writel(tmp & ~HOST_RESET, mmio + HOST_CTL);
> +           readl(mmio + HOST_CTL); /* flush */
> +
> +     }
> +//peer add end
> +     else
> +     {
>       tmp = readl(mmio + HOST_CTL);
>       if ((tmp & HOST_RESET) == 0) {
>             writel(tmp | HOST_RESET, mmio + HOST_CTL);
> @@ -735,6 +753,7 @@ static int ahci_host_init(struct ata_pro
>             return -EIO;
>       }
> 
> +     }
>       writel(HOST_AHCI_EN, mmio + HOST_CTL);
>       (void) readl(mmio + HOST_CTL);      /* flush */
>       writel(cap_save, mmio + HOST_CAP);

My conclusion from this change is that you are simply impatient with the 
1-second delay for host reset ;-)

That is a fair criticism.  I confess that the reason for the 1-second 
delay is pure laziness.  However, my suggestion would be:

1) eliminate the ULi-specific code

2) rewrite the host reset code so that it
	a) performs the host reset as you (ULi) have written
	b) polls host reset register for completion, as described
	   in AHCI specification

This will perform a very rapid reset, and eliminate the annoying delay.


> @@ -796,6 +815,18 @@ static int ahci_host_init(struct ata_pro
>             /* make sure port is not active */
>             tmp = readl(port_mmio + PORT_CMD);
>             VPRINTK("PORT_CMD 0x%x\n", tmp);
> +//peer add for m5287 rev 02h
> +           if(pdev->vendor==PCI_VENDOR_ID_AL && pdev->device==0x5287 &&
> rev_id==0x02)
> +           {
> +                 //set start bit then issue comreset when initialize
> +                 writel((tmp|PORT_CMD_START), port_mmio + PORT_CMD);
> +                 writel(0x01, port_mmio + PORT_SCR_CTL);
> +                 readl(port_mmio + PORT_SCR_CTL); /* flush */
> +                 msleep(1);
> +                 writel(0x0, port_mmio + PORT_SCR_CTL);
> +                 readl(port_mmio + PORT_SCR_CTL); /* flush */
> +           }
> +//peer add end

3) should we do this for all AHCI controllers?

4) performing host reset should perform COMRESET, until staggered spinup 
is select.  So the COMRESET portion of your code appears incorrect 
W.R.T. the AHCI specification.

Please comment.

Thanks and regards,

	Jeff


