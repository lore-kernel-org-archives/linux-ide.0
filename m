From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] Proper initialization of rc in drivers/ide/ide-probe.c
Date: Sat, 26 Jul 2008 10:45:31 +0200
Message-ID: <20080726084531.GB18223@gollum.tnic>
References: <b9df5fa10807251054i5bd1d309g93a23ba405fc15b9@mail.gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:18177 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbYGZIpR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 04:45:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1800299fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 26 Jul 2008 01:45:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b9df5fa10807251054i5bd1d309g93a23ba405fc15b9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rakib Mullick <rakib.mullick@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Fri, Jul 25, 2008 at 11:54:17PM +0600, Rakib Mullick wrote:
> Hello to all , In existing code, rc might remain uninitialized.
Hi,

are you sure? device_create_file() does return a proper value at all ti=
mes:
either a 0 or the result from calling sysfs_create_file(), and, if you =
follow
the last's call chain into the sysfs-internals you can easily see that =
those
functions also return proper value at all times. What is more, it is gu=
aranteed
that the loop will execute since ide_port_attrs is statically initializ=
ed
and has 2 elements... so no need for initializing the rc-variable - it =
gets
overwritten in any case.

However, i'm sure you can find some other places in the kernel where th=
e return
value is not set appropriately, leading to really nasty bugs :(.

> This patch initializes rc properly.
>=20
> Signed-off-by: Md.Rakib Hassan Mullick ( rakib.mullick@gmail.com)
>=20
> --- drivers/ide/ide-probe.c.orig	2008-07-25 23:33:22.000000000 +0600
> +++ drivers/ide/ide-probe.c	2008-07-25 23:35:00.000000000 +0600
> @@ -1437,7 +1437,7 @@ static struct device_attribute *ide_port
>=20
>  static int ide_sysfs_register_port(ide_hwif_t *hwif)
>  {
> -	int i, rc;
> +	int i, rc =3D 0;
>=20
>  	for (i =3D 0; ide_port_attrs[i]; i++) {
>  		rc =3D device_create_file(hwif->portdev, ide_port_attrs[i]);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Regards/Gru=DF,
    Boris.
