From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 02 Aug 2005 13:10:00 +0200
Message-ID: <42EF5488.9020802@imc-berlin.de>
References: <42EA1AB0.6070001@imc-berlin.de> <42EF439C.5000903@imc-berlin.de> <20050802104859.GG22569@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:56072 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S261495AbVHBLKE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2005 07:10:04 -0400
In-Reply-To: <20050802104859.GG22569@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org

Jens Axboe wrote:

> That's not quite true, q is not invalid after this call. It will only=
 be
> invalid when it is freed (which doesn't happen from here but rather f=
rom
> the blk_cleanup_queue() call when the reference count drops to 0).
>=20
> This is still not perfect, but a lot better. Does it work for you?
>=20
> --- linux-2.6.12/drivers/ide/ide-disk.c~	2005-08-02 12:48:16.00000000=
0 +0200
> +++ linux-2.6.12/drivers/ide/ide-disk.c	2005-08-02 12:48:32.000000000=
 +0200
> @@ -1054,6 +1054,7 @@
>  	drive->driver_data =3D NULL;
>  	drive->devfs_name[0] =3D '\0';
>  	g->private_data =3D NULL;
> +	g->disk =3D NULL;
>  	put_disk(g);
>  	kfree(idkp);
>  }

No.
drivers/ide/ide-disk.c: In function `ide_disk_release':
drivers/ide/ide-disk.c:1057: error: structure has no member named `disk=
'

--
Steven




--=20
Steven Scholz

imc Measurement & Control               imc Me=DFsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland
