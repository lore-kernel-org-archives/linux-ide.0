From: Rasmus Melgaard <rme@image.dk>
Subject: Re: [Fwd: Re: sata_sil problems (lockup at boottime)]
Date: Tue, 8 Feb 2005 11:36:05 +0100
Message-ID: <200502081136.05737.rme@image.dk>
References: <4208483C.2060808@comcast.net>
Reply-To: rme@image.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from smarthost1.tiscali.dk ([62.79.79.25]:51371 "EHLO
	smarthost1.tiscali.dk") by vger.kernel.org with ESMTP
	id S261509AbVBHKgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 05:36:09 -0500
In-Reply-To: <4208483C.2060808@comcast.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug McLain <nostar@comcast.net>
Cc: linux-ide@vger.kernel.org

Hi,

I had problems with the sata_sil (pci sil3112) at boot time, the proble=
m was=20
bios settings for the PCI bus. I disabled 'BYTE MERGE' on my Asus A7V b=
oard=20
and i worked.

Rasmus

On Tuesday 08 February 2005 06:03, Doug McLain wrote:
> Any word on this? It's been reported here a few times now.
>
> I am having exactly the same problem, the only difference being the
> model of drive.  Mine is a WD2000.  The sata_sil module loads ok thou=
gh,
> if the drive is not connected.  If it is connected, hard lock.  Teste=
d
> on 2.4.25, 2.6.9, 2.6.10.
>
> Doug





> Encapsulated message
>=20
>=20
> Re: sata_sil problems (lockup at boottime)
>=20
>=20
> From:=20
> Doug McLain <nostar@comcast.net>
>=20
>=20
> To:=20
> Gerald Hopf <gerald.hopf@nv-systems.net>, linux-kernel@vger.kernel.or=
g
>=20
>=20
> Date:=20
> 2005-01-10 16:34
>=20
>=20
> Gerald Hopf wrote:
> > Hello everyone,
> >=20
> > i'm having some really strange problems with the sata_sil driver.
> >=20
> > My hardware:
> > Asus A7N8X Deluxe Rev 1.x with onboard Sil3112 Controller
> > - Samsung SP1614C SATA Harddrive
> > - for further testing : PATA to SATA Adapter that came with an ABIT=
=20
> > Mainboard
> >=20
> > What i'm trying to accomplish: i'm trying to use this Samsung SATA=20
> > harddrive in my Linux Fileserver:
> >=20
> > When the Silicon Image Controller is enabled (it can be disabled by=
 a=20
> > jumper) and no harddrive is connected, everything boots fine.
> > If i connect a harddrive, i get the following message (exact messag=
es=20
> > change slightly) while booting:
> >=20
> > - - - - - =A0START =A0- - - - -
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [<c0102716>] common_interrupt+0x1a/0x20
> > [<c0117d70>] __do_softirq+0x30/0x90
> > [<c0104261>] do_softirq+0x41/0x50
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [<c012d0a4>] irq_exit+0x34/0x40
> > [<c0104165>] do_IRQ+9x45/0x60
> > [<c0102716>] common_interrupt+0x1a/0x20
> > [<c010c674>] delay_tsc+0x14/0x20
> > [<c025efd2>] __delay+0x12/0x20
> > [<c02d7290>] ata_pio_complet+0xe0/0x1f0
> > [<c02d7a95>] ata_pio_test+0x95/0xb0
> > [<c01229bc>] worker_thread+0x1cc/0x290
> > [<c02d7a00>] ata_pio_task+0x0/0xb0
> > [<c0110160>] default_wake_function+0x0/0x20
> > [<c0110160>] default_wake_function+0x0/0x20
> > [<c01227f0>] worker_thread+0x0/0x290
> > [<c0126ca5>] kthread+0xa5/0xb0
> > [<c0126c00>] kthread+0x0/0xb0
> > [<c01006f1>] kernel_thread_helper+0x5/0x14
> > handlers:
> > [<c02d82b0>] (ata_interrupt+0x0/0x1c0)
> > Disabling IRQ #11
> > ata: dev 0 ATA, max UDMA/100, 361882080 sectors: lba 48
> > _
> > - - - - - =A0END - - - - -
> >=20
> > This happens with both the Samsung SP1614C "native" SATA drive, as =
well=20
> > as with an IBM 180GB PATA drive, using a PATA-to-SATA Adapter.
> > So i'm not sure whether this is harddrive dependent, but at least i=
t=20
> > doesn't look like it...
> >=20
> > This problem has been there in all of the latest 2.6.X kernel revis=
ions.=20
> > I'm currently using 2.6.10-rc3 (which came out today), but i've all=
ready=20
> > had this problem in 2.6.9 and 2.6.8 and probably even 2.6.7 if i=20
> > remember correctly.
> >=20
> > I tried quite a lot to get rid of those problems, including:
> > - Flashing a new/different Bios (even with different versions of th=
e=20
> > Silicon Image SATA Bios part: 4.2.47 and 4.2.50)
> > - Disabling APIC in the Bios, compiling Kernel with or without APIC
> > - Changing the IRQ of the Controller by reserving IRQ#11 in the Bio=
s
> > - Disabling allmost every other onboard device i could, including=20
> > serial/parallel/usb/firewire/3com lan (and there are no PCI/Addon c=
ards=20
> > besides an nvidia geforce2mx agp card installed in this pc anyway!)
> > - Connecting drives to both ports
> >=20
> > I found the following discussions which might be related to what i'=
m=20
> > experiencing, but noone seems to have a solution. Some seem to sugg=
est=20
> > it worked fine till 2.6.5:
> > (The first two seem to be most related, i'm not so sure of the thir=
d one)
> > http://www.fedoraforum.org/forum/archive/index.php/t-26543.html
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D128180
> > http://www.fedoraforum.org/forum/archive/index.php/t-23028.html
> >=20
> > Screenshots of the error messages can be found here:
> > http://www.nv-systems.net/pics/lkml/sata_sil1.jpg <-- the one from =
above
> > http://www.nv-systems.net/pics/lkml/sata_sil2.jpg <-- with samsung=20
> > instead of ibm
> > http://www.nv-systems.net/pics/lkml/sata_sil3.jpg <-- the screen ju=
st=20
> > before the problem
> >=20
> > Is there ANYTHING i can do (except buying a promise controller) ?
> >=20
> > Yours sincerely,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gerald
>=20
> I am having exactly the same problem, the only difference being the=20
> model of drive. =A0Mine is a WD2000. =A0The sata_sil module loads ok =
though,=20
> if the drive is not connected. =A0If it is connected, hard lock. =A0T=
ested=20
> on 2.4.25, 2.6.9, 2.6.10.
>=20
> Doug
>=20
> --=20
> http://nostar.net/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>=20
>=20
>=20
>=20
>=20
> End of encapsulated message
