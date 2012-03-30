From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH 2/3] ep93xx: IDE driver platform support code
Date: Fri, 30 Mar 2012 10:29:48 +0200
Message-ID: <4F756EFC.3080501@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl> <4F741B07.7040107@metasoft.pl> <ADE657CA350FB648AAC2C43247A983F00206970255B6@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:49835 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758579Ab2C3IaF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Mar 2012 04:30:05 -0400
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F00206970255B6@AUSP01VMBX24.collaborationhost.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bzolnier@gmail.com" <bzolnier@gmail.com>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2012-03-29 18:26, H Hartley Sweeten wrote:
>> +/*************************************************************************
>> + * EP93xx IDE
>> + *************************************************************************/
>> +static struct resource ep93xx_ide_resources[] = {
>> +	[0] = {
>> +		.start	= EP93XX_IDE_PHYS_BASE,
>> +		.end	= EP93XX_IDE_PHYS_BASE + 0xffff,
>> +		.flags	= IORESOURCE_MEM,
>> +	},
>> +	[1] = {
>> +		.start	= IRQ_EP93XX_EXT3,
>> +		.end	= IRQ_EP93XX_EXT3,
>> +		.flags	= IORESOURCE_IRQ,
>> +	},
>> +};
> 
> Please use the DEFINE_RES_* macros.
> Also, the last register in the IDE interface is at offset 0x34, so something like this:
> 
> static struct resource ep93xx_ide_resources[] = {
> 	DEFINE_RES_MEM(EP93XX_IDE_PHYS_BASE, 0x38),
> 	DEFINE_RES_IRQ(IRQ_EP93XX_EXT3),
> };
> 

Ok. Will do.

>> +void __init ep93xx_register_ide(void)
>> +{
>> +	/* GPIO ports E, G and H used by IDE */
>> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
>> +				 EP93XX_SYSCON_DEVCFG_GONIDE |
>> +				 EP93XX_SYSCON_DEVCFG_HONIDE);
>> +	platform_device_register(&ep93xx_ide_device);
>> +}
> 
> Please create ep93xx_ide_acquire_gpio and ep93xx_ide_acquire_gpio functions
> to set/clear the necessary SYSCON bits during the probe/remove of the ide driver.
> 
> This should also address your concern mentioned in PATCH 0/3 about making sure
> the pin muxing is correct when the driver is loaded.
> 
> The *_acquire_gpio function should also gpio_request  the pins before setting the
> SYSCON bits. That way if any of the pins are unavailable the driver will not load. Make
> sure to gpio_free the pins in the *_release_gpio function.  Look at how the keypad
> is handled for an example.

Yes, that makes sense. I will add necessary functions and modify the driver accordingly.

Thanks for comments.

Regards,
RP

