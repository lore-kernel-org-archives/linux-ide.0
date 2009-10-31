From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [Bugme-new] [Bug 14518] New: I/O appears to get stuck on certain rsync backup job and system clock halts then
Date: Sat, 31 Oct 2009 08:31:09 +0100
Message-ID: <200910310831.09443.Martin@lichtvoll.de>
References: <bug-14518-10286@http.bugzilla.kernel.org/> <20091031001711.0d3a8238.akpm@linux-foundation.org> (sfid-20091031_081829_549039_184645EF)
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1731266.aPPZLdJWad";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:59952 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbZJaHbG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Oct 2009 03:31:06 -0400
In-Reply-To: <20091031001711.0d3a8238.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@elte.hu>

--nextPart1731266.aPPZLdJWad
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

Okay, I missed these as well:

shambhala:/etc> grep -A 3 "Sched" sysctl.conf
# Scheduler-Tuning
kernel.sched_latency_ns =3D 5000000
kernel.sched_min_granularity_ns =3D 100000
kernel.sched_wakeup_granularity_ns =3D 100000

Its confusing that some scheduler settings are in /sys and some are in=20
/proc ;).

Ingo, might these have an impact on the issues seen? I can undo them.

Ciao,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart1731266.aPPZLdJWad
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkrr570ACgkQmRvqrKWZhMcZgACfUr0caYFQYWLs6WuIG9HOjuTm
b6oAn3Mfel4YZGYfTKral4nqd7OLC7m+
=O0JT
-----END PGP SIGNATURE-----

--nextPart1731266.aPPZLdJWad--
