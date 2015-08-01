From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: linux: sata_nv: adma support
Date: Sat, 1 Aug 2015 22:09:27 +0200
Message-ID: <201508012209.27974@pali>
References: <201412232051.07067@pali> <CADLC3L2N2TcO4FR1Bqt2n=g5G+i=dv_y_OhYHA9yXg79Bb6JPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2112697.yInFgq33Nr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADLC3L2N2TcO4FR1Bqt2n=g5G+i=dv_y_OhYHA9yXg79Bb6JPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--nextPart2112697.yInFgq33Nr
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 25 December 2014 07:22:13 Robert Hancock wrote:
> On Tue, Dec 23, 2014 at 1:51 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > Hello,
> >=20
> > I have nvidia nforce4 motherboard with nvidia sata controller:
> >=20
> > 00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA
> > Controller [10de:0054] (rev f3)
> > 00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA
> > Controller [10de:0055] (rev f3)
> >=20
> > I manually enabled adma mode (which is disabled by default) by
> > adding sata_nv.adma=3D1 to grub cmdline. In git history I found
> > that enabling adma mode includes NCQ support and reduced CPU
> > overhead. It looks like adma mode is working, but at every boot I
> > see one same error message in dmesg:
> >=20
> > [   16.823514] ata1.00: exception Emask 0x1 SAct 0x0 SErr 0x0
> > action 0x0
> > [   16.823520] ata1.00: CPB resp_flags 0x11: , CMD error
> > [   16.823524] ata1.00: failed command: SET FEATURES
> > [   16.823530] ata1.00: cmd ef/05:fe:00:00:00/00:00:00:00:00/40
> > tag 16
> > [   16.823530]          res 51/04:fe:00:00:00/00:00:00:00:00/40
> > Emask 0x1 (device error)
> > [   16.823533] ata1.00: status: { DRDY ERR }
> > [   16.823535] ata1.00: error: { ABRT }
> >=20
> > When adma is disabled then this error message is not generated.
>=20
> It looks like something is trying to issue a command to disable APM
> power management on the drive, and the command fails (likely because
> it doesn't support that command). I'm not sure where that would be
> coming from - I'm pretty sure the kernel doesn't issue that command
> itself. Something that's part of your distro perhaps?
>=20
> I don't know why it would only be failing in ADMA mode either, though
> depending on where the command is coming from, maybe it's not being
> issued otherwise for some reason?
>=20
> > What does that error message means? It is critical? What is that
> > command SET FEATURES doing? Are there any problems with adma mode
> > on nforce4 motherboards? Because I did not see any problems
> > (except that one error message).
> >=20
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

Hello,

now after long time I did more investigation and that error is reported=20
for every connected HDD. I identified that it comes from udev script

 /lib/udev/rules.d/85-hdparm.rules

which just call script /lib/udev/hdparm for every one connected HDD.

Script /lib/udev/hdparm just call:

 /sbin/hdparm -B254 $DRIVE

And that -B254 cause above error message in dmesg log. Output from=20
hdparm is:

 /dev/sda:
  setting Advanced Power Management level to 0xfe (254)
  APM_level      =3D not supported

Any idea why in ADMA mode it cause above error (APM unsupported) and in=20
non ADMA mode it is working fine? Maybe APM ATA commands should not be=20
sent via ADMA?

Here is another output:

 $ sudo hdparm -I /dev/sda | grep -i power
            *    Power Management feature set
                 Power-Up In Standby feature set
            *    SET_FEATURES required to spinup after power up
            *    Host-initiated interface power management

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2112697.yInFgq33Nr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW9J3cACgkQi/DJPQPkQ1J1yACgkj0EryJ98p6W3+pnxnG3doa5
W2EAoKWUfMLEXnnV+varrJhH98fcsyHW
=Aey/
-----END PGP SIGNATURE-----

--nextPart2112697.yInFgq33Nr--
