From: Tejun Heo <tj@kernel.org>
Subject: Re: Lenovo A740 gave up waiting for root device with kernels >= 4.3
Date: Wed, 13 Jul 2016 13:24:16 -0400
Message-ID: <20160713172416.GH4065@mtj.duckdns.org>
References: <87vb1mwz73.fsf@fsfe.org>
 <CAA=40861-zFKancJ3w5Zia2v9bpaN4TY3bw7Hi8G=97z_30qVA@mail.gmail.com>
 <87oa6de87q.fsf@mm.st>
 <CAA=4087zcySKFWkYWDUdb+Hfmg2i9QtJ631u9Fp8Uco5U4Y2XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33052 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbcGMRZh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 13:25:37 -0400
Content-Disposition: inline
In-Reply-To: <CAA=4087zcySKFWkYWDUdb+Hfmg2i9QtJ631u9Fp8Uco5U4Y2XQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Navin P.S" <navinp1912@gmail.com>
Cc: linux-ide@vger.kernel.org, Kevin Brubeck Unhammer <unhammer@fsfe.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

(cc'ing ACPI folks and retaining message body for context)

On Tue, Jul 05, 2016 at 11:01:53AM +0530, Navin P.S wrote:
> On Mon, Jul 4, 2016 at 8:55 PM, Kevin Brubeck Unhammer
> <unhammer@fsfe.org> wrote:
> >
> > Hi again,
> >
> > Navin found a workaround: acpi=3Dnoirq (and pci=3Dnoacpi) lets me b=
oot with
> > the newer kernels.
> >
> > Attached are dmesg's from 4.7rc2 and 4.7rc5 from
> > http://kernel.ubuntu.com/~kernel-ppa/mainline/ (rc5 complained abou=
t
> > missing noveau firmware; I haven't tried the newest linux-firmware
> > package yet, but haven't yet seen anything *not* working in rc5 tha=
t was
> > working in rc2).
> >
> >
> > Other changes when using acpi=3Dnoirq that may or may not be releva=
nt:
> > The computer will now poweroff when I do a shutdown, and restarts
> > correctly (it used to just "hang" at the end of the shutdown sequen=
ce),
> > and a bluetooth device shows up that I didn't know I had. However,
> > although I seem to be able to suspend, I can't resume (no response =
when
> > hitting power button). All in all an improvement though =E2=80=A6
> >
> >
> >
> > best regards,
> > Kevin Brubeck Unhammer
> >
> >
> >
> > "Navin P.S" <navinp1912@gmail.com> =C4=8D=C3=A1lii:
> >
> > > On Mon, Jun 6, 2016 at 1:01 PM, Kevin Brubeck Unhammer
> > > <unhammer@fsfe.org> wrote:
> > >> Hi,
> > >>
> > >> I have a Lenovo A740 (running Xubuntu 16.04) which, with kernel
> > >> versions >=3D 4.3.0, tested up until 4.7.0, gives this on trying=
 to boot:
> > >>
> > >>   Begin: Waiting for root file system ... Begin: Running
> > >>   /scripts/local-block ... done.
> > >>   Begin: Running /scripts/local-block ... done.
> > >>   Begin: Running /scripts/local-block ... done.
> > >>   [=E2=80=A6]
> > >>   done.
> > >>   Gave up waiting for root device.
> > >>
> > >> and drops me into an (initramfs) shell, where my keyboard is
> > >> unresponsive. The last kernel I tried which booted fine was 4.2.=
8.
> > >>
> > >> I reported this at https://bugzilla.kernel.org/show_bug.cgi?id=3D=
118401
> > >> and, after some investigation, was asked to contact ahci.c - AHC=
I SATA
> > >> support. The attachments in that report show some output from in=
itramfs
> > >> (using a script in /etc/initramfs-tools/scripts/init-premount du=
e to the
> > >> keyboard not working).
> > >>
> > >> What should I do to keep debugging this issue?
> > >>
> > >
> > > I have been working with Kevin on the bug 118401 .
> > >
> > > I'll post the summary.
> > > The kernel 4.2 works and he is able to boot the system.
> > > Kernel 4.4 and 4.6, 4.7  drops into initramfs shell for the same =
uuid.
> > > Upon further investigation cat /proc/devices showed no block devi=
ces
> > > other than zram and loop.The command /sbin/blkid on 4.6 and later
> > > didn't give any output whereas on 4.2 it does.
> > >
> > > Kernel 4.2 shows the ahci used count is 3
> > > ahci 36864 3 - Live 0x0000000000000000
> > > libahci 32768 1 ahci, Live 0x0000000000000000
> > >
> > > Where kernel 4.7 doesn't load the ahci module upon boot and upon
> > > modprobe ahci from the initramfs shell it shows the ahci count as=
 0.
