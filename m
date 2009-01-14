From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Wed, 14 Jan 2009 13:17:27 +0000
Message-ID: <20090114131727.5b0e5193@lxorguk.ukuu.org.uk>
References: <200901141345.42583.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45883 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755365AbZANNRd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 08:17:33 -0500
In-Reply-To: <200901141345.42583.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

> +#ifdef AT91_GPIO_IRQ_HACK
> +#define NR_TRIES 10
> +	int ntries = 0;
> +	int pin_val1, pin_val2;	
> +	do {
> +		pin_val1 = at91_get_gpio_value(AT91_PIN_PB20);
> +		pin_val2 = at91_get_gpio_value(AT91_PIN_PB20);
> +	} while (pin_val1 != pin_val2 && ntries++ < NR_TRIES);

You really don't want to put special board specific code in generic
locations. In the libata case you don't need to and I think in the ide
case you can avoid it too by wrapping the IRQ handler. Libata also
supports polled mode.

Now one other question - you use the 8/16bit set to flip between register
write sizes. Can you explain exactly what guarantees you don't take an
IRQ between setting the size and a write and having the IRQ handler or a
timer run in the middle, call other IDE routines and mess up because of
this.

I see nothing guaranteeing atomicity here and I suspect you either need
locks or (for single processor only) some carefully arranged scheme to
'stack' the 8/16bit select status.

Other comments:
	- The old and new ATA layers both have timing tables and timing
functions so you don't need all the duplicated timing table logic. 

