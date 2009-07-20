From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-tape: Don't leak kernel stack information
Date: Mon, 20 Jul 2009 09:38:14 +0200
Message-ID: <20090720073813.GA27834@liondog.tnic>
References: <200907192115.19958.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:61715 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbZGTHiT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jul 2009 03:38:19 -0400
Received: by bwz28 with SMTP id 28so1793195bwz.37
        for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2009 00:38:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200907192115.19958.mb@bu3sch.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: davem@davemloft.net, linux-ide@vger.kernel.org

On Sun, Jul 19, 2009 at 09:15:19PM +0200, Michael Buesch wrote:
> Don't leak kernel stack information through uninitialized structure m=
embers.
>=20
> Signed-off-by: Michael Buesch <mb@bu3sch.de>
> Cc: stable@kernel.org
>=20
> ---
>=20
> This patch is only compile tested.
>=20
> ---
>  drivers/ide/ide-tape.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> --- linux-2.6.orig/drivers/ide/ide-tape.c
> +++ linux-2.6/drivers/ide/ide-tape.c
> @@ -1057,20 +1057,21 @@ static int idetape_blkdev_ioctl(ide_driv
> =20
>  	debug_log(DBG_PROCS, "Enter %s\n", __func__);
> =20
>  	switch (cmd) {
>  	case 0x0340:
>  		if (copy_from_user(&config, argp, sizeof(config)))
>  			return -EFAULT;
>  		tape->best_dsc_rw_freq =3D config.dsc_rw_frequency;
>  		break;
>  	case 0x0350:
> +		memset(&config, 0, sizeof(config));

Well, I can't find config.dsc_media_access_frequency as being used
anywhere since the git years of the kernel. I found=C2=B9 some archaic
kernels from 1995 (1.3 series) which used to have IDETAPE_RESET_IOCTL
defined as 0x0350 but can't seem to find any userspace use of that
ioctl.

If there's none, you might just as well remove
config.dsc_media_access_frequency as an alternative solution.

@Bart: Any historic info I'm missing here?


=C2=B9http://www.google.com/search?q=3DIDETAPE_RESET_IOCTL

--=20
Regards/Gruss,
    Boris.
