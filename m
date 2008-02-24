From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: IDE cdrom problem with PLEXTOR DVDR PX-608AL
Date: Sun, 24 Feb 2008 18:34:51 +0100
Message-ID: <20080224173451.GB11998@gollum.tnic>
References: <426a98560802232138q41d45d52ta515f1b791e937f4@mail.gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:10230 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbYBXRez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 12:34:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1442903wah.23
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 09:34:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <426a98560802232138q41d45d52ta515f1b791e937f4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Rosser <brad.rosser@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 24, 2008 at 03:38:34PM +1000, Brad Rosser wrote:

[ Added Bart to CC: ]

Hi Brad,

> Borislav Petkov wrote:
>=20
> > > Feb 14 00:18:18 kernel: hde: cdrom_pc_intr: The drive appears con=
fused (ireason =3D 0x01).
> > > Trying to recover by ending request.
> > > Feb 14 00:27:27 kernel: hdc: cdrom_pc_intr: The drive appears con=
fused (ireason =3D 0x01).
> > > Trying to recover by ending request.
> > >
> > > ~> uname -a
> > > Linux xrated 2.6.24.1-35-pae #1 SMP 2008/02/12 01:00:18 UTC i686 =
athlon i386 GNU/Linux
> >
> > Actually the interrupt handler in ide-cd got rewritten and you're s=
till using the
> > old one (cdrom_pc_intr vs cdrom_newpc_intr). Those changes went int=
o mainline before
> > the 2.6.25-rc1 so we'll be able to test the new one only when you t=
ry out 2.6.25-rc1
> > or wait until 2.6.25 is released in case you don't want to try haza=
rdous materials
> > such as an -rc kernel[*] :).
>=20
> I have exactly the same problem.  I have a two-month old PC with a
> Gigabyte P35-DS4
> motherboard, which has the Intel P35 chipset with ICH10 south bridge =
and
> additional JMicron IDE/SATA controller.  I have two SATA-II hard disk=
s
> and a sole
> IDE device, a Pioneer DVR-115D DVD-ROM, hooked up to the JMicron IDE =
port.
> The motherboard also has an embedded Realtek RTL8111/8168B gigabit
> ethernet controller.
>=20
> The motherboard/bios assigns both the JMicron IDE controller and the =
Realtek
> controller to the same interrupt - typically '15'.  There's nothing i=
n
> the bios that
> allows me to move one away from the other.  I can 'reserve' or block =
IRQs, but
> that only shifts them both to another interrupt.

well the driver probes the bios for that data and assigns the irq line =
it gets
from it.

> Similarly, no matter what I do with the Linux kernel, using boot para=
meters such
> as 'acpi=3Doff', 'noapic', 'nolapic' and the like, I can never get th=
e
> kernel to use
> different interrupts for these two controllers.  A 'cat
> /proc/interrupts' always shows
> them sharing their IRQ:
>=20
>   # grep ide /proc/interrupts
>   17:   58077   4   98999   129160   IO-APIC-fasteoi   ide0, eth0
>=20
> With the IDE driver compiled into the kernel any access to the DVD is=
 fine
> until I start using the network.  Upon any network activity I get the=
 'confused'
> messages and more:
>=20
> kernel: hda: cdrom_pc_intr: The drive appears confused (ireason =3D
> 0x01). Trying to recover by ending request.
> last message repeated 3 times
> kernel: ide: failed opcode was: unknown
> kernel: hda: drive not ready for command
> kernel: hda: status error: status=3D0x58 { DriveReady SeekComplete Da=
taRequest }
>=20
> KDE even kindly pops up a window telling me that someone has inserted=
 a (ghost)
> DVD disc, would I care to play it?  :-(
>=20
> I know nothing of modern/PCI hardware and their interrupt magic, but =
it seemed
> to me that the IDE driver was erroneously picking up the interrupts d=
estined for
> the Realtek NIC and thinking they were for it.  Unfortunately there s=
eemed to be
> no way for me to separate the two or get the IDE driver its own IRQ, =
either via
> the PC's bios or linux kernel boot parameters.
>=20
> When I saw the recent message from Hans-Peter Jansen about this exact
> problem, and Boris's comment that something in interrupt land for the
> CD driver had been fixed, I thought the latest version of the kernel =
would
> rectify matters.  I installed the 2.6.25-rc2 kernel from kernel.org
> but the problem
> is still there.

Can you please send me your whole boot log of 2.6.25-rc2? Thanks.

>=20
> As a workaround I've disabled IDE entirely in my kernel build and am =
using
> sr_mod to present the DVD as /dev/sr0.
>=20
> As a result of all this I've got several novice questions relating to
> this matter.
> I don't know if this mailing list is an appropriate place to ask them
> .. my apologies
> if not.  Any quick references to reference material would be apprecia=
ted.
>=20
> Given all the kernel parameters to change IRQ routing and turn ACPI a=
ctions
> up, down and sideways, is there any way to tell it to assign an expli=
cit
> IRQ to a device?  Or have it that the IDE driver doesn't share?  I th=
ought
> CONFIG_IDEPCI_SHARE_IRQ might have something to do with it, but fiddl=
ing
> the value for that had no effect.  It 'feels' to me that all these IR=
Qs seem to
> be highly adjustable by the kernel, so I was hoping there'd be a way =
to
> let the IDE driver have one to itself.
>=20
> Is there any way to leave the IDE driver compiled into the kernel but=
 tell
> it to leave the DVD-ROM drive alone, so sr_mod can claim it rather th=
an
> ide-cd?  I couldn't do it with my kernel, but I think Ubuntu (7.10) d=
oes
> manage it.  I tried various kernel boot parameters like 'hda=3Dscsi' =
or
> 'hda=3Dide-scsi' but nothing seemed to work.  It would be nice to be =
able
> to use IDE hard disks while leaving the DVD-ROM to sr_mod until this
> problem is resolved.

since your cdrom seems to be hda from what i've seen above, try booting=
 with
'hda=3Dnoprobe' or maybe 'hda=3Dnone' to see which one turns the probin=
g off for
you. See Documentation/ide.txt for details.
>=20
> Is there a primer/guide somewhere on how the modules all inter-relate
> in the kernel?  When IDE is compiled I see 'ide0' sharing IRQ17 with
> 'eth0' in /proc/interrupts.  When IDE is disabled it's replaced with
> 'libata' (which DOESN'T have any problems sharing).  I'm just curious
> as to why 'libata' isn't seen when IDE is taking front stage; does it
> sit underneath somehow?  Similarly I'm a bit fuzzy on how sr_mod
> sits on top of 'cdrom' while 'ide-cd' uses both 'cdrom' and ide-core.
> I'm just curious on how they all work together.  Does the 'cdrom'
> module talk straight to the DVD-ROM hardware or does it go though
> libata?  I always thought it used IDE.

Roughly speaking, cdrom.c is the unified cdrom layer that delivers comm=
on
functionality to all the cdrom devices. ide-cd and others are the low-l=
evel
device drivers that offer drive-specific functionality only. In case yo=
u wanna
know more about it, see Documentation/cdrom/cdrom-standard.tex (might w=
ant to
convert it to something more readable) and read the section on stackabl=
e kernel
modules in Linux Device Drivers, 3 ed.
>=20
> My apologies if this post is at too simple/high a level for the wizar=
ds
> present.  I thought the feedback on 2.6.25-rc2 might be useful.
>=20
> Thanks,
>=20
>=20
> Brad

--=20
Regards/Gru=DF,
    Boris.
