From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstream-fixes 3/3] pata_hpt366: reimplement mode programming
Date: Wed, 10 Dec 2008 15:01:08 +0300
Message-ID: <493FAF84.4050006@ru.mvista.com>
References: <493E289F.1010000@kernel.org> <493E28CC.6070000@kernel.org> <493E28FF.8030402@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:24867 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751013AbYLJMBP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Dec 2008 07:01:15 -0500
In-Reply-To: <493E28FF.8030402@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Hello.

Tejun Heo wrote:

> Reimplement mode programming logic of pata_hpt366 such that it's
> identical to that of IDE hpt366 driver.  The differences were...
>
> * pata_hpt366 used 0xCFFF8FFFF to mask pio modes and 0x3FFFFFFF dma
>   modes.  IDE hpt366 uses 0xC1F8FFFF for PIO, 0x303800FF for MWDMA and
>   0x30070000 for UDMA.
>   

   Yeah, so it changes only the applicable timing bits for each mode.

> * pata_hpt366 doesn't set 0x08000000 for PIO unless it's already set
>   and always turns it on for MWDMA/UDMA.  IDE hpt366 doesn't bother
>   with the bit.  It always uses what was there.
>   

   This bit (unless you meant 0x80000000 :-) is just reserved, along 
with 2 neigboring lower order bits.

> * IDE hpt366 always clears 0xC0000000.  pata_hpt366 doesn't.
>   

   This was indeed a big mistake. The table values have PIO_MST bit set 
which enables bus mastering support for PIO modes...

> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Index: work/drivers/ata/pata_hpt366.c
> ===================================================================
> --- work.orig/drivers/ata/pata_hpt366.c
> +++ work/drivers/ata/pata_hpt366.c
[...]
> @@ -222,25 +200,16 @@ static int hpt36x_cable_detect(struct at
>  	return ATA_CBL_PATA80;
>  }
>  
> -/**
> - *	hpt366_set_piomode		-	PIO setup
> - *	@ap: ATA interface
> - *	@adev: device on the interface
> - *
> - *	Perform PIO mode setup.
> - */
> -
> -static void hpt366_set_piomode(struct ata_port *ap, struct ata_device *adev)
> +static void hpt366_set_mode(struct ata_port *ap, struct ata_device *adev,
> +			    u8 mode)
>  {
> +	struct hpt_clock *clocks = ap->host->private_data;
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> -	u32 addr1, addr2;
> -	u32 reg;
> -	u32 mode;
> +	u32 addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
> +	u32 addr2 = 0x51 + 4 * ap->port_no;
>   

   Note that ap->port_no can be safely excluded form all the math due to 
single channel per funcion.

MBR, Sergei


