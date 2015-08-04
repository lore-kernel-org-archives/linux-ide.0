From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: linux: sata_nv: adma support
Date: Tue, 4 Aug 2015 20:06:57 +0200
Message-ID: <201508042006.57727@pali>
References: <201412232051.07067@pali> <201508021108.52978@pali> <CADLC3L3eym59Agpm2J_Oy_Eyfq=9iUTwi2BPxnLxoEM_Yx9cfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2526243.CHWLSQY06r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35087 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbHDSHC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Aug 2015 14:07:02 -0400
In-Reply-To: <CADLC3L3eym59Agpm2J_Oy_Eyfq=9iUTwi2BPxnLxoEM_Yx9cfw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

--nextPart2526243.CHWLSQY06r
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 03 August 2015 05:02:15 Robert Hancock wrote:
> On Sun, Aug 2, 2015 at 3:08 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > On Sunday 02 August 2015 03:45:32 Robert Hancock wrote:
> >> On Sat, Aug 1, 2015 at 2:09 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> >>=20
> >> wrote:
> >> > On Thursday 25 December 2014 07:22:13 Robert Hancock wrote:
> >> >> On Tue, Dec 23, 2014 at 1:51 PM, Pali Roh=C3=A1r
> >> >> <pali.rohar@gmail.com>
> >> >>=20
> >> >> wrote:
> >> >> > Hello,
> >> >> >=20
> >> >> > I have nvidia nforce4 motherboard with nvidia sata
> >> >> > controller:
> >> >> >=20
> >> >> > 00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial
> >> >> > ATA Controller [10de:0054] (rev f3)
> >> >> > 00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial
> >> >> > ATA Controller [10de:0055] (rev f3)
> >> >> >=20
> >> >> > I manually enabled adma mode (which is disabled by default)
> >> >> > by adding sata_nv.adma=3D1 to grub cmdline. In git history I
> >> >> > found that enabling adma mode includes NCQ support and
> >> >> > reduced CPU overhead. It looks like adma mode is working,
> >> >> > but at every boot I see one same error message in dmesg:
> >> >> >=20
> >> >> > [   16.823514] ata1.00: exception Emask 0x1 SAct 0x0 SErr 0x0
> >> >> > action 0x0
> >> >> > [   16.823520] ata1.00: CPB resp_flags 0x11: , CMD error
> >> >> > [   16.823524] ata1.00: failed command: SET FEATURES
> >> >> > [   16.823530] ata1.00: cmd
> >> >> > ef/05:fe:00:00:00/00:00:00:00:00/40 tag 16
> >> >> > [   16.823530]          res
> >> >> > 51/04:fe:00:00:00/00:00:00:00:00/40 Emask 0x1 (device error)
> >> >> > [   16.823533] ata1.00: status: { DRDY ERR }
> >> >> > [   16.823535] ata1.00: error: { ABRT }
> >> >> >=20
> >> >> > When adma is disabled then this error message is not
> >> >> > generated.
> >> >>=20
> >> >> It looks like something is trying to issue a command to disable
> >> >> APM power management on the drive, and the command fails
> >> >> (likely because it doesn't support that command). I'm not sure
> >> >> where that would be coming from - I'm pretty sure the kernel
> >> >> doesn't issue that command itself. Something that's part of
> >> >> your distro perhaps?
> >> >>=20
> >> >> I don't know why it would only be failing in ADMA mode either,
> >> >> though depending on where the command is coming from, maybe
> >> >> it's not being issued otherwise for some reason?
> >> >>=20
> >> >> > What does that error message means? It is critical? What is
> >> >> > that command SET FEATURES doing? Are there any problems with
> >> >> > adma mode on nforce4 motherboards? Because I did not see any
> >> >> > problems (except that one error message).
> >> >> >=20
> >> >> > --
> >> >> > Pali Roh=C3=A1r
> >> >> > pali.rohar@gmail.com
> >> >=20
> >> > Hello,
> >> >=20
> >> > now after long time I did more investigation and that error is
> >> > reported for every connected HDD. I identified that it comes
> >> > from udev script
> >> >=20
> >> >  /lib/udev/rules.d/85-hdparm.rules
> >> >=20
> >> > which just call script /lib/udev/hdparm for every one connected
> >> > HDD.
> >> >=20
> >> > Script /lib/udev/hdparm just call:
> >> >  /sbin/hdparm -B254 $DRIVE
> >> >=20
> >> > And that -B254 cause above error message in dmesg log. Output
> >> > from
> >> >=20
> >> > hdparm is:
> >> >  /dev/sda:
> >> >   setting Advanced Power Management level to 0xfe (254)
> >> >   APM_level      =3D not supported
> >> >=20
> >> > Any idea why in ADMA mode it cause above error (APM unsupported)
> >> > and in non ADMA mode it is working fine? Maybe APM ATA commands
> >> > should not be sent via ADMA?
> >> >=20
> >> > Here is another output:
> >> >  $ sudo hdparm -I /dev/sda | grep -i power
> >> > =20
> >> >             *    Power Management feature set
> >> >            =20
> >> >                  Power-Up In Standby feature set
> >> >            =20
> >> >             *    SET_FEATURES required to spinup after power up
> >> >             *    Host-initiated interface power management
> >>=20
> >> The "set features" command is a non-data command so based on our
> >> current knowledge, it should work in ADMA mode. However, these
> >> NVIDIA SATAs are black boxes, and rather buggy ones at that, so
> >> it's possible there's an unknown issue there.
> >=20
> > Maybe I should note that hdparm -I did not generated any error
> > message. I post is here because it show "Power Management feature
> > set" is supported by HDD. This indicate that HDD supports -B (APM)
> > command, right?
>=20
> As far as I know, yes.
>=20
> >> The easiest way to test that would be to take out the condition
> >> check for qc->tf.protocol =3D=3D ATA_PROT_NODATA in
> >> nv_adma_use_reg_mode in drivers/ata/sata_nv.c. That would force
> >> it to disable ADMA for all non-data commands.
> >=20
> > Ok, as now I have just SSH access to that machine, I will do kernel
> > patching later (when I have physical access to it).
> >=20
> >> I really don't know why Ubuntu is disabling APM on all drives on
> >> bootup however. Especially for laptops, that seems like a silly
> >> thing to do explicitly. Sounds like one of the silly things
> >> Ubuntu is known to do without consulting people.
> >=20
> > Looks like this comes from upstream udev/systemd project :-(
> > Anyway, for laptops on battery ubuntu has another set of scripts
> > which turn on APM (based on connected/disconnected AC adapter).
>=20
> There's no such scripts in Fedora, so either they removed it, or it's
> something that either Debian or Ubuntu has added in.
>=20
> > That udev script which turn off APM is called when any disk is
> > attached to system (so at boot time it is called for every one
> > disk).
> >=20
> > Now I just masked that udev script and it is no longer called...
> >=20
> > Anyway if I call hdparm -B /dev/sda I get output:
> >=20
> > APM_level      =3D not supported
> >=20
> > And important is that there is no error message in dmesg. I get it
> > only if I call hdparm -B with parameter (set option). But APM
> > should be supported, right?
>=20
> Does the get command work without ADMA enabled?

I requested to boot that machine with turned off ADMA. I verified it is=20
turned off as I found sata_nv.adma=3D0 in /proc/cmdline and file=20
/sys/module/sata_nv/parameters/adma contains big N.

I called hdparm:

$ sudo hdparm -B254 /dev/sda

/dev/sda:
 setting Advanced Power Management level to 0xfe (254)
 HDIO_DRIVE_CMD failed: Input/output error
 APM_level      =3D not supported

It failed, but I do not see any error message in dmesg. There is nothing=20
new in dmesg.

So looks like I'm not able to set APM... But why in ADMA mode it=20
generates some error and in non ADMA mode no error? Strange!

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2526243.CHWLSQY06r
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlXA/0EACgkQi/DJPQPkQ1KUPACdFiEQjc234S7yCGGx3mkUMxAi
EBAAoLvrEdjOlqwUr4krZCAcXGiqAbGZ
=UQWb
-----END PGP SIGNATURE-----

--nextPart2526243.CHWLSQY06r--
