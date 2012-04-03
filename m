From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Tue, 3 Apr 2012 15:37:32 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020698409EBF@AUSP01VMBX24.collaborationhost.net>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0CEF.2040307@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F0020698409E29@AUSP01VMBX24.collaborationhost.net>
 <201204032008.00509.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail131.messagelabs.com ([216.82.242.99]:62614 "EHLO
	mail131.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab2DCUhg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Apr 2012 16:37:36 -0400
In-Reply-To: <201204032008.00509.arnd@arndb.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Rafal Prylowski <prylowski@metasoft.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>, "rmallon@gmail.com" <rmallon@gmail.com>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>

On Tuesday, April 03, 2012 1:08 PM, Arnd Bergmann wrote:
> On Tuesday 03 April 2012, H Hartley Sweeten wrote:
>> On Tuesday, April 03, 2012 7:45 AM, Rafal Prylowski wrote:
>>> +static int __devinit ep93xx_pata_probe(struct platform_device *pdev)
>>> +{
>>> +     struct ep93xx_pata_data *drv_data;
>>> +     struct ata_host *host;
>>> +     struct ata_port *ap;
>>> +     unsigned int irq;
>>> +     struct resource *mem_res;
>>> +     void __iomem *ide_base;
>>> +     int err;
>>> +
>>> +     err = ep93xx_ide_acquire_gpio(pdev);
>>> +     if (err)
>>> +             return err;
>
> Calling into platform code like this is going to make the transition to
> device tree harder. I would suggest moving the code from patch 2 here,
> and subsequently putting the gpio lines into device tree properties.
> when the driver gets converted.

The SYSCON stuff is not exposed outside of the arch specific mach-ep93xx
directory. I would prefer this stay like it is for now. If/when ep93xx gets
converted to device tree we can address this.

I have been looking over the drivers/pinctrl stuff to see if it's worth creating
a pinctrl-ep93xx.c driver. If I end up doing one, the function above could
probably be replaced with something from the pin mux api.

Regards,
Hartley