> > > So it is not detecting the drive. Not sure why ?
> > >
> > > Some more things to note from 4.2 dmesg it prints not sure if it =
is relevant.
> > >
> > > [    0.716610] ahci 0000:00:1f.2: version 3.0
> > > [    0.716620] ahci 0000:00:1f.2: can't find IRQ for PCI INT B;
> > > probably buggy MP table
> > >
> > > [    0.735267] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports=
 6
> > > Gbps 0x1 impl SATA mode
> > >
> > > [    0.746033] ata1: SATA max UDMA/133 abar m2048@0xb5618000 port
> > > 0xb5618100 irq 44
> > >
> > > [    1.068001] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl =
300)
> > >
> > > [    1.134029] ata1.00: ATA-8: ST1000LM014-1EJ164-SSHD-8GB, LIV6,=
 max UDMA/133
> > > [    1.134030] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (d=
epth 31/32), AA
> > > [    1.178470] ata1.00: configured for UDMA/133
> > > [    1.178620] scsi 0:0:0:0: Direct-Access     ATA
> > > ST1000LM014-1EJ1 LIV6 PQ: 0 ANSI: 5
> > > [    1.178853] sd 0:0:0:0: [sda] 1953525168 512-byte logical bloc=
ks:
> > > (1.00 TB/931 GiB)
> > > [    1.178855] sd 0:0:0:0: [sda] 4096-byte physical blocks
> > > [    1.178879] sd 0:0:0:0: [sda] Write Protect is off
> > > [    1.178881] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > >
> > >
> > > where as 4.6 and later doesn't print these messages.dmesg | grep
> > > ata[0-4] gives no output.
> > >
> > > lspci on 4.2 gives this
> > >
> > > 00:1f.2 SATA controller: Intel Corporation 8 Series SATA Controll=
er 1
> > > [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
> > > Subsystem: Lenovo 8 Series SATA Controller 1 [AHCI mode]
> > > Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-
> > > Stepping- SERR- FastB2B- DisINTx+
> > > Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > > Latency: 0
> > > Interrupt: pin B routed to IRQ 44
> > > Region 0: I/O ports at 6088 [size=3D8]
> > > Region 1: I/O ports at 6094 [size=3D4]
> > > Region 2: I/O ports at 6080 [size=3D8]
> > > Region 3: I/O ports at 6090 [size=3D4]
> > > Region 4: I/O ports at 6060 [size=3D32]
> > > Region 5: Memory at b5618000 (32-bit, non-prefetchable) [size=3D2=
K]
> > > Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> > > Address: fee0400c  Data: 4181
> > > Capabilities: [70] Power Management version 3
> > > Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3ho=
t+,D3cold-)
> > > Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> > > Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
> > > Kernel driver in use: ahci
> > > Kernel modules: ahci
>=20
>=20
> Hi,
>=20
>    The default kernel parametes doesn't detect disk whereas when you
> pass kernel command line (acpi=3Dnoirq or pci=3Dnoacpi) the disk is
> detected and the machine is usable.
> Should this be forwarded to linux-acpi list ?
>=20
> This machine was usuable without any arguments like acpi=3Dnoirq and
> pci=3Dnoacpi in 4.2 .
>=20
> What does this usually indicate buggy bios ?
>=20
> I can see some parse execution error in dmesg attached.

Yeah, looks like an IRQ routing problem.  cc'd ACPI folks.

Thanks.

--=20
tejun
