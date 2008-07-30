From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: fix endianity for the error message in
	cdrom_read_capacity
Date: Wed, 30 Jul 2008 21:27:13 +0200
Message-ID: <20080730192713.GA4836@gollum.tnic>
References: <1217405406.11834.11.camel@elijah.suse.cz> <20080730011832.0ee55d47.akpm@linux-foundation.org> <9ea470500807300152p5d5414aaq2d0d0053c12ef3f5@mail.gmail.com> <20080730163327.GA23086@suse.de>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:28790 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbYG3T1G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 15:27:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so98066fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 12:27:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080730163327.GA23086@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Jan Kara <jack@suse.cz>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

=2E.. and here the rediffed one for 2.6.25.y:

---
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
index e54da02..3b388ca 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1411,6 +1411,7 @@ static int cdrom_read_capacity(ide_drive_t *drive=
, unsigned long *capacity,
=20
 	int stat;
 	struct request req;
+	__u32 blocklen;
=20
 	ide_cd_init_rq(drive, &req);
=20
@@ -1427,23 +1428,24 @@ static int cdrom_read_capacity(ide_drive_t *dri=
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
