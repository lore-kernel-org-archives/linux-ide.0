From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: AT91 IDE module
Date: Fri, 26 Nov 2010 19:20:45 +0100
Message-ID: <20101126182045.GA3404@r2bh72.net.upc.cz>
References: <4CEB8FB8.80702@tcz.cz>
 <20101123210054.GA4164@r2bh72.net.upc.cz>
 <4CECDCA5.2060106@tcz.cz>
 <20101124215056.GA2167@r2bh72.net.upc.cz>
 <20101125215319.8uxphaqc0cwo048s@mail.tcz.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.7]:36189 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160Ab0KZSRF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Nov 2010 13:17:05 -0500
Content-Disposition: inline
In-Reply-To: <20101125215319.8uxphaqc0cwo048s@mail.tcz.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Radovan =?iso-8859-1?Q?Vapen=EDk?= <radovan.vapenik@tcz.cz>
Cc: linux-ide@vger.kernel.org

On Thu, Nov 25, 2010 at 09:53:19PM +0100, Radovan Vapen=EDk wrote:
> >We do not detect any IDE device, registers do not contain status/dat=
a
> >that IDE layer expect. As far only two possible reasons of that
> >problem come in mind:
> >- board specific code does not reset CF device (with proper
> >  reset duration?). This is expected, there is rst_pin in
> >  struct at91_cf_data but driver does not use it
> >- CF 9 pin (ATA SEL) is not grounded or set to 0 if connected
> >  to controller (also in board specific initialization code)
> >
> >To debug problem further, you can add your own code at the end of
> >at91_ide_probe(), which read/write IDE register to see if device
> >react properly and give some sensible status values.
> >
> >Stanislaw
> >
>=20
> Seems problem is really on reset pin, i have analysed using
> oscilloscope and on reset pin is still in logical "1", without
> change during module loading. I will try to find out why is this
> happening.

I was unclear. Driver does not change reset pin. Reset need to be
done in board initialization code. You have to add something like that

#define RST_PIN AT91_PIN_PC5
at91_set_gpio_output(RST_PIN, 1);
at91_set_gpio_value(RST_PIN,0);
mdelay(2);
at91_set_gpio_value(RST_PIN,1);

in your arch/arm/mach-at91/board-NAME.c (I'm not sure if 2ms is
correct IDE reset duration).

Stanislaw
