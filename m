From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: Bad CD disk disables IDE DMA
Date: Sun, 19 Aug 2007 10:33:49 +0200
Message-ID: <46C8006D.7060406@dunaweb.hu>
References: <8Squ5-2cU-19@gated-at.bofh.it> <8SIKl-5IK-13@gated-at.bofh.it> <E1ILeCg-0000iH-2W@be1.lrz> <46C4457D.5030703@dunaweb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linux.dunaweb.hu ([62.77.196.1]:51102 "EHLO linux.dunaweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbXHSId5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Aug 2007 04:33:57 -0400
In-Reply-To: <46C4457D.5030703@dunaweb.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7eggert@gmx.de
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Zoltan Boszormenyi =EDrta:
> Bodo Eggert =EDrta:
>> Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>> =20
>>> On 15/08/07, Zoltan Boszormenyi <zboszor@dunaweb.hu> wrote:
>>>    =20
>>
>> =20
>>>> I noticed that a bad CD of mine makes DMA disabled:
>>>>      =20
>>
>> [...]
>> =20
>>>> hda: cdrom_decode_status: error=3D0x40 { LastFailedSense=3D0x04 }
>>>> ide: failed opcode was: unknown
>>>> hda: DMA disabled
>>>> hda: ide_intr: huh? expected NULL handler on exit
>>>> hda: ATAPI reset complete
>>>>
>>>> Every time I put the said CD into to drive and DMA is on, I get th=
e
>>>> above messages.
>>>>      =20
>>> This might be intended.
>>>    =20
>>
>> Maybe, and maybe only a certain effect might be intended. And maybe =
I=20
>> can
>> help by asking these questions:
>>
>> 1) Does disabling DMA fix the seek errors, or does it hide them by=20
>> the PIO
>>    interfce not printing them?
>>  =20
>
> With DMA off no seek error occurs. When the transfer rate is
> limited to UDMA3 I get this:
>
> hda: drive_cmd: status=3D0x51 { DriveReady SeekComplete Error }
> hda: drive_cmd: error=3D0x04 { AbortedCommand }
> ide: failed opcode was: 0xec
>
> Note the difference: the error code is different and
> it knows the failed opcode as well. But DMA remains on.
> Can it be a bad 80w cable? I don't think so, considering that
> it doesn't occur for DVDs when using UDMA4...
>
>> 2) If it does hide them, would filtering for seek errors be a sane=20
>> thing to
>>    do, or does the DMA engine (or HDD) behave badly on these errors,=
 or
>>    do bad-DMA devices report seek errors, too?
>>
>> 3) If it does not hide them, would re-enabling DMA on disk change be=
 a
>>    feasable workaround?
>>    (proposed interface: use hdparm -d $num where $num =3D
>>      0, 1: as before
>>      3: DMA on, if switched off automatically, will be set to 2
>>      2: DMA off, will be turned on (set to 3) on disk change)
>>  =20
>
> The automatic DMA re-enabling would be a good solution.
>
>> 4) Does libata work well enough for making all effort put into that =
old
>>    IDE layer be a waste of time?
>>  =20
>
> Unfortunately libata (or pata_amd) doesn't work very well on this=20
> machine,
> I tried to switch to libata for the CD drive but it lost the=20
> DVD-playing capability.
> It seems the error was that libdvdcss couldn't get the keys via the=20
> scd device.
> This is the main obstacle that stops me switching to Fedora 7 from FC=
6.
> I reported it some time ago but got no answer. Look for subject
> "DVD-playing, ide-cd vs scsi-cd drivers".

=46orget about this last comment. I just installed F7 on a similar mach=
ine,
motherboard is ABit KN9S instead of KN9SLI (mine), both have the same
MCP55 IDE rev a1 and MCP55 SATA rev a2. This new machine
plays DVDs nicely, so the difference is in the userspace. Although
both my FC6 and F7 has the same libdvdcss-1.2.9-4.lvn6. Its src.rpm
doesn't have any patches, just the mainstream libdvdcss sources.
Now explain that. :-)

> Best regards,
> Zolt=E1n B=F6sz=F6rm=E9nyi


