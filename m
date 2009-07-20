From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-tape: Don't leak kernel stack information
Date: Mon, 20 Jul 2009 12:45:37 +0200
Message-ID: <9ea470500907200345y79911526m15106c755a15b697@mail.gmail.com>
References: <200907192115.19958.mb@bu3sch.de>
	 <20090720073813.GA27834@liondog.tnic>
	 <200907211206.55708.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42434 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbZGTKpi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jul 2009 06:45:38 -0400
Received: by fxm18 with SMTP id 18so1877155fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2009 03:45:37 -0700 (PDT)
In-Reply-To: <200907211206.55708.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Michael Buesch <mb@bu3sch.de>, davem@davemloft.net, linux-ide@vger.kernel.org

On Tue, Jul 21, 2009 at 12:06 PM, Bartlomiej
Zolnierkiewicz<bzolnier@gmail.com> wrote:
> On Monday 20 July 2009 09:38:14 Borislav Petkov wrote:
>> On Sun, Jul 19, 2009 at 09:15:19PM +0200, Michael Buesch wrote:
>> > Don't leak kernel stack information through uninitialized structur=
e members.
>> >
>> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
>> > Cc: stable@kernel.org
>> >
>> > ---
>> >
>> > This patch is only compile tested.
>> >
>> > ---
>> > =A0drivers/ide/ide-tape.c | =A0 =A01 +
>> > =A01 file changed, 1 insertion(+)
>> >
>> > --- linux-2.6.orig/drivers/ide/ide-tape.c
>> > +++ linux-2.6/drivers/ide/ide-tape.c
>> > @@ -1057,20 +1057,21 @@ static int idetape_blkdev_ioctl(ide_driv
>> >
>> > =A0 =A0 debug_log(DBG_PROCS, "Enter %s\n", __func__);
>> >
>> > =A0 =A0 switch (cmd) {
>> > =A0 =A0 case 0x0340:
>> > =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(&config, argp, sizeof(c=
onfig)))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> > =A0 =A0 =A0 =A0 =A0 =A0 tape->best_dsc_rw_freq =3D config.dsc_rw_f=
requency;
>> > =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > =A0 =A0 case 0x0350:
>> > + =A0 =A0 =A0 =A0 =A0 memset(&config, 0, sizeof(config));
>>
>> Well, I can't find config.dsc_media_access_frequency as being used
>> anywhere since the git years of the kernel. I found=B9 some archaic
>> kernels from 1995 (1.3 series) which used to have IDETAPE_RESET_IOCT=
L
>> defined as 0x0350 but can't seem to find any userspace use of that
>> ioctl.
>>
>> If there's none, you might just as well remove
>> config.dsc_media_access_frequency as an alternative solution.
>>
>> @Bart: Any historic info I'm missing here?
>
> We need to preserve struct idetape_config layout to not break the ioc=
tl
> (regardless if the field is really used by some user-space apps or no=
t)..

I know that. However, I can't seem to find any definition of that
ioctl, ioctl_list(2) manpage doesn't document it, so my question was
whether there is an agreed-upon definition of that ioctl and of struct
config at all. If not, we could simply remove that variable since the
struct layout is simply arbitrary in that case. Especially if there's
no corresponing driver functionality on the kernel side which makes
config.dsc_media_access_frequency the more useless.

--=20
Regards/Gruss,
Boris
