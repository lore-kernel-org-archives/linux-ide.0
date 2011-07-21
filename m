From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [patch 1/1] ata: Add iMX pata support
Date: Thu, 21 Jul 2011 17:59:51 +0200
Message-ID: <87oc0noc94.fsf@lebrac.rtp-net.org>
References: <20110716210420.234549871@rtp-net.org>
	<4E22E45E.40807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:54920 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1GUQAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jul 2011 12:00:09 -0400
In-Reply-To: <4E22E45E.40807@ru.mvista.com> (Sergei Shtylyov's message of
	"Sun, 17 Jul 2011 17:32:14 +0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, s.hauer@pengutronix.de, jgarzik@pobox.com

Sergei Shtylyov <sshtylyov@mvista.com> writes:

> Hello.

Hi,
>
> On 17-07-2011 1:04, Arnaud Patard (Rtp) wrote:
>
>> Add basic support for pata on iMX. It has been tested only on imx51.
>> SDMA support will probably be added later so this version supports only
>> PIO.
>
>> Signed-off-by: Arnaud Patard<arnaud.patard@rtp-net.org>
> [...]
>> Index: linux-2.6-submit/drivers/ata/pata_imx.c
>> ===================================================================
>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>> +++ linux-2.6-submit/drivers/ata/pata_imx.c	2011-07-16 22:35:41.000000000 +0200
>> @@ -0,0 +1,254 @@
> [...]
>> + * TODO:
>> + * - dmaengine support
>> + * - check if timing stuff needed
>
>    Sure, it's needed, especially if you want to support DMA.
>
>> +#define PATA_IMX_ATA_CONTROL		0x24
>> +#define PATA_IMX_ATA_CTRL_FIFO_RST_B	(1<<7)
>> +#define PATA_IMX_ATA_CTRL_ATA_RST_B	(1<<6)
>> +#define PATA_IMX_ATA_CTRL_IORDY_EN	(1<<0)
>
>    So, it seems to support advanced PIO modes...
>
>> +static int __devinit pata_imx_probe(struct platform_device *pdev)
>> +{
>> +	struct ata_host *host;
>> +	struct ata_port *ap;
>> +	struct pata_imx_priv *priv;
>> +	int irq = 0;
>> +	struct resource *io_res;
>> +	struct resource *irq_res;
>> +
>> +	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (io_res == NULL)
>> +		return -EINVAL;
>> +
>> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>
>    Why not use platform_get_irq()?

No special reason. Was using get_resource() for mem, so I used it for
irq too.

>
>> +	if (irq_res == NULL)
>> +		return -EINVAL;
>> +	irq = irq_res->start;
>> +
>> +	priv = kzalloc(sizeof(struct pata_imx_priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->clk = clk_get(&pdev->dev, "imx-pata");
>
>    Does iMX support clkdev?
>
> [...]

iirc, it's not supported

>> +	ap->ops = &pata_imx_port_ops;
>> +	/* pio 0-4 */
>> +	ap->pio_mask = ATA_PIO4;
>
>    But you don't support PIO1-4!
>
>> +	ap->flags |= ATA_FLAG_SLAVE_POSS;
>> +
>> +	priv->host_regs = devm_ioremap(&pdev->dev, io_res->start, 0x40);
>> +	ap->ioaddr.cmd_addr = devm_ioremap(&pdev->dev,
>> +					io_res->start + PATA_IMX_DRIVE_DATA,
>> +					0x20);
>> +	ap->ioaddr.ctl_addr = devm_ioremap(&pdev->dev,
>> +					io_res->start + PATA_IMX_DRIVE_CONTROL,
>> +					0x04);
>
>    Why not ioremap all registers as one block?
>

the manual doesn't talk about the address space in between so I prefered
to be safe and use 2 parts, like the manual.

>> +	ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
>> +		(unsigned long long)io_res->start + PATA_IMX_DRIVE_DATA,
>> +		(unsigned long long)io_res->start + PATA_IMX_DRIVE_CONTROL);
>> +
>> +	/* deassert resets */
>> +	__raw_writel(PATA_IMX_ATA_CTRL_FIFO_RST_B |
>> +			PATA_IMX_ATA_CTRL_ATA_RST_B |
>> +			PATA_IMX_ATA_CTRL_IORDY_EN,
>
>    You can't enable IORDY by default, only when the drive supports it!
>

hm... ok. The original code was enabling it in the machine file and fsl
driver doesn't handle IORDY at all so I'm not sure how to do that and
make sure it won't break. I guess I'll have to see if it break on my
system to test it but it's not a really complete test.

> [...]
>> +#ifdef CONFIG_PM
>> +static int pata_imx_suspend(struct device *dev)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct ata_host *host = platform_get_drvdata(pdev);
>
>    You can just use dev_get_drvdata(), without calling to_platfrom_device().
>

ok.

Arnaud
