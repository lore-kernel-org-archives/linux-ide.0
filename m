From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Wed, 21 Jan 2009 11:33:04 +0100
Message-ID: <200901211133.05095.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <4975B065.6030705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:39500 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753662AbZAUKda convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jan 2009 05:33:30 -0500
In-Reply-To: <4975B065.6030705@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Tuesday 20 January 2009 12:07:17 Sergei Shtylyov napisa=C5=82(a):
>    Besides, we have ide_timing_compute() doing the same thing.
I'm trying use it, but have too bigger results - 1 or 2 cycles is added=
=2E
I'm doing something wrong.

        T =3D 1000000000 / (mck_hz / 1000);
        pdbg("pio %u T %u\n", pio, T);
        ret =3D ide_timing_compute(drive, pio + XFER_PIO_0, &timing, T,=
 1);

        t0 =3D timing->cyc8b;
        t1 =3D timing->setup;
        t2 =3D timing->act8b;
        t2i =3D timing->recover;
        t9 =3D 0;
        pdbg("1: t0=3D%02u t1=3D%02u t2=3D%02u t2i=3D%02u t9=3D%02u\n",=
 t0, t1, t2, t2i, t9);

Clock is approx 100MHz , results should be the same as in standard=20
divided by 10.

hda: host max PIO5 wanted PIO0 selected PIO0
at91_ide_set_pio_mode pio 0 T 10004
set_ebi_timings 1: t0=3D60 t1=3D07 t2=3D32 t2i=3D29 t9=3D00
set_ebi_timings 2: t0=3D60 t1=3D07 t2=3D29 t2i=3D00 t9=3D02

hda: host max PIO5 wanted PIO1 selected PIO1
at91_ide_set_pio_mode pio 1 T 10004
set_ebi_timings 1: t0=3D39 t1=3D05 t2=3D29 t2i=3D18 t9=3D00
set_ebi_timings 2: t0=3D39 t1=3D05 t2=3D29 t2i=3D00 t9=3D02

hda: host max PIO5 wanted PIO2 selected PIO2
at91_ide_set_pio_mode pio 2 T 10004
set_ebi_timings 1: t0=3D33 t1=3D03 t2=3D29 t2i=3D12 t9=3D00
set_ebi_timings 2: t0=3D24 t1=3D03 t2=3D29 t2i=3D00 t9=3D01

hda: host max PIO5 wanted PIO3 selected PIO3
at91_ide_set_pio_mode pio 3 T 10004
set_ebi_timings 1: t0=3D18 t1=3D03 t2=3D09 t2i=3D09 t9=3D00
set_ebi_timings 2: t0=3D18 t1=3D03 t2=3D08 t2i=3D07 t9=3D04

hda: host max PIO5 wanted PIO4 selected PIO4
at91_ide_set_pio_mode pio 4 T 10004
set_ebi_timings 1: t0=3D12 t1=3D03 t2=3D08 t2i=3D04 t9=3D00
set_ebi_timings 2: t0=3D12 t1=3D03 t2=3D07 t2i=3D03 t9=3D01

hda: host max PIO5 wanted PIO5 selected PIO5
at91_ide_set_pio_mode pio 5 T 10004
set_ebi_timings 1: t0=3D12 t1=3D02 t2=3D07 t2i=3D05 t9=3D00
set_ebi_timings 2: t0=3D10 t1=3D02 t2=3D07 t2i=3D03 t9=3D01
=20
Cheers
Stanislaw Gruszka
