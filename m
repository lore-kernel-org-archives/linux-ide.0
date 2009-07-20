From: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH] ide-tape: Don't leak kernel stack information
Date: Mon, 20 Jul 2009 12:57:45 +0200
Message-ID: <200907201257.46158.mb@bu3sch.de>
References: <200907192115.19958.mb@bu3sch.de> <20090720073813.GA27834@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bu3sch.de ([62.75.166.246]:54919 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbZGTK5r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jul 2009 06:57:47 -0400
In-Reply-To: <20090720073813.GA27834@liondog.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: davem@davemloft.net, linux-ide@vger.kernel.org

On Monday 20 July 2009 09:38:14 Borislav Petkov wrote:
> On Sun, Jul 19, 2009 at 09:15:19PM +0200, Michael Buesch wrote:
> > Don't leak kernel stack information through uninitialized structure=
 members.
> >=20
> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> > Cc: stable@kernel.org
> >=20
> > ---
> >=20
> > This patch is only compile tested.
> >=20
> > ---
> >  drivers/ide/ide-tape.c |    1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > --- linux-2.6.orig/drivers/ide/ide-tape.c
> > +++ linux-2.6/drivers/ide/ide-tape.c
> > @@ -1057,20 +1057,21 @@ static int idetape_blkdev_ioctl(ide_driv
> > =20
> >  	debug_log(DBG_PROCS, "Enter %s\n", __func__);
> > =20
> >  	switch (cmd) {
> >  	case 0x0340:
> >  		if (copy_from_user(&config, argp, sizeof(config)))
> >  			return -EFAULT;
> >  		tape->best_dsc_rw_freq =3D config.dsc_rw_frequency;
> >  		break;
> >  	case 0x0350:
> > +		memset(&config, 0, sizeof(config));
>=20
> Well, I can't find config.dsc_media_access_frequency as being used
> anywhere since the git years of the kernel. I found=C2=B9 some archai=
c
> kernels from 1995 (1.3 series) which used to have IDETAPE_RESET_IOCTL
> defined as 0x0350 but can't seem to find any userspace use of that
> ioctl.
>=20
> If there's none, you might just as well remove
> config.dsc_media_access_frequency as an alternative solution.
>=20
> @Bart: Any historic info I'm missing here?
>=20
>=20
> =C2=B9http://www.google.com/search?q=3DIDETAPE_RESET_IOCTL
>=20

Well, I don't feel so good changing the ABI of ancient drivers. So
I think it's best to just fix the bug (zero out the struct) instead of =
removing
the whole call. Who knows. Maybe some proprietary program in the depths=
 of some
corporation's servers uses this ioctl...

So let's just zero out the structure properly to avoid the possibility =
of leaking
kernel stack information.

--=20
Greetings, Michael.
