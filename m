From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: solved: `softreset failed (device not ready)` gone with
 `CONFIG_SATA_PMP=n` (was: ASUS M2A-VM (SB600): AHCI setting in BIOS; AHCI
 and UDMA and `softreset failed (device not ready)`)
Date: Wed, 04 Jul 2012 17:33:53 +0200
Message-ID: <1341416033.4674.12.camel@mattotaupa>
References: <1326708221.11113.29.camel@mattotaupa>
	 <4F27523F.90200@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-N6uPDTnHqX7ebNTeQMol"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:58742 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab2GDPyI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2012 11:54:08 -0400
In-Reply-To: <4F27523F.90200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Robert Hancock <hancockrwd@gmail.com>


--=-N6uPDTnHqX7ebNTeQMol
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


this is a follow up for my message from January [7].

Am Montag, den 30.01.2012, 20:30 -0600 schrieb Robert Hancock:
> On 01/16/2012 04:03 AM, Paul Menzel wrote:

[=E2=80=A6]

> >          Jan 13 02:13:15 joe kernel: [    1.640626] ata1.00: ATAPI: TOS=
HIBA DVD-ROM SD-M1712, 1004, max UDMA/33
> >          Jan 13 02:13:15 joe kernel: [    1.656502] ata1.00: configured=
 for UDMA/33
> >          Jan 13 02:13:15 joe kernel: [    1.796038] ata6: SATA link dow=
n (SStatus 0 SControl 300)
> >          Jan 13 02:13:15 joe kernel: [    1.796076] ata5: SATA link dow=
n (SStatus 0 SControl 300)
> >          Jan 13 02:13:15 joe kernel: [    1.796132] ata4: SATA link dow=
n (SStatus 0 SControl 300)
> >          Jan 13 02:13:15 joe kernel: [    1.808018] usb 2-1: new low sp=
eed USB device number 2 using ohci_hcd
> >          Jan 13 02:13:15 joe kernel: [    1.968017] ata3: softreset fai=
led (device not ready)
> >          Jan 13 02:13:15 joe kernel: [    1.968063] ata3: applying PMP =
SRST workaround and retrying
> >
> > This seems to be related to a hardware bug in the SB600 chipset [3]. Th=
e
> > discussion [4] indicates that setting `CONFIG_SATA_PMP=3Dn` fixes this
> > issue. Although reading the option description [5] I do not understand
> > what it does and if it is advisable to disable it.
>=20
> Turning that off would prevent you from using any SATA port multipliers=
=20
> (usually found in things like multi-drive external enclosures). The=20
> kernel already worked around the issue so I don't think you need to=20
> worry about this.

[=E2=80=A6]

To make the story short the board was switched from ASUS M2A-VM (SB600) [8]
to ASRock A780FullHD (AMD 780G/SB700) [9]. The drive is still a Western
Digital WD20EARS-60MVWB0 connected to the SATA port.

New about the ASRock A780FullHD is also that some kind of AHCI BIOS ROM
is executed after the BIOS. So maybe there is a separate controller
included in the board. I do not know. I only know this adds another 5
seconds to the boot process. ;-)

Anyway I still saw the error `softreset failed (device not ready)` in
the Linux kernel ring buffer. This is shown at every boot at 2 seconds
after Linux is executed and during every resume.

        $ dmesg | grep ata1
        [    1.722407] ata1: SATA max UDMA/133 abar m1024@0xfddff800 port 0=
xfddff900 irq 22
        [    2.212024] ata1: softreset failed (device not ready)
        [    2.212063] ata1: applying PMP SRST workaround and retrying
        [    2.384049] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
        [    2.390552] ata1.00: ATA-8: WDC WD20EARS-60MVWB0, 51.0AB51, max =
UDMA/100
        [    2.390554] ata1.00: 3907029168 sectors, multi 0: LBA48 NCQ (dep=
th 31/32), AA
        [    2.396516] ata1.00: configured for UDMA/100
        [18757.377500] ata1: exception Emask 0x40 SAct 0x0 SErr 0x800 actio=
n 0x7
        [18757.377512] ata1: SError: { HostInt }
        [18757.377526] ata1: hard resetting link
        [18757.868051] ata1: softreset failed (device not ready)
        [18757.868063] ata1: applying PMP SRST workaround and retrying
        [18758.040049] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
        [18758.052521] ata1.00: configured for UDMA/100
        [18758.068039] ata1: EH complete
        [18771.044020] ata1: softreset failed (device not ready)
        [18774.560018] ata1: softreset failed (device not ready)
        [18774.560020] ata1: applying PMP SRST workaround and retrying
        [18774.732029] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
        [18774.744487] ata1.00: configured for UDMA/100

Building Linux myself and disabling SATA Port Multiplier support

        CONFIG_SATA_PMP=3Dn

the message is gone now.

        $ dmesg | grep ata1
        [    1.683069] ata1: SATA max UDMA/133 abar m1024@0xfddff800 port 0=
xfddff900 irq 22
        [    2.000192] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
        [    2.006761] ata1.00: ATA-8: WDC WD20EARS-60MVWB0, 51.0AB51, max =
UDMA/100
        [    2.006763] ata1.00: 3907029168 sectors, multi 0: LBA48 NCQ (dep=
th 31/32), AA
        [    2.012806] ata1.00: configured for UDMA/100
        [  148.124029] ata1: link is slow to respond, please be patient (re=
ady=3D0)

This was not there before and is after resume, but I guess this message
can be attributed to the drive needing time to spin up.

        [  152.772019] ata1: COMRESET failed (errno=3D-16)
        [  155.780033] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
        [  155.792109] ata1.00: configured for UDMA/100

Could the error message =C2=BBsoftreset failed (device not ready)=C2=AB be
reworded, since `CONFIG_SATA_PMP=3Dy` is used at least in Debian for the
default Linux kernel image?

        softreset failed (device not ready): no Port Multiplier available, =
might be AMD chipset bug we will work around

Now trying to reword it myself, it is kind of hard, but hopefully we can
come up with something.


Thanks,

Paul


> > [1] https://en.wikipedia.org/wiki/Advanced_Host_Controller_Interface
> > [2] http://www.intel.com/technology/serialata/ahci.htm
> > [3] https://bugzilla.redhat.com/show_bug.cgi?id=3D468800
> > [4] http://www.linuxquestions.org/questions/linux-kernel-70/ata4-softre=
set-failed-device-not-ready-865155/
> > [5] http://cateee.net/lkddb/web-lkddb/SATA_PMP.html
> > [6] http://www.spinics.net/lists/linux-ide/msg41224.html
[7] http://www.spinics.net/lists/linux-ide/msg42654.html
[8] http://www.asus.com/Motherboards/AMD_AM2/M2AVM/
[9] http://www.asrock.com/mb/overview.asp?model=3Da780fullhd

--=-N6uPDTnHqX7ebNTeQMol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAk/0YmEACgkQPX1aK2wOHVhodACghPbJ/eHKgwysCFmqKTl7cExv
/44An3Dq28uj9q+nmHCNWpvuR0oXtks4
=aYVI
-----END PGP SIGNATURE-----

--=-N6uPDTnHqX7ebNTeQMol--

