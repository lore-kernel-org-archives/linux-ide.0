From: Mike Hokenson <logan@gozer.org>
Subject: Re: Fwd: Long delay when booting with SATA DVD on Marvell 88SE6121
Date: Thu, 3 Sep 2009 17:25:02 -0500
Message-ID: <5ffd7e260909031525r134b1ef0q689d31bee8173b3a@mail.gmail.com>
References: <20090817002918.GA2805@gozer.dminteractive.com>
	 <4A9BD7DF.8030606@kernel.org>
	 <5ffd7e260908311856j1fd42765rbdc5245bf4e7bd71@mail.gmail.com>
	 <5ffd7e260908311900u3a4a02b9kd36156cfdce902c0@mail.gmail.com>
	 <4A9FC81B.7020702@kernel.org> <4AA02F95.4050508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:38929 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbZICWZC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Sep 2009 18:25:02 -0400
Received: by fxm17 with SMTP id 17so301885fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 03 Sep 2009 15:25:03 -0700 (PDT)
In-Reply-To: <4AA02F95.4050508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Thu, Sep 3, 2009 at 4:05 PM, Mark Lord<liml@rtr.ca> wrote:
> Tejun Heo wrote:
>>
>> Hello,
>>
>> Mike Hokenson wrote:
>>>
>>> (sorry, resent to linux-ide without the html)
>>>
>>> On Mon, Aug 31, 2009 at 9:02 AM, Tejun Heo <tj@kernel.org> wrote:
>>>>>
>>>>> [ =A0 =A06.312129] ata2.00: qc timeout (cmd 0xa1)
>>>>> [ =A0 =A06.312135] ata2.00: failed to IDENTIFY (I/O error, err_ma=
sk=3D0x4)
>>>>> [ =A0 11.352006] ata2: link is slow to respond, please be patient
>>>>> (ready=3D0)
>>>>> [ =A0 16.336009] ata2: device not ready (errno=3D-16), forcing ha=
rdreset
>>>>> [ =A0 21.532007] ata2: link is slow to respond, please be patient
>>>>> (ready=3D0)
>>>>> [ =A0 26.348009] ata2: SRST failed (errno=3D-16)
>>>>> [ =A0 31.544008] ata2: link is slow to respond, please be patient
>>>>> (ready=3D0)
>>>>> [ =A0 36.360014] ata2: SRST failed (errno=3D-16)
>>>>> [ =A0 36.544307] ata2.00: ATAPI: ASUS =A0 =A0DRW-2014L1T, 1.02, m=
ax UDMA/66
>>>>> [ =A0 36.560317] ata2.00: configured for UDMA/66
>>>>> [ =A0 36.576547] scsi 1:0:0:0: CD-ROM =A0 =A0 =A0 =A0 =A0 =A0ASUS=
 =A0 =A0 DRW-2014L1T
>>>>> 1.02 PQ: 0 ANSI: 5
>>>>
>>>> "libata.force=3D2:udma33" would force it to udma/33 but I don't th=
ink
>>>> that would be the problem here. =A0IDENTIFY doesn't use udma anywa=
y.
>>>> Does the problem go away if you do "libata.force=3D2:pio0"?
>>>
>>> Thanks for the suggestion, but it didn't help. libata is setup as a
>>> module in Debian's kernel, so I created a /etc/modprobe.d/libata.co=
nf
>>> with "options libata force=3D2:pio0" and rebuilt initrd. This appea=
rs to
>>> have properly registered the force flag, but it seems to have only
>>> been applied once the kernel worked through the issue with the
>>> controller/port:
>>>
>>> [ =A0 =A03.985969] usbhid: v2.6:USB HID core driver
>>> [ =A0 =A06.316130] ata2.00: qc timeout (cmd 0xa1)
>>> [ =A0 =A06.316135] ata2.00: failed to IDENTIFY (I/O error, err_mask=
=3D0x4)
>>> [ =A0 11.356004] ata2: link is slow to respond, please be patient (=
ready=3D0)
>>> [ =A0 16.340004] ata2: device not ready (errno=3D-16), forcing hard=
reset
>>> [ =A0 21.536004] ata2: link is slow to respond, please be patient (=
ready=3D0)
>>> [ =A0 26.352504] ata2: SRST failed (errno=3D-16)
>>> [ =A0 31.548004] ata2: link is slow to respond, please be patient (=
ready=3D0)
>>> [ =A0 36.364514] ata2: SRST failed (errno=3D-16)
>>> [ =A0 36.548307] ata2.00: ATAPI: ASUS =A0 =A0DRW-2014L1T, 1.02, max=
 UDMA/66
