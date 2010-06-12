From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Fwd: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
	- "dead" harddisc until reboot
Date: Fri, 11 Jun 2010 19:38:47 -0600
Message-ID: <AANLkTikhGHS6CkWJvxIbTxLWl6xDrfuttowtGLdzu8Ht@mail.gmail.com>
References: <4C114285.8050201@gmx.net>
	<4C118A1B.3040206@gmail.com>
	<4C127A9F.5070005@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56058 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0FLBis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jun 2010 21:38:48 -0400
Received: by iwn9 with SMTP id 9so1012167iwn.19
        for <linux-ide@vger.kernel.org>; Fri, 11 Jun 2010 18:38:48 -0700 (PDT)
In-Reply-To: <4C127A9F.5070005@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MadLoisae@gmx.net
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, Jun 11, 2010 at 12:04 PM, MadLoisae@gmx.net <MadLoisae@gmx.net>=
 wrote:
> Hello Robert,
>
> at this time I have not tried other UDMA-modes - the controller is ud=
ma133
> able, the flashcard is udma66-able and the harddisc is (limited by th=
e 44pin
> cable) udma44-able. with legacy ATA I also use UDMA66 / UDMA44-modes.

If it's a 40-pin cable, the max is UDMA33, not UDMA44. What happens if
you force UDMA33 on both devices?

>
> but perhaps this logs are another step in the right direction: my las=
t
> libata-crash looked like this:
>
> ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> ata2.01: BMDMA stat 0x65
> ata2.01: failed command: READ DMA
> ata2.01: cmd c8/00:08:9f:03:41/00:00:00:00:00/f6 tag 0 dma 4096 in
> =A0 =A0 =A0 =A0res 00/00:08:9f:03:41/00:00:00:00:00/f6 Emask 0x2 (HSM=
 violation)

This one complained because the bits in the status register read from
the drive don't seem to make any sense (specifically none are set,
when DRDY should be).

> ata2: soft resetting link
> ata2.00: FORCE: xfer_mask set to udma4
> ata2.01: FORCE: xfer_mask set to udma3
> ata2.00: configured for UDMA/66
> ata2.01: configured for UDMA/44
> ata2.00: FORCE: xfer_mask set to udma4
> ata2.01: FORCE: xfer_mask set to udma3
> ata2.00: configured for UDMA/66
> ata2.01: configured for UDMA/44
> ata2: EH complete

Does it resume operation after this?

>
> until yet I have legacy-ata-logs found the look like the same - or at=
 least
> crap:
>
> hdd: ide_dma_sff_timer_expiry: DMA status (0x61)
> hdd: dma_intr: status=3D0x7f { DriveReady DeviceFault SeekComplete Da=
taRequest
> CorrectedError Index Error }
> hdd: dma_intr: error=3D0x7f { DriveStatusError UncorrectableError
> SectorIdNotFound TrackZeroNotFound AddrMarkNotFound },
> LBAsect=3D8830587504648, sector=3D209806663
> hdd: possibly failed opcode: 0x25
> hdc: DMA disabled
> hdd: DMA disabled
> ide1: reset: success
>
> the logged LBAsect and also the logged sector are not existent on thi=
s drive
> - but they are neither a harddisc-failure not a filesystem-failure - =
this
> must be an ugly bug in this chipset or maybe just a communication-pro=
blem
> between controller and harddisc. I have already changed cabeling, har=
ddisc
> (three times in the meanwhile! On my actual drive I did already with =
dd a
> complete write - there were neither logged from kernel bad sectors no=
r smart
> does show any pending sectors or reallocated sectors - the harddisc h=
as no
> problem), compact flash (also three times, already another manufactur=
er -
> the flash is currently two month old, I will not belive that it is da=
maged,
> altough i did only read-only tests), memory (altough I've tested it s=
everal
> times with memtest) - if there is a hardware-failure it can only be t=
he
> IDE-controller which I cannot check.
>
> my idea: libata is not able to handle this issue in a way legacy-ide-=
driver
> did - as logged the channel got reset, both drives are from now on in
> PIO-mode, but i can manually set them to DMA again and it works "as g=
ood" as
> before. with libata I am sure this were another reset-reason. Libata =
seems
> to force always UDMA-mode after the reset - is there a possibility to
> workaround?
>
> genereally the DMA-behaviour is from legacy-IDE much better in my opi=
nion:
> it's possible to set with hdparm in userspace the DMA-mode. libata de=
s not
> offer such a possibility, does it? So I have no possibility to contro=
l or
> change the behaviour after boot, I have to hope that the fallback-mec=
hanism
> is good enough...

libata doesn't currently offer a mechanism to control the DMA setting
from userspace, no.

It does seem like you're having some rather major communication
problems on the bus - the error below seems to indicate that the DMA
transfer stalled:

>
> also I saw "harmless" IDE-communication-problems:
>
> hdd: ide_dma_sff_timer_expiry: DMA status (0x61)
> hdd: DMA timeout error
> hdd: dma timeout error: status=3D0x80 { Busy }
> hdd: possibly failed opcode: 0x25
> hdc: DMA disabled
> hdd: DMA disabled
> ide1: reset: success
>
> also after this reset I just enabled DMA, the machine is still runnin=
g, no
> reset necessary. What would libata do?
>
> any ideas? i am really desperate in the meanwhile. :'-(
>
> thanks!
> Alois
>
> Robert Hancock wrote:
>>
>> On 06/10/2010 01:52 PM, MadLoisae@gmx.net wrote:
>>>
>>> Hi there,
>>>
>>> actually I am using kernel 2.6.34, up to now I was in every (stable=
)
>>> release since 2.6.30 affected by this issue.
>>> Today I have reactivated legacy, regrettably deprecated parallel AT=
A
>>> support and have disabled libata. Its a shame, libata is much faste=
r
>>> (about 20% faster I/O measureable) and more forward-looking, but it=
 is
>>> not a real alternative if it crashes continuous but not reproduceab=
le on
>>> via-chipsets (google for this, the web is filled of this issue!). I
>>> know, via chipsets are not very good, but shouldn't we try to make =
it
>>> better (or at least best as possible) with newer drivers instead of
>>> worse?
>>> I hope legacy ATA support won't be removed soon from the kernel sou=
rces
>>> ...
>>>
>>> I like trying out a lot, but if the response is so thin it does not=
 make
>>> fun just looking at the same issue with the same messages again and
>>> again not able to do anything beside looking at it and resetting th=
e box
>>> afterwards ...
>>
>> Have you tried limiting the speed to UDMA2? If that helps then it co=
uld be
>> that the motherboard circuitry, etc. isn't suitable for faster speed=
s.
>>
>> Random timeouts are unfortunately quite hard to debug since there's =
so
>> many problems that can cause them but the symptoms are the same: cou=
ld be
>> that there was an error on the bus that caused something to stall, a=
n
>> interrupt got lost somehow, etc. Or maybe the timing of device acces=
s is
>> somehow different and thus more likely to trigger whatever the cause=
 is.
>> There also seem to be a fair number of bugs in these IDE chipsets th=
at the
>> driver has to work around, could be there is one missing in the liba=
ta
>> version..
>>
>
>
