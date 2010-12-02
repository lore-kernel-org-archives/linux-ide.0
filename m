From: =?ISO-8859-1?Q?Radovan_V=E1pen=EDk?= <radovan.vapenik@tcz.cz>
Subject: Re: AT91 IDE module
Date: Thu, 02 Dec 2010 17:10:21 +0100
Message-ID: <4CF7C4ED.6070400@tcz.cz>
References: <4CEB8FB8.80702@tcz.cz> <20101123210054.GA4164@r2bh72.net.upc.cz> <4CECDCA5.2060106@tcz.cz> <20101124215056.GA2167@r2bh72.net.upc.cz> <20101125215319.8uxphaqc0cwo048s@mail.tcz.cz> <20101126182045.GA3404@r2bh72.net.upc.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms.tcz.cz ([62.77.127.194]:39749 "EHLO ms.tcz.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757097Ab0LBQKp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Dec 2010 11:10:45 -0500
In-Reply-To: <20101126182045.GA3404@r2bh72.net.upc.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org

Stanislaw Gruszka napsal(a):
> On Thu, Nov 25, 2010 at 09:53:19PM +0100, Radovan Vapen=EDk wrote:
>  =20
>>> We do not detect any IDE device, registers do not contain status/da=
ta
>>> that IDE layer expect. As far only two possible reasons of that
>>> problem come in mind:
>>> - board specific code does not reset CF device (with proper
>>>  reset duration?). This is expected, there is rst_pin in
>>>  struct at91_cf_data but driver does not use it
>>> - CF 9 pin (ATA SEL) is not grounded or set to 0 if connected
>>>  to controller (also in board specific initialization code)
>>>
>>> To debug problem further, you can add your own code at the end of
>>> at91_ide_probe(), which read/write IDE register to see if device
>>> react properly and give some sensible status values.
>>>
>>> Stanislaw
>>>
>>>      =20
>> Seems problem is really on reset pin, i have analysed using
>> oscilloscope and on reset pin is still in logical "1", without
>> change during module loading. I will try to find out why is this
>> happening.
>>    =20
>
> I was unclear. Driver does not change reset pin. Reset need to be
> done in board initialization code. You have to add something like tha=
t
>
> #define RST_PIN AT91_PIN_PC5
> at91_set_gpio_output(RST_PIN, 1);
> at91_set_gpio_value(RST_PIN,0);
> mdelay(2);
> at91_set_gpio_value(RST_PIN,1);
>
> in your arch/arm/mach-at91/board-NAME.c (I'm not sure if 2ms is
> correct IDE reset duration).
>
> Stanislaw
>
>  =20
I found out the reason of transients - it is caused by enabled pull-up
resistor on lower 16 bits on EBI0 - bit EBI0_DBPUC shoul be set to "1",
normally is set to "0". But the CF still no working, problem is is
elsewhere.

Radovan

I had mistake in schematic - after repair I get some new debug messages=
=20
- is possible to tell, what can be wrong? Thanks for advice

at91_ide_probe chipselect 4 irq 132 res 50000000
apply_timings t0=3D600 t1=3D70 t2=3D290 t6z=3D30
apply_timings mck_hz=3D99328000
apply_timings cycle=3D60 setup=3D7 pulse=3D29 data_float=3D3
Probing IDE interface ide0...
probing for hda: present=3D0, media=3D32, probetype=3DATA
probing for hda: present=3D0, media=3D32, probetype=3DATAPI
hda: probing with STATUS(0xa0) instead of ALTSTATUS(0x00)
hda: probing with STATUS(0xa0) instead of ALTSTATUS(0x1e)
probing for hdb: present=3D0, media=3D32, probetype=3DATA
probing for hdb: present=3D0, media=3D32, probetype=3DATAPI
hdb: probing with STATUS(0xa0) instead of ALTSTATUS(0x1e)
hdb: probing with STATUS(0xa0) instead of ALTSTATUS(0x1e)
ide0 at 0xc4866000-0xc4866007,0xc486e006 on irq 132

Radovan

