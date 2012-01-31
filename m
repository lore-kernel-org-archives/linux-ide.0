From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ASUS M2A-VM (SB600): AHCI setting in BIOS; AHCI and UDMA and
 `softreset failed (device not ready)`
Date: Mon, 30 Jan 2012 20:30:23 -0600
Message-ID: <4F27523F.90200@gmail.com>
References: <1326708221.11113.29.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36118 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab2AaCa1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2012 21:30:27 -0500
Received: by vcge1 with SMTP id e1so18500vcg.19
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2012 18:30:26 -0800 (PST)
In-Reply-To: <1326708221.11113.29.camel@mattotaupa>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org

On 01/16/2012 04:03 AM, Paul Menzel wrote:
> Dear Linux folks,
>
>
> please keep my address in CC list since I am not subscribed.
>
> I am sorry for asking again for clarification for messages from Linux=
 in
> `/var/log/kern.log`.
>
>          Jan 13 02:13:15 joe kernel: [    1.477687] ahci 0000:00:12.0=
: version 3.0
>
> Whose version is this indication? Looking at the Wikipedia article [1=
]
> and the AHCI link therein [2], specification numbers seem to 1.x.

That's the driver version (which is of questionable usefulness), not th=
e=20
AHCI version.

>
> Additionally having a sentence there, like `chipset support AHCI vers=
ion
> 3.0` would be =E2=80=9Cbetter=E2=80=9D in my opinion. If you agree, I=
 can send a patch.
>
>          Jan 13 02:13:15 joe kernel: [    1.477718] ahci 0000:00:12.0=
: PCI INT A ->  GSI 22 (level, low) ->  IRQ 22
>          Jan 13 02:13:15 joe kernel: [    1.477748] ahci 0000:00:12.0=
: ASUS M2A-VM: enabling 64bit DMA
>          Jan 13 02:13:15 joe kernel: [    1.477981] ahci 0000:00:12.0=
: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode

That line indicates AHCI 1.1.

>          Jan 13 02:13:15 joe kernel: [    1.477986] ahci 0000:00:12.0=
: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc
>          Jan 13 02:13:15 joe kernel: [    1.479052] scsi2 : ahci
>          Jan 13 02:13:15 joe kernel: [    1.479142] scsi3 : ahci
>          Jan 13 02:13:15 joe kernel: [    1.479220] scsi4 : ahci
>          Jan 13 02:13:15 joe kernel: [    1.479296] scsi5 : ahci
>          Jan 13 02:13:15 joe kernel: [    1.479434] ata3: SATA max UD=
MA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 22
>          Jan 13 02:13:15 joe kernel: [    1.479438] ata4: SATA max UD=
MA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 22
>          Jan 13 02:13:15 joe kernel: [    1.479442] ata5: SATA max UD=
MA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 22
>          Jan 13 02:13:15 joe kernel: [    1.479447] ata6: SATA max UD=
MA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 22
>
> So, AHCI and UDMA are unrelated? (Just to be sure once and for all. ;=
-))

Basically, yes

>
>          Jan 13 02:13:15 joe kernel: [    1.640626] ata1.00: ATAPI: T=
OSHIBA DVD-ROM SD-M1712, 1004, max UDMA/33
>          Jan 13 02:13:15 joe kernel: [    1.656502] ata1.00: configur=
ed for UDMA/33
>          Jan 13 02:13:15 joe kernel: [    1.796038] ata6: SATA link d=
own (SStatus 0 SControl 300)
>          Jan 13 02:13:15 joe kernel: [    1.796076] ata5: SATA link d=
own (SStatus 0 SControl 300)
>          Jan 13 02:13:15 joe kernel: [    1.796132] ata4: SATA link d=
own (SStatus 0 SControl 300)
>          Jan 13 02:13:15 joe kernel: [    1.808018] usb 2-1: new low =
speed USB device number 2 using ohci_hcd
>          Jan 13 02:13:15 joe kernel: [    1.968017] ata3: softreset f=
ailed (device not ready)
>          Jan 13 02:13:15 joe kernel: [    1.968063] ata3: applying PM=
P SRST workaround and retrying
>
> This seems to be related to a hardware bug in the SB600 chipset [3]. =
The
> discussion [4] indicates that setting `CONFIG_SATA_PMP=3Dn` fixes thi=
s
> issue. Although reading the option description [5] I do not understan=
d
> what it does and if it is advisable to disable it.

Turning that off would prevent you from using any SATA port multipliers=
=20
(usually found in things like multi-drive external enclosures). The=20
kernel already worked around the issue so I don't think you need to=20
worry about this.

>
>          [=E2=80=A6]
>
>          Jan 13 02:13:15 joe kernel: [    2.140032] ata3: SATA link u=
p 3.0 Gbps (SStatus 123 SControl 300)
>          Jan 13 02:13:15 joe kernel: [    2.146085] ata3.00: ATA-8: W=
DC WD20EARS-60MVWB0, 51.0AB51, max UDMA/100
>          Jan 13 02:13:15 joe kernel: [    2.146088] ata3.00: 39070291=
68 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
>          Jan 13 02:13:15 joe kernel: [    2.146094] ata3.00: SB600 AH=
CI: limiting to 255 sectors per cmd
>          Jan 13 02:13:15 joe kernel: [    2.152134] ata3.00: SB600 AH=
CI: limiting to 255 sectors per cmd
>          Jan 13 02:13:15 joe kernel: [    2.152138] ata3.00: configur=
ed for UDMA/100
>
> This seems to be related to [6], although the chipset SB600 seems to
> support 3.0 Gbps instead of only 1.5 Gbps with the VIA K8T890. The dr=
ive
> only seems to propagate UDMA/100 which is fine.

The UDMA speed setting really doesn't matter with SATA devices. The mod=
e=20
selection is really just a vestige of PATA and doesn't actually affect=20
anything unless there is actually a physical PATA link somewhere in the=
=20
chain (which there almost certainly is not).

>
> My main question is, that in the BIOS =C2=BBOnboard SATA Type=C2=AB i=
s set to =C2=BBIDE
> Controller=C2=AB by default. Is that true? But looking at the output =
AHCI
> seems to be used nevertheless so the BIOS setting seems to be ignored=
 or
> does not make any difference to setting it to =C2=BBAHCI=C2=AB. So wo=
uld changing
> the option to =C2=BBAHCI=C2=AB give any benefit? Would it get rid of =
the
> `softreset failed (device not ready)` too?

I'm not sure what that mode selection would actually affect on this=20
board. On Intel chipsets you can only use AHCI if the BIOS is in the=20
correct mode since the AHCI device isn't exposed otherwise, but on most=
=20
other chipsets, but most others expose the AHCI capabilities all the=20
time and so it doesn't really matter. Maybe it changes the device ID an=
d=20
therefore affects which driver Windows will load or let you use for the=
=20
controller but I doubt it really makes much difference in Linux. (I=20
doubt it would affect that SRST message either, that seems to just be a=
=20
bug in that chipset.)

>
>
> Thanks,
>
> Paul
>
>
> [1] https://en.wikipedia.org/wiki/Advanced_Host_Controller_Interface
> [2] http://www.intel.com/technology/serialata/ahci.htm
> [3] https://bugzilla.redhat.com/show_bug.cgi?id=3D468800
> [4] http://www.linuxquestions.org/questions/linux-kernel-70/ata4-soft=
reset-failed-device-not-ready-865155/
> [5] http://cateee.net/lkddb/web-lkddb/SATA_PMP.html
> [6] http://www.spinics.net/lists/linux-ide/msg41224.html

