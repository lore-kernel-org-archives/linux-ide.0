From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [patch 1/1] ata: Add iMX pata support
Date: Fri, 22 Jul 2011 15:56:27 +0400
Message-ID: <4E29656B.6030203@ru.mvista.com>
References: <20110716210420.234549871@rtp-net.org> <4E22E45E.40807@ru.mvista.com> <87oc0noc94.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50852 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab1GVL4v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jul 2011 07:56:51 -0400
Received: by wyg8 with SMTP id 8so1444698wyg.19
        for <linux-ide@vger.kernel.org>; Fri, 22 Jul 2011 04:56:50 -0700 (PDT)
In-Reply-To: <87oc0noc94.fsf@lebrac.rtp-net.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, s.hauer@pengutronix.de, jgarzik@pobox.com

Hello.

On 21-07-2011 19:59, Arnaud Patard (Rtp) wrote:

>>> Add basic support for pata on iMX. It has been tested only on imx51.
>>> SDMA support will probably be added later so this version supports only
>>> PIO.

>>> Signed-off-by: Arnaud Patard<arnaud.patard@rtp-net.org>
>> [...]
>>> Index: linux-2.6-submit/drivers/ata/pata_imx.c
>>> ===================================================================
>>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>>> +++ linux-2.6-submit/drivers/ata/pata_imx.c	2011-07-16 22:35:41.000000000 +0200
>>> @@ -0,0 +1,254 @@
>> [...]

>>> +static int __devinit pata_imx_probe(struct platform_device *pdev)
>>> +{
>>> +	struct ata_host *host;
>>> +	struct ata_port *ap;
>>> +	struct pata_imx_priv *priv;
>>> +	int irq = 0;
>>> +	struct resource *io_res;
>>> +	struct resource *irq_res;
>>> +
>>> +	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (io_res == NULL)
>>> +		return -EINVAL;
>>> +
>>> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

>>     Why not use platform_get_irq()?

> No special reason. Was using get_resource() for mem, so I used it for
> irq too.

     platform_get_irq() would yield smaller code.

>>> +	if (irq_res == NULL)
>>> +		return -EINVAL;
>>> +	irq = irq_res->start;
>>> +
>>> +	priv = kzalloc(sizeof(struct pata_imx_priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->clk = clk_get(&pdev->dev, "imx-pata");
>>
>>     Does iMX support clkdev?
>>
>> [...]

> iirc, it's not supported

    Then it's good idea to pass the clock name thru the platfrom data.

WBR, Sergei
