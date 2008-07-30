From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: fix endianity for the error message in
	cdrom_read_capacity
Date: Wed, 30 Jul 2008 21:12:57 +0200
Message-ID: <20080730191257.GA1205@gollum.tnic>
References: <1217405406.11834.11.camel@elijah.suse.cz> <20080730011832.0ee55d47.akpm@linux-foundation.org> <9ea470500807300152p5d5414aaq2d0d0053c12ef3f5@mail.gmail.com> <20080730163327.GA23086@suse.de>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:25033 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbYG3TMv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 15:12:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so94892fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 12:12:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080730163327.GA23086@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Jan Kara <jack@suse.cz>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, Jul 30, 2008 at 09:33:28AM -0700, Greg KH wrote:
> On Wed, Jul 30, 2008 at 10:52:50AM +0200, Boris Petkov wrote:
> > On Wed, Jul 30, 2008 at 10:18 AM, Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > > On Wed, 30 Jul 2008 10:10:06 +0200 Petr Tesarik <ptesarik@suse.cz=
> wrote:
> > >
> > >> Resent because of a typo in the LKML address. :(
> > >
> > > Thanks.
> > >
> > >>
> > >> Aesthetic regards aside, commit e8e7b9eb11c34ee18bde8b7011af4193=
8d1ad667
> > >> still leaves a bug in the error message, because it uses the unc=
onverted
> > >> big-endian value for printk.
> > >>
> > >> Fix this by using a local variable in machine byte order. The re=
sult is
> > >> correct, more readable, and also produces slightly shorter code =
on i386.
> > >>
> > >> Cc: Jens Axboe <jens.axboe@oracle.com>
> > >> Cc: Jan Kara <jack@suse.cz>
> > >> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> >=20
> > I definitely like this one better, thanks.
> >=20
> > Acked-by: Borislav Petkov <petkovbb@gmail.com>
> >=20
> >=20
> > >
> > > Bart owns this patch now.  It got lost for a month and it has alr=
eady
> > > been fixed twice and it is also on the route to 2.6.25.x and 2.6.=
26.x,
> > > so it'll get complicated.  Not a happy little patch.
> >=20
> > Greg, can you please apply this one on top of -stable.
>=20
> What one?  Do you have a git commit id?

Oh, sorry about that. Ok, you should have in both 2.6.25 and .26 the pa=
tch with
upstream commit id e8e7b9eb11c34ee18bde8b7011af41938d1ad667. I rediffed=
 the new
one on top, here's the 2.6.26 version, the 2.6.25 one follows.

--
=46rom: Petr Tesarik <ptesarik@suse.cz>

Aesthetic regards aside, commit e8e7b9eb11c34ee18bde8b7011af41938d1ad66=
7
still leaves a bug in the error message, because it uses the unconverte=
d
big-endian value for printk.

=46ix this by using a local variable in machine byte order. The result =
is
correct, more readable, and also produces slightly shorter code on i386=
=2E

Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
Acked-by: Borislav Petkov <petkovbb@gmail.com>
---
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 0cc854e..59875bb 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1298,6 +1298,7 @@ static int cdrom_read_capacity(ide_drive_t *drive=
, unsigned long *capacity,
=20
 	int stat;
 	struct request req;
+	__u32 blocklen;
=20
 	ide_cd_init_rq(drive, &req);
=20
@@ -1314,23 +1315,24 @@ static int cdrom_read_capacity(ide_drive_t *dri=
ve, unsigned long *capacity,
 	/*
 	 * Sanity check the given block size
 	 */
-	switch (capbuf.blocklen) {
-	case __constant_cpu_to_be32(512):
-	case __constant_cpu_to_be32(1024):
-	case __constant_cpu_to_be32(2048):
-	case __constant_cpu_to_be32(4096):
+	blocklen =3D be32_to_cpu(capbuf.blocklen);
+	switch (blocklen) {
+	case 512:
+	case 1024:
+	case 2048:
+	case 4096:
 		break;
 	default:
 		printk(KERN_ERR "%s: weird block size %u\n",
-			drive->name, capbuf.blocklen);
+			drive->name, blocklen);
 		printk(KERN_ERR "%s: default to 2kb block size\n",
 			drive->name);
-		capbuf.blocklen =3D __constant_cpu_to_be32(2048);
+		blocklen =3D 2048;
 		break;
 	}
=20
 	*capacity =3D 1 + be32_to_cpu(capbuf.lba);
-	*sectors_per_frame =3D be32_to_cpu(capbuf.blocklen) >> SECTOR_BITS;
+	*sectors_per_frame =3D blocklen >> SECTOR_BITS;
 	return 0;
 }
=20


--=20
Regards/Gru=DF,
    Boris.