>>> [ =A0 36.548323] ata2.00: FORCE: xfer_mask set to pio0
>>> [ =A0 36.564827] ata2.00: configured for PIO0
>>> [ =A0 36.565669] scsi 1:0:0:0: CD-ROM =A0 =A0 =A0 =A0 =A0 =A0ASUS =A0=
 =A0 DRW-2014L1T
>>> =A01.02 PQ: 0 ANSI: 5
>>>
>>> I'm not sure if this is due to a modular libata or if that's just t=
he
>>> way it is with this particular problem..
>>
>> Yeah, PIO0 is forced for initial probing anyway, so the parameter is=
 a
>> bit bogus in this case. =A0I'm out of ideas. =A0Mark, marvell 88se61=
21 is
>> timing out the initial IDENTIFY but successfully probes it after a
>> couple of resets. =A0Any ideas?
>
> ..
>
> I haven't really been following along. =A0But.. I have zero informati=
on
> here about the Marvell 6121 --> it's supposedly an AHCI chip, isn't i=
t?
>
> The device that's failing is an optical drive. =A0These often won't r=
espond
> to many commands until the onboard firmware finishes examining whatev=
er disc
> happens to be inserted, which can take longer than the time we normal=
ly
> allow.
> I wonder if it has anything to do with that ?

I think it can be used with AHCI. I remember having some problems a
while back after a change went into the AHCI driver that caused it to
take over for the PATA port on the Marvell controller, disabling my
cdrom drive. I had to disable AHCI, downgrade the kernel, comment the
PCI id in ahci.c, or dump the PATA drive and it sounds like I just
commented out the PCI id until I got a SATA cdrom -
http://marc.info/?t=3D120996413200002&r=3D1&w=3D2

I don't believe mine is using AHCI right now though, the pata_marvell
module is loaded and I see this in dmesg:

[    0.985842] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3
Gbps 0x3f impl SATA mode

I have 6 SATA through ICH9R (4 internal, 2 external) and 1 SATA & 1
PATA through the Marvell controller. I assume the 6 it's talking about
are the 6 on the ICH9R. There are no other entries like that (if it
were to print more for another controller).

[    1.016364] scsi0 : ahci
[    1.018207] pata_marvell 0000:03:00.0: PCI INT A -> GSI 16 (level,
low) -> IRQ 16
[    1.018235] pata_marvell 0000:03:00.0: setting latency timer to 64
[    1.026464] scsi1 : ahci
[    1.026509] scsi2 : pata_marvell
[    1.026654] scsi3 : ahci
[    1.026735] scsi4 : pata_marvell
[    1.026759] ata7: PATA max UDMA/100 cmd 0xcc00 ctl 0xc880 bmdma 0xc4=
00 irq 16
[    1.026761] ata8: PATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 0xc4=
08 irq 16
[    1.027120] scsi5 : ahci
[    1.027306] scsi6 : ahci
[    1.027394] scsi7 : ahci
[    1.027479] ata1: SATA max UDMA/133 abar m2048@0xf9fff000 port
0xf9fff100 irq 28
[    1.027482] ata2: SATA max UDMA/133 abar m2048@0xf9fff000 port
0xf9fff180 irq 28
[    1.027484] ata3: SATA max UDMA/133 abar m2048@0xf9fff000 port
0xf9fff200 irq 28
[    1.027486] ata4: SATA max UDMA/133 abar m2048@0xf9fff000 port
0xf9fff280 irq 28
[    1.027488] ata5: SATA max UDMA/133 abar m2048@0xf9fff000 port
0xf9fff300 irq 28
[    1.027490] ata6: SATA max UDMA/133 abar m2048@0xf9fff000 port
0xf9fff380 irq 28

(the ataX number changed for some reason on my last reboot:)

[    6.368129] ata8.00: qc timeout (cmd 0xa1)
[    6.368134] ata8.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
=2E..
[   36.616318] ata8.00: configured for UDMA/66

Anyway, this failed to IDENTIFY / slow to respond / SRST message
appears regardless of a disc being in the drive. The only time it
doesn't appear is if I move the drive to the ICH9R controller. If this
is due to some drive initialization, I would have expected to see the
same or a similar error on both, but it only happens on the Marvell
controller. I've had a SATA hard drive on the Marvell SATA port before
and there were no errors. This is my second SATA DVD drive and they
both have the same problem. Maybe it's just not a very good controller
and it's doing bad/unexpected things.. I definitely wouldn't be using
it if I had an(other) open port on the ICH9R.

Thanks,

Mike
