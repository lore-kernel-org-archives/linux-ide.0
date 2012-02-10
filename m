From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: Timing computation, values missing from table (in spec though)
Date: Fri, 10 Feb 2012 19:34:29 +0300
Message-ID: <4F354715.5020909@mvista.com>
References: <CAKGA1bmiocDOg0Li8bA+v8MUuze1Z6yOfWx2kTh76OdJwDVg4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58089 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2BJPfI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2012 10:35:08 -0500
Received: by bkcjm19 with SMTP id jm19so2912733bkc.19
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2012 07:35:06 -0800 (PST)
In-Reply-To: <CAKGA1bmiocDOg0Li8bA+v8MUuze1Z6yOfWx2kTh76OdJwDVg4A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello.

On 02/09/2012 11:19 PM, Matt Sealey wrote:

> A question so I can see if I can use ata_timing_compute or possibly improve it..

> The current mode timings list seems to be missing a few timings we
> need that cannot possibly (and don't seem to be attempted) to be
> resolved from the ata_timings table in libata-core.c.

> We have a bank of registers in our ATA controller where these values
> need setting; is it that the timings table is missing the values (and
> the same true of the one in ide-timings.c) no
> other drive controller actually needed such fine timings and would
> implement them as per the spec minimums by itself?

    Yes.

> We need to actually set the specific time in ATA clocks in those
> registers, and there is a register for every timing reference in the
> ATA spec tables and diagrams.. specifically t4 and t9 are missing for

    I have controller with t9 programmable too (and t2i NOT programmable at the 
same time), so I had to use custom formula to calculate it, in order to stretch 
the t2i to meet t0 timing. :-)

> PIO (and tA would be derived for iordy by the current code, right? But
> we also need to set tRD which seems not to be)

    tRD has minimum value of 0 for all modes, hence I see no sense adding it to 
the ata_timing[]. The same about tA which is always 35 ns min (or max?). And 
wait, is tRD aven controllable by host?!

> and for DMA, several others (tM for MWDMA)

    I also needed this timing in my yet unpublished driver but decided not to 
clutter ata_timing[] -- unlike we did with tJ ('dmack_hold') used by only one 
driver and moreover, simply computable from the driver mode.

> and I am really confused where the values for
> UDMA are meant to be derived for the controller since none of them are
> listed in the comments for struct ata_timing.

    Common x86 controllers only need one timing, hence the table only has 
t2CYCTYP/2.

> Is it a good or bad idea to expand the table to include the extra
> timings, or should we just include a custom table of timings and
> manage the situation ourselves? Part of my reason for wanting to use
> the libata core timings is because of all the safety checks which I
> don't get with a custom blob of numbers pulled from some older source
> code that I have no idea how they were derived..

    Well, that depends on the demand on the new timings -- if more than one 
driver needs them, we should add them to the table. Although with more UDMA 
timings added, the table is going to become quite ugly (perhaps we should add a 
new table for just UDMA timings instead of mechanically extending 
ata_timing[]?). I myself decided not to add anything to ata_timing[] as my 
driver seemed one-off example of needing so many timings...

MBR, Sergei
