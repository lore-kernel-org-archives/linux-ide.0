From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] libata: Add pata_atp867x driver for Artop/Acard ATP867X
    controllers
Date: Sat, 12 Sep 2009 10:49:38 -0600
Message-ID: <4AABD122.2000400@gmail.com>
References: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com> 	<1252721641.28368.34.camel@desktop> <8b5805ff0909120359g2faf661br463b19518d935110@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f176.google.com ([209.85.210.176]:51127 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbZILQtj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Sep 2009 12:49:39 -0400
In-Reply-To: <8b5805ff0909120359g2faf661br463b19518d935110@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jung-Ik (John) Lee" <jilee@google.com>
Cc: Daniel Walker <dwalker@fifo99.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Eric Uhrhane <ericu@google.com>

On 09/12/2009 04:59 AM, Jung-Ik (John) Lee wrote:

(snip)

Looks mostly reasonable to me, other than a few issues:

> +static void atp867x_set_piomode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	struct ata_device *peer = ata_dev_pair(adev);
> +	struct atp867x_priv *dp = ap->private_data;
> +	u8 speed = adev->pio_mode;
> +	struct ata_timing t, p;
> +	int T, UT;
> +	u8 b;
> +
> +	T = 1000000000 / 33333;
> +	UT = T/4;
> +
> +	switch (speed) {
> +	case XFER_PIO_4:
> +	case XFER_PIO_3:
> +	case XFER_PIO_2:
> +	case XFER_PIO_1:
> +	case XFER_PIO_0:
> +	case XFER_PIO_SLOW:
> +		break;
> +	default:
> +		printk(KERN_WARNING "ATP867X: Unsupported speed %#x."
> +			" Default to XFER_PIO_0.\n", (unsigned)speed);
> +		speed = XFER_PIO_0;
> +	}
> +
> +	ata_timing_compute(adev, speed,&t, T, UT);
> +	if (peer&&  peer->pio_mode) {
> +		ata_timing_compute(peer, peer->pio_mode,&p, T, UT);
> +		ata_timing_merge(&p,&t,&t, ATA_TIMING_8BIT);
> +	}
> +
> +	b = inb(dp->dma_mode);
> +	if (adev->devno&  1)
> +		b = (b&  ~ATP867X_IO_DMAMODE_SLAVE_MASK);
> +	else
> +		b = (b&  ~ATP867X_IO_DMAMODE_MSTR_MASK);
> +	outb(b, dp->dma_mode);
> +
> +#ifdef ATP867X_NO_HACK_PIOMODE
> +	b = atp867x_get_active_clocks_shifted(t.active) |
> +		atp867x_get_recover_clocks_shifted(t.recover);
> +#else
> +	/*
> +	 * magic value that works (from doc 6.4, 6.6.9)
> +	 */
> +	b = 0x31;
> +#endif

What's the purpose of this ifdef?

> +	if (dp->pci66mhz)
> +		b += 0x10;
> +
> +	if (adev->devno&  1)
> +		outb(b, dp->slave_piospd);
> +	else
> +		outb(b, dp->mstr_piospd);
> +
> +	/*
> +	 * use the same value for comand timing as for PIO timimg
> +	 */
> +	outb(b, dp->eightb_piospd);
> +}
> +
> +static int atp867x_cable_detect(struct ata_port *ap)
> +{
> +	return ATA_CBL_PATA40_SHORT;
> +}

Doesn't the controller have a way to do proper 80-wire cable detection?

