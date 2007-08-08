From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: [SOLVED] problems while mounting /boot partition
Date: Wed, 08 Aug 2007 14:18:16 -0400
Message-ID: <1186597096.6259.22.camel@pc.ilinx>
References: <1186504459.6949.40.camel@pc.ilinx>
	 <46B9EF1D.4010907@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-N3wVdtNzK3vUEvd7wAZ6"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937955AbXHHSSd@vger.kernel.org>
In-Reply-To: <46B9EF1D.4010907@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--=-N3wVdtNzK3vUEvd7wAZ6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-08-08 at 18:28 +0200, Michal Piotrowski wrote:
> Hi Brian,

Hi Michal,

> Brian J. Murrell pisze:
> > I am using Ubuntu Gutsy, which is the in-development branch heading for
> > their next stable release.
>=20
> You forgot about message subject, so no one has read this report.

Indeed.  Very unfortunate.  I did re-post with a subject but I have not
seen it show up yet, which I have been waiting for to post the solution.

Maybe I will just do that here and again if it shows up with the subject
posted.

The crux of the problem is that the real partitions are being
mapped/managed by device mapper, which is being used by LVM:

$ ls -l /dev/mapper/
total 0
crw-rw---- 1 root root 10, 63 2007-08-08 04:56 control
lrwxrwxrwx 1 root root      7 2007-08-08 04:56 hda1 -> ../dm-0
lrwxrwxrwx 1 root root      7 2007-08-08 04:56 hda2 -> ../dm-1
lrwxrwxrwx 1 root root      7 2007-08-08 04:56 hda3 -> ../dm-2

This is of course causing those partitions to be opened exclusively,
preventing any further uses (i.e. sys_mount()) from being able to use
them.  Only hda3 of those above is actually an LVM PV.  hda1 is an ext3
filesystem (/boot) and hda2 is a FAT32 (could even be FAT16) filesystem.

Of course, mounting /dev/dm-0 instead of /dev/hda1 solves the problem.

Why this started with Ubuntu's 2.6.22 kernel in Gutsy, I'm not sure.
Whether it's a new DM feature or some change in the way Ubuntu handles
devices, I don't know.  Whatever the case, they need to fix
their /dev/disk/by-uuid mappings anyway:

$ ls -l /dev/disk/by-uuid/ | grep hda
lrwxrwxrwx 1 root root 10 2007-08-08 08:56 12b8250a-d031-4ee1-b486-5e67478d=
06b4 -> ../../hda1

Cheers,
b.

--=20
A day in the yard with my son is just like a day at work.  He goes
hunting around for stuff and brings it back to me and says: "Hey Dad,
look what I found.  The money is for me and the screw is for you."

--=-N3wVdtNzK3vUEvd7wAZ6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGugjol3EQlGLyuXARAkg2AKC9mhfJlDKqmdbxT3DPuZwd7DRsswCg5nrL
+0fg0jasartopv6a936FsXM=
=7E4D
-----END PGP SIGNATURE-----

--=-N3wVdtNzK3vUEvd7wAZ6--
