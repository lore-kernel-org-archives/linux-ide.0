From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: Bad CD disk disables IDE DMA
Date: Thu, 16 Aug 2007 14:14:40 +0200
Message-ID: <46C43FB0.2020404@dunaweb.hu>
References: <46C2F526.30005@dunaweb.hu> <6bffcb0e0708160117m31b6edc6ta277b6ddf2d894f6@mail.gmail.com> <46C42DD6.5090200@dunaweb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linux.dunaweb.hu ([62.77.196.1]:37715 "EHLO linux.dunaweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbXHPMPE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 08:15:04 -0400
In-Reply-To: <46C42DD6.5090200@dunaweb.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>

Zoltan Boszormenyi =EDrta:
> Michal Piotrowski =EDrta:
>> Hi Zoltan,
>>
>> On 15/08/07, Zoltan Boszormenyi <zboszor@dunaweb.hu> wrote:
>> =20
>>> Hi,
>>>
>>> I noticed that a bad CD of mine makes DMA disabled:
>>>
>>> hda: selected mode 0x44
>>> hda: cdrom_decode_status: status=3D0x51 { DriveReady SeekComplete E=
rror }
>>> hda: cdrom_decode_status: error=3D0x40 { LastFailedSense=3D0x04 }
>>> ide: failed opcode was: unknown
>>> hda: cdrom_decode_status: status=3D0x51 { DriveReady SeekComplete E=
rror }
>>> hda: cdrom_decode_status: error=3D0x40 { LastFailedSense=3D0x04 }
>>> ide: failed opcode was: unknown
>>> hda: cdrom_decode_status: status=3D0x51 { DriveReady SeekComplete E=
rror }
>>> hda: cdrom_decode_status: error=3D0x40 { LastFailedSense=3D0x04 }
>>> ide: failed opcode was: unknown
>>> hda: cdrom_decode_status: status=3D0x51 { DriveReady SeekComplete E=
rror }
>>> hda: cdrom_decode_status: error=3D0x40 { LastFailedSense=3D0x04 }
>>> ide: failed opcode was: unknown
>>> hda: DMA disabled
>>> hda: ide_intr: huh? expected NULL handler on exit
>>> hda: ATAPI reset complete
>>>
>>> Every time I put the said CD into to drive and DMA is on, I get the
>>> above messages.
>>>    =20
>>
>> This might be intended.
>>  =20
>
> Might be. Note however, that there are no "cdrom_decode_status: " lin=
es
> when the drive is not using DMA. The disk is the same in both cases.
> I don't know too much about ATAPI, but shouldn't it report the same
> errors no matter how the commands are passed to the drive?
> I tried to make it using DMA after mounting the "faulty" disk and=20
> copying it.
> The same errors occured in the logs when dd started reading but it=20
> actually
> finished reading:
>
> $ LANG=3DC dd if=3D/dev/hda of=3Dimage.iso bs=3D2048
> dd: reading `/dev/hda': Input/output error
> 298106+0 records in
> 298106+0 records out
> 610521088 bytes (611 MB) copied, 144.349 seconds, 4.2 MB/s
>
> The file is a bit larger than what isosize reports about it but IIRC=20
> it's expected.
> So, if the disk is actually faulty dd would drop dead and not able to=
=20
> read the disk.
> Or something is not quite right in the ide-cd driver. The "DMA=20
> disabled" message
> comes when the drive should spin up the disk. Isn't there a timeout=20
> error somewhere?
> Hm. Thinking about it a bit more upon mount the same is happening -=20
> before
> the disk is spun up the error shows up in the logs and it switches to=
=20
> PIO.
> Does it ring a bell to someone?

Another data point: the other disks I tried up to now were DVDs
and DMA remains turned on for those. It's even true for empty
DVDs and the label side of a Labelflash disk. On the other hand,
another CD and two other CDRW disks (no visible faults, scratches
on either btw) give me the same error when they are mounted,
DMA gets disabled.

=2E.. some more tests and researching ...

TADA! The solution was to tune down the drive to only use UDMA3
with "hdparm -X67". Now although dd didn't get any faster, DMA
remained enabled. Actually the drive is originally a Pioneer 111D
that was reflashed to 111L to get the Labelflash feature.
Can it be a firmware bug? BTW the drive has a 80w cable.

>>> Two things are interesting: first, it gets mounted correctly and
>>> readable and
>>> second, when DMA was already disabled no such messages occur in the=
=20
>>> logs.
>>> Anyhow, I would need DMA to correctly burn CDs/DVDs...
>>> What can I do besides manually re-enable DMA?
>>> All other disks I have tried behave perfectly.
>>> This happened on 2.6.22[-rcX], 2.6.23-rc3-git1 and 2.6.20-1.2962.fc=
6.
>>> This is on a Fedora Core 6 system. CD/DVD is using the old IDE driv=
ers:
>>>
>>> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>>> ide: Assuming 33MHz system bus speed for PIO modes; override with=20
>>> idebus=3Dxx
>>> NFORCE-MCP55: IDE controller at PCI slot 0000:00:04.0
>>> NFORCE-MCP55: chipset revision 161
>>> NFORCE-MCP55: not 100% native mode: will probe irqs later
>>> NFORCE-MCP55: BIOS didn't set cable bits correctly. Enabling=20
>>> workaround.
>>> NFORCE-MCP55: 0000:00:04.0 (rev a1) UDMA133 controller
>>>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>>> Probing IDE interface ide0...
>>> hda: PIONEER DVD-RW DVR-111L, ATAPI CD/DVD-ROM drive
>>> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>>> Probing IDE interface ide1...
>>> ide-floppy driver 0.99.newide
>>>
>>> $ cat /proc/ide/amd74xx
>>> ----------AMD BusMastering IDE Configuration----------------
>>> Driver Version:                     2.13
>>> South Bridge:                       0000:00:04.0
>>> Revision:                           IDE 0xa1
>>> Highest DMA rate:                   UDMA133
>>> BM-DMA base:                        0xf000
>>> PCI clock:                          33.3MHz
>>> -----------------------Primary IDE-------Secondary IDE------
>>> Prefetch Buffer:              yes                 yes
>>> Post Write Buffer:            yes                 yes
>>> Enabled:                      yes                  no
>>> Simplex only:                  no                 yes
>>> Cable Type:                   80w                 80w
>>> -------------------drive0----drive1----drive2----drive3-----
>>> Transfer Mode:        PIO       DMA       DMA       DMA
>>> Address Setup:       30ns      90ns      90ns      90ns
>>> Cmd Active:          90ns      90ns     300ns     300ns
>>> Cmd Recovery:        30ns      30ns     300ns     300ns
>>> Data Active:         90ns     330ns     330ns     330ns
>>> Data Recovery:       30ns     270ns     270ns     270ns
>>> Cycle Time:         120ns     600ns     600ns     600ns
>>> Transfer Rate:   16.6MB/s   3.3MB/s   3.3MB/s   3.3MB/s
>>>
>>> Best regards,
>>> Zolt=E1n B=F6sz=F6rm=E9nyi
>>>    =20
>>
>> Regards,
>> Michal
>>
>>  =20
>
> Best regards,
> Zolt=E1n
>
>
>


