From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Timing computation, values missing from table (in spec though)
Date: Fri, 10 Feb 2012 14:40:54 -0600
Message-ID: <CAKGA1bm2e-tLU9GbcvHZuW+ALwGXsNHof8fzZgeF4H9a4p7TVw@mail.gmail.com>
References: <CAKGA1bmiocDOg0Li8bA+v8MUuze1Z6yOfWx2kTh76OdJwDVg4A@mail.gmail.com>
 <4F354715.5020909@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod7og126.obsmtp.com ([64.18.2.206]:52150 "EHLO
	exprod7og126.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759090Ab2BJUlP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2012 15:41:15 -0500
Received: by mail-tul01m020-f182.google.com with SMTP id wo16so5736319obc.13
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2012 12:41:14 -0800 (PST)
In-Reply-To: <4F354715.5020909@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Feb 10, 2012 at 10:34 AM, Sergei Shtylyov <sshtylyov@mvista.com=
> wrote:
> Hello.
>
>
> On 02/09/2012 11:19 PM, Matt Sealey wrote:
>
>> We need to actually set the specific time in ATA clocks in those
>> registers, and there is a register for every timing reference in the
>> ATA spec tables and diagrams.. specifically t4 and t9 are missing fo=
r
>
> =C2=A0 I have controller with t9 programmable too (and t2i NOT progra=
mmable at
> the same time), so I had to use custom formula to calculate it, in or=
der to
> stretch the t2i to meet t0 timing. :-)

Okay.. good to know someone else looked at it.

>> PIO (and tA would be derived for iordy by the current code, right? B=
ut
>> we also need to set tRD which seems not to be)
>
> =C2=A0 tRD has minimum value of 0 for all modes, hence I see no sense=
 adding it
> to the ata_timing[]. The same about tA which is always 35 ns min (or =
max?).
> And wait, is tRD aven controllable by host?!

Sure. It's the time between negating iordy and sampling data (t5) and d=
epending
on perhaps some freaky cabling, buffers on the PCB between controller a=
nd
cable and drive or just lazy manual tracing out of the ATA bus lines
from the SoC
(figuring exact trace lengths on a bus meant for a bendy cable seems li=
ke an
egregious waste of time) it needs to be set just in case there IS some
inordinate
amount of time for the data to settle.

0xBASE+0x00F   TIME_PIO_RDX     "PIO timing parameter. Controls trd"

The formula in the manual is (and trd1 is the ATA controller, trd is
the ATA we meet it by setting time_pio_rdx);

trd1(max) =3D (=E2=80=93trd) + (tskew3 + tskew4)
trd1(min) =3D (time_pio_rdx - 0.5) =C3=97 T =E2=80=93 (tsu + thi)
(time_pio_rdx - 0.5) =C3=97 T > tsu + thi + tskew3 + tskew4

tskew3 is the maximum propagation delay for iordy and data lines, and
tskew4 is the
maximum difference in propagation delay between iody and the data..
the math makes
sense and I can see why they would implement their controller this way
from a logic
design point of view.

Makes the software a pain though. The current BSP driver hardcodes it
to 1 clock (to account for
skew I assume which doesn't really exist on a system where the ATA
controller is connected
to an ATA device about an inch away on the PCB compared to a foot of
bendy cable). In the event
we need to use a bendy cable I guess this would need fixing.. my
current plan is to hardcode
it but I would definitely like it to be in the table for completeness
(because then the code is
TIME_PIO_RDX =3D tRDmin + skew and not TIME_PIO_RDX =3D skew)

>> and for DMA, several others (tM for MWDMA)
>
> =C2=A0 I also needed this timing in my yet unpublished driver but dec=
ided not to
> clutter ata_timing[] -- unlike we did with tJ ('dmack_hold') used by =
only
> one driver and moreover, simply computable from the driver mode.

Well if pata_imx gets UDMA support it needs to set TIME_JN to control
tJ and tN (theory being that it's the time between DIORW and DMACK
where the chipselect changes, to allow the bus to wait to sample DMACK
with when the correct chipselect is in place and not before or it might=
 be
sampling dmack driven from the wrong device?)... so that's a second use=
r..
oddly the BSP driver puts tN, tJ and tJNH in the table (which is just t=
N+tJ
in every instance) and uses tJNH. Wasting about 10 bytes there..

This is why I don't want to use their data, it's kind of.. overzealous =
in a way.

>> and I am really confused where the values for
>> UDMA are meant to be derived for the controller since none of them a=
re
>> listed in the comments for struct ata_timing.
>
> =C2=A0 Common x86 controllers only need one timing, hence the table o=
nly has
> t2CYCTYP/2.

Okay..

>> Is it a good or bad idea to expand the table to include the extra
>> timings, or should we just include a custom table of timings and
>> manage the situation ourselves? Part of my reason for wanting to use
>> the libata core timings is because of all the safety checks which I
>> don't get with a custom blob of numbers pulled from some older sourc=
e
>> code that I have no idea how they were derived..
>
> =C2=A0 Well, that depends on the demand on the new timings -- if more=
 than one
> driver needs them, we should add them to the table. Although with mor=
e UDMA
> timings added, the table is going to become quite ugly (perhaps we sh=
ould
> add a new table for just UDMA timings instead of mechanically extendi=
ng
> ata_timing[]?). I myself decided not to add anything to ata_timing[] =
as my
> driver seemed one-off example of needing so many timings...

Well, I think then the solution is I put the timings in the driver,
and when it gets pushed
out, and when your driver gets pushed out, that's two in-kernel users
that need more
than the current solution and as such we can think about it later.

Thanks :)

--=20
Matt
