From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: WARNINGs because of ide-proc handling
Date: Thu, 2 Sep 2010 23:28:39 +0200
Message-ID: <20100902212839.GA20070@pengutronix.de>
References: <20100831205605.GA23636@pengutronix.de> <20100901.193332.77341159.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36611 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab0IBV2k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Sep 2010 17:28:40 -0400
Content-Disposition: inline
In-Reply-To: <20100901.193332.77341159.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2010 at 07:33:32PM -0700, David Miller wrote:

Adding Bartlomiej to CC, maybe he has something to add :)

> From: Wolfram Sang <w.sang@pengutronix.de>
> Date: Tue, 31 Aug 2010 22:56:05 +0200
>=20
> > Hello,
> >=20
> > I get the following warning (and some similar ones) on my laptop running
> > 2.6.36-rc3 when removing a CF card via pcmcia:
> >=20
> > [ 1087.602129] WARNING: at fs/proc/generic.c:816 remove_proc_entry+0x18=
5/0x1d0()
> > [ 1087.602137] Hardware name: Amilo M14255
> > [ 1087.602142] name 'cache'
> > ...
> >=20
> > It turned out that none of the entries in ide_disk_proc[] gets created =
when
> > inserting the card, so trying to remove them triggers this warning. Add=
ing
> > some debug printouts
>=20
> Hmmm, at some point ide_host_add() or ide_host_register() should be invok=
ed,
> which should create the drive->proc and hwif->proc PROCFS directories.
>=20
> What driver is your pcmcia IDE card using?

ide-cs.

I did some more debugging and have a function_graph-trace which proves the
following callchain:

ide_host_add -> ... -> ide_host_register

This calls _first_ hwif_register_devices() and only _later_
ide_proc_register_port() and ide_proc_port_register_devices() which are
responsible for creating the needed directories. In hwif_register_devices()=
, a
device gets created and immediately attached to the driver, ide-gd in this
case. The probe-function calls disk_ops->setup() which wants to create the
proc-entries, but the directories are not there yet. This patch helps,
combining two loops and moving hwif_register_devices() to the end:

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 4c3d1bf..068cef0 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1448,19 +1448,13 @@ int ide_host_register(struct ide_host *host, const =
struct ide_port_info *d,
 		if (hwif =3D=3D NULL)
 			continue;
=20
-		if (hwif->present)
-			hwif_register_devices(hwif);
-	}
-
-	ide_host_for_each_port(i, hwif, host) {
-		if (hwif =3D=3D NULL)
-			continue;
-
 		ide_sysfs_register_port(hwif);
 		ide_proc_register_port(hwif);
=20
-		if (hwif->present)
+		if (hwif->present) {
 			ide_proc_port_register_devices(hwif);
+			hwif_register_devices(hwif);
+		}
 	}
=20
 	return j ? 0 : -1;

Dunno, if it is correct, though. The strange thing is that the code is like
this for two years and, surprisingly, I don't see the problem with 2.6.33.
Also, the proc-entry for my hard-disk is fine. I can't see any suspicious
commits in the ide-directory except maybe the BKL pushdown had a side-effect
regarding the serialization of the sequence? Ah, too late today to seriously
think about such issues...

Thanks for the input,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyAFwcACgkQD27XaX1/VRtl+gCdEU1u9dc7lksP3TZW1ur1srlT
ndYAoLrexjqviviGgrTFHw11+EkIc1Lo
=7egH
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
