From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [patch v3 1/1] ata: Add iMX pata support
Date: Tue, 26 Jul 2011 12:04:27 +0200
Message-ID: <877h75mk7o.fsf@lebrac.rtp-net.org>
References: <20110724183805.992906251@rtp-net.org>
	<20110724183823.420642781@rtp-net.org>
	<20110726073911.GG20587@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:47358 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab1GZKEt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2011 06:04:49 -0400
In-Reply-To: <20110726073911.GG20587@pengutronix.de> (Sascha Hauer's message
	of "Tue, 26 Jul 2011 09:39:11 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Sascha Hauer <s.hauer@pengutronix.de> writes:

> Hi Arnaud,

Hi,
>
> On Sun, Jul 24, 2011 at 08:38:07PM +0200, Arnaud Patard wrote:
>> Add basic support for pata on iMX. It has been tested only on imx51.
>> SDMA support will probably be added later so this version supports only
>> PIO.
>> 
>> v2:
>>   - enable only when needed IORDY
>>   - use dev_get_drvdata
>> v3:
>>   - add missing clk_put() calls
>>   - use platform_get_irq()
>>   - fix resume code to avoid disabling IORDY on resume
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Index: linux-2.6-submit/drivers/ata/Kconfig
>> ===================================================================
>> --- linux-2.6-submit.orig/drivers/ata/Kconfig	2011-07-22 23:29:06.000000000 +0200
>> +++ linux-2.6-submit/drivers/ata/Kconfig	2011-07-22 23:30:58.000000000 +0200
>> @@ -467,6 +467,15 @@ config PATA_ICSIDE
>>  	  interface card.  This is not required for ICS partition support.
>>  	  If you are unsure, say N to this.
>>  
>> +config PATA_IMX
>> +	tristate "PATA support for Freescale iMX (Experimental)"
>> +	depends on ARCH_MX5 && EXPERIMENTAL
>
> Should this really depend on EXPERIMENTAL? This driver looks pretty
> straightforward.

I've been wondering about it but given that it has been tested only on
efika platforms, I prefered to keep it. If you think it's better to
remove it, fine. I'll do it.

>
> Also, please depend on ARCH_MXC instead. This may make this driver
> selectable on some i.MX SoCs which do not support it, but we don't
> have to add new ARCH_MX* to this list once a new SoC is supported.

Well, it's for the same reason as for the EXPERIMENTAL. It's working on
my mx51 platforms, but I've not tested on plateforms like iMX3 (as I
don't have them). Will change.

>
> (And no, IMX_HAVE_PLATFORM_BLA_BLA is not a good idea either as we are
> converting to the device tree and the Kconfig entries will probably go
> in the longer run)
>
>
>> +
>> +static int __devinit pata_imx_probe(struct platform_device *pdev)
>> +{
>> +	struct ata_host *host;
>> +	struct ata_port *ap;
>> +	struct pata_imx_priv *priv;
>> +	int irq = 0;
>> +	struct resource *io_res;
>> +
>> +	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (io_res == NULL)
>> +		return -EINVAL;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq <= 0)
>> +		return -EINVAL;
>> +
>> +	priv = kzalloc(sizeof(struct pata_imx_priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>
> Given that you already use devm_ioremap, you can also use devm_kzalloc
> here.

thanks, will do. I didn't know there was such a function.
>
>> +
>> +	priv->clk = clk_get(&pdev->dev, "imx-pata");
>> +	if (!priv->clk)
>
> IS_ERR(priv->clk)
>
> (also for the checks below)
>
> Does it really make sense to continue when the clock failed?

if you have uboot version like the one I have, the clock will be already
enabled before booting linux so the driver will work. Maybe too fragile ?
I've changed the checks on my local version and about to test it. Let me
know if you think it should really be a failure, in order to avoid
having to send a new version only to make it a failure.

>
>> +		dev_warn(&pdev->dev, "Failed to get clock\n");
>> +	else
>> +		clk_enable(priv->clk);
>> +
>> +
>> +	host = ata_host_alloc(&pdev->dev, 1);
>> +	if (!host)
>> +		goto free_priv;
>> +
>> +	host->private_data = priv;
>> +	ap = host->ports[0];
>> +
>> +	ap->ops = &pata_imx_port_ops;
>> +	ap->pio_mask = ATA_PIO0;
>> +	ap->flags |= ATA_FLAG_SLAVE_POSS;
>> +
>> +	priv->host_regs = devm_ioremap(&pdev->dev, io_res->start, 0x40);
>
> resource_size() instead of hardcoded 0x40?
>
>> +	ap->ioaddr.cmd_addr = devm_ioremap(&pdev->dev,
>> +					io_res->start + PATA_IMX_DRIVE_DATA,
>> +					0x20);
>> +	ap->ioaddr.ctl_addr = devm_ioremap(&pdev->dev,
>> +					io_res->start + PATA_IMX_DRIVE_CONTROL,
>> +					0x04);
>
> It looks strange to ioremap the register offsets again. Why not just a
>
> 	ap->ioaddr.cmd_addr = priv->host_regs + PATA_IMX_DRIVE_DATA
> 	ap->ioaddr.ctl_addr = priv->host_regs + PATA_IMX_DRIVE_CONTROL
>
> Hm, probably copied from the pxa driver, but this uses different
> resources which makes different ioremaps necessary.

There are holes in the register map in the manual, that's why I used
several ioremap. I prefer staying near to what the manual says and avoid
remapping unknown registers.

Thanks,
Arnaud
