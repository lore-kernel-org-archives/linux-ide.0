From: Martin =?ISO-8859-1?Q?Ammerm=FCller?= <tenco@gmx.de>
Subject: Re: [sata_sil] kernel 2.6.17(-mm2) test - timeout issue
Date: Mon, 14 Aug 2006 12:12:00 +0200
Message-ID: <1155550320.6423.2.camel@localhost>
References: <1151182247.5566.18.camel@localhost>
	 <449DFDC4.5050207@gmail.com> <1153729271.3860.14.camel@localhost>
	 <44CD1512.1060802@gmail.com> <1154785005.9220.1.camel@localhost>
	 <44D61004.3070109@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EwrCmgTe0k/IjhlYixVz"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:41882 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932227AbWHNKL5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Aug 2006 06:11:57 -0400
In-Reply-To: <44D61004.3070109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com


--=-EwrCmgTe0k/IjhlYixVz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Montag, den 07.08.2006, 00:51 +0900 schrieb Tejun Heo:=20
> I'm not sure why the previous patch didn't kick in.  The condition=20
> should have been caught and EH_HARDRESET requested.  Can you please=20
> double check the patched kernel is running?  You can put a little=20
> printk() after the freeze: label in sil_interrupt() to be sure.  That's=20
> the only place where sata_sil freezes the port except for timing out.

Sorry, i couldn't find a "freeze" label in sil_interrupt(). There's one
in sil_host_intr(), but appending 'printk("THIS VERSION RUNS MODIFIED
sata_sil!");' there, doesn't have any effect (it doesn't get printed
out). That's the only freeze label i found in sata_sil.c. My original
drivers/scsi/sata_sil.c was version 2.6.18-rc1.

'strings /lib/modules/2.6.18-rc1/kernel/drivers/scsi/sata_sil.ko'
doesn't give any unexpected results:

----------------------
[...]
<7>%s %s: version 2.0
<3>ata%u: XXX: qc=3D%p ctl=3D%x
<3>ata%u: XXX: HSM=3D%d
<6>ata%u.%02u: applying Seagate errata fix (mod15write workaround)
<6>ata%u.%02u: applying Maxtor errata fix %s
<4>%s %s: cache line size not set.  Driver may not function
<6>%s %s: Applying R_ERR on DMA activate FIS errata fix
<3>ata%u: XXX: SATA_IRQ serror=3D%x
<3>ata%u: XXX: BUSY status=3D%x
THIS VERSION RUNS MODIFIED sata_sil!
[...]
------------------------

The kernel was built with Debian's make-kpkg (make-kpkg --initrd
kernel_image). Output is still the same.

- Martin

--=-EwrCmgTe0k/IjhlYixVz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE4ExvFjFZ/qjkvZARArUMAJ40kM0pTaL00x9JkaypXnM5MIcEYACfQBe1
hYKaPntLkhFrZ1eqC0a8yAQ=
=ugG7
-----END PGP SIGNATURE-----

--=-EwrCmgTe0k/IjhlYixVz--

