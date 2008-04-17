From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH 3/6] IDE: ide-cd: fix test unsigned var < 0
Date: Thu, 17 Apr 2008 11:12:30 +0200
Message-ID: <9ea470500804170212md8ce430p42b3c1787ba95631@mail.gmail.com>
References: <48055F1A.9020706@tiscali.nl>
	 <200804170040.07397.bzolnier@gmail.com> <4806C952.6030102@tiscali.nl>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:38848 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761146AbYDQJMc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2008 05:12:32 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2185839wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 17 Apr 2008 02:12:31 -0700 (PDT)
In-Reply-To: <4806C952.6030102@tiscali.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Thu, Apr 17, 2008 at 5:51 AM, Roel Kluin <12o3l@tiscali.nl> wrote:
> Bartlomiej Zolnierkiewicz wrote:
>  > Hi,
>  >
>  > On Wednesday 16 April 2008, Roel Kluin wrote:
>  >> Is this the right fix in this case?
>  >
>  > Yes, but it seems that 'valid' is only written to
>  > so it may be as well removed completely.
>  >
>  > Care to update the patch?
>  >
>  > Thanks,
>  > Bart
>
>  how about this?
>
>  Roel
>
>  ---
>  Clean up cdrom_analyze_sense_data()
>
>
>  Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
>  ---
>  diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
>  index a60f5df..a5f3beb 100644
>
> --- a/drivers/ide/ide-cd.c
>  +++ b/drivers/ide/ide-cd.c
>  @@ -143,8 +143,6 @@ void cdrom_analyze_sense_data(ide_drive_t *drive=
,
>                               struct request_sense *sense)
>   {
>         unsigned long sector;
>  -       unsigned long bio_sectors;
>  -       unsigned long valid;
>         struct cdrom_info *info =3D drive->driver_data;
>
>         if (!cdrom_log_sense(drive, failed_command, sense))
>  @@ -174,13 +172,9 @@ void cdrom_analyze_sense_data(ide_drive_t *driv=
e,
>                                  (sense->information[2] <<  8) |
>                                  (sense->information[3]);
>
>  -                       bio_sectors =3D bio_sectors(failed_command->=
bio);
>  -                       if (bio_sectors < 4)
>  -                               bio_sectors =3D 4;
>                         if (drive->queue->hardsect_size =3D=3D 2048)
>                                 sector <<=3D 2;   /* Device sector si=
ze is 2K */
>  -                       sector &=3D ~(bio_sectors -1);
>
> -                       valid =3D (sector - failed_command->sector) <=
< 9;
>  +                       sector &=3D ~(max(bio_sectors(failed_command=
->bio) - 1, 3));

Well, i don't think that this "optimization" makes the code more readab=
le.
Besides, gcc does this anyway. Poor are only those who have to stare at=
 it for
a couple of minutes just to understand what it says. Still, i don't obj=
ect to
it completely and the "valid"-var can go. I'd rather keep the "unsigned=
 long
bio_sectors;" part and do something of the likes of:

bio_sectors =3D bio_sectors(failed_command->bio);


(remove the "if (bio_sectors < 4)"-test)

=2E.. and later...

sector &=3D ~(max(bio_sectors - 1, 3));

which is, IMO, more readable.

Roel, would you redo your patch please? Thanks.

--=20
Regards/Gru=DF,
Boris
