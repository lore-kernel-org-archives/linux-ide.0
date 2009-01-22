From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 12:44:10 +0300
Message-ID: <49783FEA.3010302@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <4975B065.6030705@ru.mvista.com> <200901211133.05095.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:18811 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752817AbZAVJoR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 04:44:17 -0500
In-Reply-To: <200901211133.05095.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Hello.

Stanislaw Gruszka wrote:

>>    Besides, we have ide_timing_compute() doing the same thing.
>>     
> I'm trying use it, but have too bigger results - 1 or 2 cycles is added.
>   

   That's most probably because ide_timing_compute() assumes non-zero 
minimum recovery time for PIO modes 0 to 2 (libata does the same) -- 
that actually smells of over-caution. It then tries to stretch the 
active time if the sum of active and recovery times is less than cycle 
time (all quantized already).

> I'm doing something wrong.
>   

   Well, you don't compute t2i. And you use recover field returend by 
ide_timing_compute() instead of rev8b.

>         T = 1000000000 / (mck_hz / 1000);
>         pdbg("pio %u T %u\n", pio, T);
>         ret = ide_timing_compute(drive, pio + XFER_PIO_0, &timing, T, 1);
>
>         t0 = timing->cyc8b;
>         t1 = timing->setup;
>         t2 = timing->act8b;
>         t2i = timing->recover;
>   

   No, you should use rec8b.

>         t9 = 0;
>         pdbg("1: t0=%02u t1=%02u t2=%02u t2i=%02u t9=%02u\n", t0, t1, t2, t2i, t9);
>
> Clock is approx 100MHz , results should be the same as in standard 
> divided by 10.
>
> hda: host max PIO5 wanted PIO0 selected PIO0
> at91_ide_set_pio_mode pio 0 T 10004
> set_ebi_timings 1: t0=60 t1=07 t2=32 t2i=29 t9=00
> set_ebi_timings 2: t0=60 t1=07 t2=29 t2i=00 t9=02
>   

   Yeah, with the PIO0 active time 290 ns + revovery time 240 ns giving 
530 ns, the function should stretch the active time.

> hda: host max PIO5 wanted PIO1 selected PIO1
> at91_ide_set_pio_mode pio 1 T 10004
> set_ebi_timings 1: t0=39 t1=05 t2=29 t2i=18 t9=00
> set_ebi_timings 2: t0=39 t1=05 t2=29 t2i=00 t9=02
>   

   Here 290 + 100 gives 390, so no stretching occurs.

> hda: host max PIO5 wanted PIO2 selected PIO2
> at91_ide_set_pio_mode pio 2 T 10004
> set_ebi_timings 1: t0=33 t1=03 t2=29 t2i=12 t9=00
> set_ebi_timings 2: t0=24 t1=03 t2=29 t2i=00 t9=01
>   

   Here 290 + 40 gives 330, so no stretching occurs.

> hda: host max PIO5 wanted PIO3 selected PIO3
> at91_ide_set_pio_mode pio 3 T 10004
> set_ebi_timings 1: t0=18 t1=03 t2=09 t2i=09 t9=00
> set_ebi_timings 2: t0=18 t1=03 t2=08 t2i=07 t9=04
>   

   Here 80 + 70 gives 150, so the active time is stretched.

> hda: host max PIO5 wanted PIO4 selected PIO4
> at91_ide_set_pio_mode pio 4 T 10004
> set_ebi_timings 1: t0=12 t1=03 t2=08 t2i=04 t9=00
> set_ebi_timings 2: t0=12 t1=03 t2=07 t2i=03 t9=01
>   

   Here 70 + 30 gives 100, so the active time is stretched.

> hda: host max PIO5 wanted PIO5 selected PIO5
> at91_ide_set_pio_mode pio 5 T 10004
> set_ebi_timings 1: t0=12 t1=02 t2=07 t2i=05 t9=00
> set_ebi_timings 2: t0=10 t1=02 t2=07 t2i=03 t9=01
>   

   Here 50 + 30 gives 80 (the IDE core doesn't know about CF extended 
modes, so uses non-standard PIO5 timings), so the active time is 
stretched again.

> Cheers
> Stanislaw Gruszka
>   

MBR, Sergei


