From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] IDE: ide-cd: fix test unsigned var < 0
Date: Sun, 27 Apr 2008 20:32:51 +0200
Message-ID: <200804272032.51371.bzolnier@gmail.com>
References: <48055F1A.9020706@tiscali.nl> <48072ED7.7030002@tiscali.nl> <9ea470500804170501s5e794cd2u8cda1b46fb6fbf9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:24244 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762946AbYD0TyQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Apr 2008 15:54:16 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4628216fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Apr 2008 12:54:15 -0700 (PDT)
In-Reply-To: <9ea470500804170501s5e794cd2u8cda1b46fb6fbf9f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Roel Kluin <12o3l@tiscali.nl>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Thursday 17 April 2008, Boris Petkov wrote:
> On Thu, Apr 17, 2008 at 1:04 PM, Roel Kluin <12o3l@tiscali.nl> wrote:
> > Boris Petkov wrote:
> >
> >  > I'd rather keep the "unsigned long bio_sectors;" part and do som=
ething
> >  > of the likes of:
> >  >
> >  > bio_sectors =3D bio_sectors(failed_command->bio);
> >  >
> >  >
> >  > (remove the "if (bio_sectors < 4)"-test)
> >  >
> >  > ... and later...
> >  >
> >  > sector &=3D ~(max(bio_sectors - 1, 3));

drivers/ide/ide-cd.c: In function =E2=80=98cdrom_analyze_sense_data=E2=80=
=99:
drivers/ide/ide-cd.c:180: warning: comparison of distinct pointer types=
 lacks a cast

[ which actually hints us into real issue -> please think what would
  happen if bio_sectors() returns _zero_ before and after the patch ]

I applied the patch replacing the above code with:

	bio_sectors =3D max(bio_sectors(failed_command->bio), 4U);
	sector &=3D ~(bio_sectors - 1);

Thanks,
Bart
