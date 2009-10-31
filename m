From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [Bugme-new] [Bug 14518] New: I/O appears to get stuck on certain rsync backup job and system clock halts then
Date: Sat, 31 Oct 2009 08:27:34 +0100
Message-ID: <200910310827.46834.Martin@lichtvoll.de>
References: <bug-14518-10286@http.bugzilla.kernel.org/> <20091031001711.0d3a8238.akpm@linux-foundation.org> (sfid-20091031_081829_549039_184645EF)
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1726637.z44GsPyj8z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:50616 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbZJaH1o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Oct 2009 03:27:44 -0400
In-Reply-To: <20091031001711.0d3a8238.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@elte.hu>

--nextPart1726637.z44GsPyj8z
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Samstag 31 Oktober 2009 schrieb Andrew Morton:
> (switched to email.  Please respond via emailed reply-to-all, not via
>  the bugzilla web interface).
>=20
> On Sat, 31 Oct 2009 06:59:07 GMT bugzilla-daemon@bugzilla.kernel.org=20
wrote:
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D14518
> >
> >            Summary: I/O appears to get stuck on certain rsync backup
> > job and system clock halts then
> >            Product: IO/Storage
> >            Version: 2.5
> >     Kernel Version: 2.6.31.5
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Block Layer
> >         AssignedTo: axboe@kernel.dk
> >         ReportedBy: Martin@Lichtvoll.de
> >         Regression: Yes
> >
> >
> > I sorted this to generic block problems, might be an issue with the
> > sata_sil driver tough.
>=20
> Yup, it looks more like an ata issue.
>=20
> Or it might be that the errors are due to real hardware problems and
> triggered not-well-tested code paths in block/scsi/VFS/etc.
>=20
> Could someone take a look please?

I think I better add one information about a special tuning I applied to=20
CFS. CC'ing Ingo Molnar for feedback on that one:

shambhala:~> tail -2 /etc/sysfs.conf
# Scheduler-Tuning
kernel/debug/sched_features =3D NO_NEW_FAIR_SLEEPERS

I am not sure whether this could interfere with the workload I described.

I believed I had some more settings in /etc/sysfs.conf, but apparently to=20
due an editing error on this one has been left.

The idea for is that coming from a scheduler tuning thread that originated=
=20
from the initial Brain Fuck Scheduler posting by Con Koliva.

AFAIK NO_NEW_FAIR_SLEEPERS is disabled on current 2.6.32-rc kernels as=20
well.

Ingo might that be a contribution to the issues seen here?

Ciao,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart1726637.z44GsPyj8z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkrr5ucACgkQmRvqrKWZhMfkbACcCk1q6A+aEhYJFm1GabAzd+rc
Qm4AoIBlmxNTq9TwN9OJOe6r8n7+CtUW
=DDb3
-----END PGP SIGNATURE-----

--nextPart1726637.z44GsPyj8z--
