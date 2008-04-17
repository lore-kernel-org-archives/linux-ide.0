From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH 3/6] IDE: ide-cd: fix test unsigned var < 0
Date: Thu, 17 Apr 2008 14:01:34 +0200
Message-ID: <9ea470500804170501s5e794cd2u8cda1b46fb6fbf9f@mail.gmail.com>
References: <48055F1A.9020706@tiscali.nl>
	 <200804170040.07397.bzolnier@gmail.com> <4806C952.6030102@tiscali.nl>
	 <9ea470500804170212md8ce430p42b3c1787ba95631@mail.gmail.com>
	 <48072ED7.7030002@tiscali.nl>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.182]:42323 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYDQMBg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2008 08:01:36 -0400
Received: by el-out-1112.google.com with SMTP id n30so1523elf.21
        for <linux-ide@vger.kernel.org>; Thu, 17 Apr 2008 05:01:35 -0700 (PDT)
In-Reply-To: <48072ED7.7030002@tiscali.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Thu, Apr 17, 2008 at 1:04 PM, Roel Kluin <12o3l@tiscali.nl> wrote:
> Boris Petkov wrote:
>
>  > I'd rather keep the "unsigned long bio_sectors;" part and do somet=
hing
>  > of the likes of:
>  >
>  > bio_sectors =3D bio_sectors(failed_command->bio);
>  >
>  >
>  > (remove the "if (bio_sectors < 4)"-test)
>  >
>  > ... and later...
>  >
>  > sector &=3D ~(max(bio_sectors - 1, 3));
>  >
>  > which is, IMO, more readable.
>  >
>  > Roel, would you redo your patch please? Thanks.
>
>  While at it I also cleaned up some whitespace
>
> ---
>  Clean up cdrom_analyze_sense_data()
>
>  Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Thanks a lot.

Acked-by: Borislav Petkov <petkovbb@gmail.com>


--=20
Regards/Gru=DF,
Boris
