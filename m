From: "Shai Fultheim" <shai@ftcon.com>
Subject: Multiple (ICH3) IDE-controllers in a system
Date: Tue, 4 May 2004 15:13:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200405042213.BLD39867@ms6.netsolmail.com>
Reply-To: <shai@ftcon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S261296AbUEDWNj@vger.kernel.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

I am working on an IO-robust custom-made PC server, which runs the Linu=
x
kernel.=A0 The machine is working very nicely with 2.4 kernels, but we
recently found out that in 2.6 it couldn't see all IDE controllers.

In Linux 2.6.x pcibios_fixups table (in arch/i386/pci/fixup.c), use the
pci_fixup_ide_trash() quirk for Intel's ICH3 (my case specifically
8086:248b).=A0 That quirk wasn't in use for ICH3 by the 2.4.x kernels.=A0=
 The
result of the change is that the system, which has multiple ICH3's can'=
t use
any of the IDE controllers beside the one on the first ICH3 (again, tha=
t
worked in 2.4 kernels).

Is there a real reason to call that quirk?=A0 If there is not, why are =
you
calling that quirk?=A0 If there is, can I suggest that the quirk will h=
andle
only the first ICH3 (i.e. add check in the quirk that it is called for =
the
first time only).=A0 This is better than "loosing" all these IDE contro=
llers
in the case their BARs set right.


Blow references for bare 2.6.5 kernel:

Code walkup starts with pci_scan_single_device() at
http://lxr.linux.no/source/drivers/pci/probe.c?v=3D2.6.5#L590 which cal=
ls to
pci_fixup_device() (line 601) which in turn use the quirks table at
http://lxr.linux.no/source/arch/i386/pci/fixup.c?v=3D2.6.5#L190 (my chi=
pset is
in line 248).=A0 The quirks table for ICH3 use pci_fixup_ide_trash()at
http://lxr.linux.no/source/arch/i386/pci/fixup.c?v=3D2.6.5#L90 - this r=
eset
the BARs for the device.=A0 Resetting the all (4) BARs of (ICH3) IDE
controllers will cause them to use the defaults BARs (0x170, 0x1f0) in
ide_hwif_configure() at
http://lxr.linux.no/source/drivers/ide/setup-pci.c?v=3D2.6.5#L420.=A0 T=
his will
fail with any subsequent (ICH3) IDE controllers (two devices can't use =
the
same ports).=A0=20

I'm not sure if ICH3 needs to reset its BARs at all, but if it is, I su=
ggest
making sure pci_fixup_ide_trash() reset BARs only for first time being
called.=A0 In that way subsequent IDE controllers will use the BIOS BAR=
s
(which we set fine, and worked GREAT at 2.4.x), as said above, this is
better than "loosing" all the other IDE controllers in the case their B=
ARs
set right.

Thanks in advance,
Shai.


=A0
_________________________
Shai Fultheim
=46T Consulting
=A0
Mobile: +1 (408) 480-1612
=46ax:    +1 (501) 647-4113
E-Mail: shai@ftcon.com
Web:=A0=A0=A0 www.ftcon.com
