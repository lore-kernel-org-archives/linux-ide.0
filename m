From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add PATA host controller support for Cirrus Logic's
 EP93xx CPUs
Date: Thu, 26 Nov 2009 17:03:39 +0000
Message-ID: <20091126170339.218f6674@lxorguk.ukuu.org.uk>
References: <200911261651.40928.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48885 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760840AbZKZRCJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 12:02:09 -0500
In-Reply-To: <200911261651.40928.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.montavista.com>, Joao Ramos <joao.ramos@inov.pt>, H Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>


> +static void pata_ep93xx_set_piomode(struct ata_port *ap,
> +				    struct ata_device *adev)
> +{
> +	void __iomem *base = ap->host->private_data;
> +	struct ata_device *pair = ata_dev_pair(adev);
> +	const struct ata_timing *t = ata_timing_find_mode(adev->pio_mode);
> +	const struct ata_timing *cmd_t = t;
> +	u32 reg = IDECFG_IDEEN | IDECFG_PIO;
> +	u8 pio = adev->pio_mode - XFER_PIO_0;
> +
> +	if (pair && pair->pio_mode < adev->pio_mode)
> +		cmd_t = ata_timing_find_mode(pair->pio_mode);
> +
> +	/*
> +	 * store the adequate PIO mode timings, to be used later
> +	 * by pata_ep93xx_{read,write}
> +	 */
> +	adev->private_data = (void *)t;
> +	ap->private_data = (void *)cmd_t;
> +
> +	/* reconfigure IDE controller according to PIO mode (?) */

This would probably be better in both drivers as a simple table. It would
then not be a switch but collapse the entire pile into a single

	writel(pio_timing[pio], base + IDECFG);


> +static u16 __pata_ep93xx_read(void __iomem *base, void *addr,
> +			      struct ata_timing *t)
> +{
> +	u32 reg;
> +
> +	reg = (unsigned long)addr | IDECTRL_DIORN | IDECTRL_DIOWN;
> +	writel(reg, base + IDECTRL);
> +	ndelay(t->setup);

This implies a bus with no posting, which seems to the case from the
other driver code.

> +	while (!pata_ep93xx_check_iordy(base))
> +		cpu_relax();

And if the drive was hot unplugged this is doom incorporated (plus we
might not be using an IORDY mode.

>
> +	while (!pata_ep93xx_check_iordy(base))
> +		cpu_relax();

Ditto


I don't see anything wrong in the conversion. 

The size thing is true - libata tried to abstract at a higher level which
in turn avoids lots of computed branches to one liners and lets the
compiler inline stuff better (eg all the private read/write methods into
a single call free tf_* etc). It could I guess provide an "awkward
case" skeleton tf_* and other sets of functions that were passed inb/outb
ops. One for Jeff to ponder ?



Alan
