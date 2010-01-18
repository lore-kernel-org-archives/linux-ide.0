From: Torsten Kaiser <just.for.lkml@googlemail.com>
Subject: Re: MSI broken in libata?
Date: Mon, 18 Jan 2010 21:51:33 +0100
Message-ID: <64bb37e1001181251y733513cdm1be9850af880ee73@mail.gmail.com>
References: <64bb37e0912250122n4e0e1842q88c0dad7e99ec6a7@mail.gmail.com>
	 <4B484829.6060405@kernel.org>
	 <64bb37e1001092033r1f0b4defw46c1a07101bb2d1b@mail.gmail.com>
	 <4B4A7BC7.6060106@kernel.org> <4B4A815A.60503@gmail.com>
	 <64bb37e1001161358r79ea2da0u88e9894fa5987ef1@mail.gmail.com>
	 <4B536383.7090609@gmail.com>
	 <64bb37e1001171311u21c58fbj9a13b6aaeb7b2c3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754301Ab0ARUvj@vger.kernel.org>
In-Reply-To: <64bb37e1001171311u21c58fbj9a13b6aaeb7b2c3f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Jan 17, 2010 at 10:11 PM, Torsten Kaiser
<just.for.lkml@googlemail.com> wrote:
> What was different between -rc4 and my earlier tests was, that there
> where additional error messages from do_IRQ.

> [ =A0112.382903] do_IRQ: 0.165 No irq handler for vector (irq -1)
> [ =A0112.382923] do_IRQ: 3.165 No irq handler for vector (irq -1)
> [ =A0112.382939] do_IRQ: 1.165 No irq handler for vector (irq -1)
> [ =A0112.382957] do_IRQ: 2.165 No irq handler for vector (irq -1)
> [ =A0143.010051] ata2.00: exception Emask 0x0 SAct 0x3 SErr 0x0 actio=
n 0x6 frozen
> [ =A0143.010060] ata2.00: failed command: READ FPDMA QUEUED
> [ =A0143.010071] ata2.00: cmd 60/00:00:ad:71:d9/01:00:01:00:00/40 tag=
 0
> ncq 131072 in
> [ =A0143.010073] =A0 =A0 =A0 =A0 =A0res 40/00:00:01:4f:c2/00:00:00:00=
:00/00 Emask
> 0x4 (timeout)
> [ =A0143.010079] ata2.00: status: { DRDY }
> [ =A0143.010083] ata2.00: failed command: READ FPDMA QUEUED
> [ =A0143.010092] ata2.00: cmd 60/00:08:ad:70:d9/01:00:01:00:00/40 tag=
 1
> ncq 131072 in
> [ =A0143.010095] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00=
:00/00 Emask
> 0x4 (timeout)
> [ =A0143.010099] ata2.00: status: { DRDY }
> [ =A0143.010108] ata2: hard resetting link

> I will look, if I can find out, where the do_IRQ error comes from and
> why I didn't see it with -rc1 to -rc3.

OK, this has nothing to do with -rc3 vs. -rc4.
If I kill the drive with reading a 1GB file with dd, I get the above
errors, include the one from do_IRQ.
If I kill the drive with writing a 1GB file with dd, I do not get the
do_IRQ error.
As I tested the earlier -rcs only with writes, I didn't see it there.
(Its not even in the old logs that contain the libata errors)

Should I try to put some printks in arch/x86/kernel/apic/io_apic.c
__assign_irq_vector() or is there a better way to look at the irq
vectors?

Torsten
