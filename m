From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE updates part #4
Date: Wed, 6 Feb 2008 01:48:17 +0100
Message-ID: <200802060148.17663.bzolnier@gmail.com>
References: <200802022035.02326.bzolnier@gmail.com> <alpine.LFD.1.00.0802051059330.3110@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:45464 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760613AbYBFAfh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 19:35:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so167062wah.23
        for <linux-ide@vger.kernel.org>; Tue, 05 Feb 2008 16:35:34 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802051059330.3110@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Linus,

On Tuesday 05 February 2008, Linus Torvalds wrote:
>=20
> On Sat, 2 Feb 2008, Bartlomiej Zolnierkiewicz wrote:
> >=20
> > * next part of IDE probing code re-organization saga
> >   (that would be me)
>=20
> This seems to cause very irritating and bogus messages for me:
>=20
> 	Probing IDE interface ide0...
> 	Probing IDE interface ide1...
> 	ide2: I/O resource 0x0-0x7 not free.
> 	ide2: ports already in use, skipping probe
> 	ide3: I/O resource 0x0-0x7 not free.
> 	ide3: ports already in use, skipping probe
> 	ide4: I/O resource 0x0-0x7 not free.
> 	ide4: ports already in use, skipping probe
> 	ide5: I/O resource 0x0-0x7 not free.
> 	ide5: ports already in use, skipping probe
> 	ide6: I/O resource 0x0-0x7 not free.
> 	ide6: ports already in use, skipping probe
> 	ide7: I/O resource 0x0-0x7 not free.
> 	ide7: ports already in use, skipping probe
> 	ide8: I/O resource 0x0-0x7 not free.
> 	ide8: ports already in use, skipping probe
> 	ide9: I/O resource 0x0-0x7 not free.
> 	ide9: ports already in use, skipping probe
>=20
> and that's just totally bogus. It shouldn't even request that region,=
=20
> since it's not been allocated!
>=20
> So that "ide_device_add_all()" is missing some checks. Should it chec=
k the=20
> probe[] array like ideprobe_init() used to, or what?

This is ide-generic problem exhibited by recent ide_device_add_all() ch=
anges.
=46ix below (it works for me) - you may merge the patch as it is or wai=
t an hour
or so for the next IDE tree pull request.

Also sorry for the issue in the first place (it turned out that it slip=
ped
my testing because I has been running with IDE_MAX_HWIFS=3D2 for some t=
ime :).


=46rom: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-generic: probing bugfix

On Tuesday 05 February 2008, Linus Torvalds wrote:
>=20
> On Sat, 2 Feb 2008, Bartlomiej Zolnierkiewicz wrote:
> >=20
> > * next part of IDE probing code re-organization saga
> > =A0 (that would be me)
>=20
> This seems to cause very irritating and bogus messages for me:
>=20
> =A0=A0=A0=A0=A0=A0Probing IDE interface ide0...
> =A0=A0=A0=A0=A0=A0Probing IDE interface ide1...
> =A0=A0=A0=A0=A0=A0ide2: I/O resource 0x0-0x7 not free.
> =A0=A0=A0=A0=A0=A0ide2: ports already in use, skipping probe
> =A0=A0=A0=A0=A0=A0ide3: I/O resource 0x0-0x7 not free.
> =A0=A0=A0=A0=A0=A0ide3: ports already in use, skipping probe
> =A0=A0=A0=A0=A0=A0ide4: I/O resource 0x0-0x7 not free.
> =A0=A0=A0=A0=A0=A0ide4: ports already in use, skipping probe
> =A0=A0=A0=A0=A0=A0ide5: I/O resource 0x0-0x7 not free.
> =A0=A0=A0=A0=A0=A0ide5: ports already in use, skipping probe
> =A0=A0=A0=A0=A0=A0ide6: I/O resource 0x0-0x7 not free.
> =A0=A0=A0=A0=A0=A0ide6: ports already in use, skipping probe
> =A0=A0=A0=A0=A0=A0ide7: I/O resource 0x0-0x7 not free.
> =A0=A0=A0=A0=A0=A0ide7: ports already in use, skipping probe
> =A0=A0=A0=A0=A0=A0ide8: I/O resource 0x0-0x7 not free.
> =A0=A0=A0=A0=A0=A0ide8: ports already in use, skipping probe
> =A0=A0=A0=A0=A0=A0ide9: I/O resource 0x0-0x7 not free.
> =A0=A0=A0=A0=A0=A0ide9: ports already in use, skipping probe
>=20
> and that's just totally bogus. It shouldn't even request that region,=
=20
> since it's not been allocated!

The commit 139ddfcab50e5eabcc88341c8743a990ac1be6a2 ("ide: move handlin=
g of
I/O resources out of ide_probe_port()") changed the ordering of hwif->n=
oprobe
check vs ide_hwif_request_regions() call (so that we now reserve I/O re=
gions
before checking for hwif->noprobe).  However ide-generic host driver de=
pended
on hwif->noprobe to be set for skipping probing of empty ide_hwifs[] sl=
ots.

=46ix it by passing only indexes of non-empty slots to ide_device_add_a=
ll()
from ide_generic_init().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-generic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -20,8 +20,14 @@ static int __init ide_generic_init(void)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_get_lock(NULL, NULL); /* for atari only */
=20
-	for (i =3D 0; i < MAX_HWIFS; i++)
-		idx[i] =3D ide_hwifs[i].present ? 0xff : i;
+	for (i =3D 0; i < MAX_HWIFS; i++) {
+		ide_hwif_t *hwif =3D &ide_hwifs[i];
+
+		if (hwif->io_ports[IDE_DATA_OFFSET] && !hwif->present)
+			idx[i] =3D i;
+		else
+			idx[i] =3D 0xff;
+	}
=20
 	ide_device_add_all(idx, NULL);
=20
