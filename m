From: Pedro R <eusou15@yahoo.com>
Subject: Re: PROBLEM: When hibernating or resuming, ide driver locks the computer with 100% cpu utilization (2.6.28.7)
Date: Sat, 28 Mar 2009 14:22:34 -0700 (PDT)
Message-ID: <293201.49435.qm@web32106.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web32106.mail.mud.yahoo.com ([68.142.207.120]:27628 "HELO
	web32106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760499AbZC1VWg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Mar 2009 17:22:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com


Thanks that is great news!

Can you CC me or tell me where can I sign up to get an email when the p=
roblem is solved?

Pedro

--- On Sat, 28/3/09, Borislav Petkov <petkovbb@googlemail.com> wrote:

> From: Borislav Petkov <petkovbb@googlemail.com>
> Subject: Re: PROBLEM: When hibernating or resuming, ide driver locks =
the computer with 100% cpu utilization (2.6.28.7)
> To: "Pedro R" <eusou15@yahoo.com>
> Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com
> Date: Saturday, 28 March, 2009, 2:34 PM
>=20
> -----Inline Attachment Follows-----
>=20
> (adding Bart to cc)
>=20
> On Fri, Mar 27, 2009 at 09:59:22AM -0700, Pedro R wrote:
> >=20
> > Sorry for not being more specific, this is quite a
> hard bug to catch. I've been chasing it for a few months
> now,=20
> > I first thought it was a TuxOnIce bug, then a
> framebuffer bug, but now i'm pretty sure it's the ide
> driver.
> >=20
> > Anyway, here is how to reproduce it:
> >=20
> > 0 - Boot the computer (i.e. without any resume)
> > 1 - inside GNOME, insert a CD / DVD in the drive. Wait
> for it to be auto mounted.
> > 2 - Hibernate the computer. Hibernation performs
> sucessfully.
> > 3 - Turn on the computer, and resume. Resume performs
> sucessfully.
> > 4 - Once back in GNOME, remove the CD / DVD. It
> umounts, but then GNOME displays an error of the like
> > "Cannot unmount the CD", however it is already
> umounted!
> > 5 - Start the hibernation process. CPU jumps
> immediately to 100%, displaying infinetely the message:
> >=20
> >=A0 ide: status error =3D 0x04 {DriveReady
> SeekComplete DataRequest Error}
> >=A0 hdc: failed opcode =3D 0x059
>=20
> Haa,
>=20
> now it rings a very large bell here! Well, we know about
> this bug and
> this is not ide-cd but more something else. The current
> theory is
> that it is chipset related since you're getting this on the
> same ide
> controller as I can reproduce it here on:
>=20
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.440668] Uniform Multi-Platform E-IDE driver
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.443486] piix 0000:00:1f.1: IDE controller (0x8086:0x24ca
> rev 0x03)
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.446331] PIIX_IDE 0000:00:1f.1: enabling device (0005 ->
> 0007)
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.449257] PIIX_IDE 0000:00:1f.1: PCI INT A -> GSI 18
> (level, low) -> IRQ 18
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.452262] piix 0000:00:1f.1: not 100% native mode: will
> probe irqs later
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.455354]=A0 =A0=A0=A0ide0: BM-DMA at
> 0x1100-0x1107
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.458545]=A0 =A0=A0=A0ide1: BM-DMA at
> 0x1108-0x110f
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.461755] Probing IDE interface ide0...
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.682363] Switched to high resolution mode on CPU 0
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 0.698129] hda: HTS721010G9AT00, ATA DISK drive
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 1.313051] hda: host max PIO4 wanted PIO255(auto-tune)
> selected PIO4
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 1.313280] hda: UDMA/100 mode selected
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 1.316824] Probing IDE interface ide1...
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 1.988130] hdc: Optiarc DVD RW AD-7630A, ATAPI CD/DVD-ROM
> drive
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.603048] hdc: host max PIO4 wanted PIO255(auto-tune)
> selected PIO4
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.606065] hdc: UDMA/33 mode selected
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.612591] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.632370] ide1 at 0x170-0x177,0x376 on irq 15
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.639305] ide-gd driver 1.18
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.642994] hda: max request size: 512KiB
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.646892] hda: 195371568 sectors (100030 MB) w/7539KiB
> Cache, CHS=3D16383/255/63
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.650948] hda: cache flushes supported
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.654652]=A0 hda: hda1 hda2 hda3 < hda5 hda6 hda7
> >
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.703252] ide-cd driver 5.00
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.716065] ide-cd: hdc: ATAPI 24X DVD-ROM DVD-R/RAM CD-R/RW
> drive, 2048kB Cache
> > Mar 27 16:35:23 portatel kernel: [=A0 =A0
> 2.719993] Uniform CD-ROM driver Revision: 3.20
>=20
> vs mine:
>=20
> [=A0 =A0 4.242548] Uniform Multi-Platform E-IDE
> driver
> [=A0 =A0 4.242774] piix 0000:00:1f.1: IDE controller
> (0x8086:0x24cb rev 0x02)
> [=A0 =A0 4.242841] pci 0000:00:1f.1: PCI INT A ->
> GSI 18 (level, low) -> IRQ 18
> [=A0 =A0 4.242919] piix 0000:00:1f.1: not 100% native
> mode: will probe irqs later
> [=A0 =A0 4.242976]=A0 =A0=A0=A0ide0:
> BM-DMA at 0xfc00-0xfc07
> [=A0 =A0 4.243050]=A0 =A0=A0=A0ide1:
> BM-DMA at 0xfc08-0xfc0f
> [=A0 =A0 4.243104] Probing IDE interface ide0...
>=20
> Stay tuned...
>=20
> --=20
> Regards/Gruss,
> =A0 =A0 Boris.
>=20


     =20
