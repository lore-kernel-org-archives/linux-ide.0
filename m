From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-tape: Don't leak kernel stack information
Date: Tue, 21 Jul 2009 14:10:10 +0200
Message-ID: <200907211410.11262.bzolnier@gmail.com>
References: <200907192115.19958.mb@bu3sch.de> <200907211206.55708.bzolnier@gmail.com> <9ea470500907200345y79911526m15106c755a15b697@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:48290 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZGTMOg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jul 2009 08:14:36 -0400
Received: by fxm18 with SMTP id 18so1921130fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2009 05:14:34 -0700 (PDT)
In-Reply-To: <9ea470500907200345y79911526m15106c755a15b697@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: Michael Buesch <mb@bu3sch.de>, davem@davemloft.net, linux-ide@vger.kernel.org

On Monday 20 July 2009 12:45:37 Borislav Petkov wrote:
> On Tue, Jul 21, 2009 at 12:06 PM, Bartlomiej
> Zolnierkiewicz<bzolnier@gmail.com> wrote:
> > On Monday 20 July 2009 09:38:14 Borislav Petkov wrote:
> >> On Sun, Jul 19, 2009 at 09:15:19PM +0200, Michael Buesch wrote:
> >> > Don't leak kernel stack information through uninitialized struct=
ure members.
> >> >
> >> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> >> > Cc: stable@kernel.org
> >> >
> >> > ---
> >> >
> >> > This patch is only compile tested.
> >> >
> >> > ---
> >> >  drivers/ide/ide-tape.c |    1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > --- linux-2.6.orig/drivers/ide/ide-tape.c
> >> > +++ linux-2.6/drivers/ide/ide-tape.c
> >> > @@ -1057,20 +1057,21 @@ static int idetape_blkdev_ioctl(ide_driv
> >> >
> >> >     debug_log(DBG_PROCS, "Enter %s\n", __func__);
> >> >
> >> >     switch (cmd) {
> >> >     case 0x0340:
> >> >             if (copy_from_user(&config, argp, sizeof(config)))
> >> >                     return -EFAULT;
> >> >             tape->best_dsc_rw_freq =3D config.dsc_rw_frequency;
> >> >             break;
> >> >     case 0x0350:
> >> > +           memset(&config, 0, sizeof(config));
> >>
> >> Well, I can't find config.dsc_media_access_frequency as being used
> >> anywhere since the git years of the kernel. I found=B9 some archai=
c
> >> kernels from 1995 (1.3 series) which used to have IDETAPE_RESET_IO=
CTL
> >> defined as 0x0350 but can't seem to find any userspace use of that
> >> ioctl.
> >>
> >> If there's none, you might just as well remove
> >> config.dsc_media_access_frequency as an alternative solution.
> >>
> >> @Bart: Any historic info I'm missing here?
> >
> > We need to preserve struct idetape_config layout to not break the i=
octl
> > (regardless if the field is really used by some user-space apps or =
not)..
>=20
> I know that. However, I can't seem to find any definition of that
> ioctl, ioctl_list(2) manpage doesn't document it, so my question was
> whether there is an agreed-upon definition of that ioctl and of struc=
t
> config at all. If not, we could simply remove that variable since the
> struct layout is simply arbitrary in that case. Especially if there's

It is not, user-space (theoretically) depends on the current layout
(we copy_to_user() the _whole_ structure).

> no corresponing driver functionality on the kernel side which makes
> config.dsc_media_access_frequency the more useless.

We don't do arbitrary changes to existing ioctls.

Either it stays the way it is or we may eventually remove it completely
(if really nothing uses it, though I still don't see much point in it
given "the deep maintenance" mode of IDE subsystem).
