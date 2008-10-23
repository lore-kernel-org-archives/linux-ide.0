From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH] cdrom: add TEAC CD-224E to the NO_AUTOCLOSE list
Date: Thu, 23 Oct 2008 14:37:44 +0200
Message-ID: <9ea470500810230537u559fff3chda7c6f47927bf1b0@mail.gmail.com>
References: <4900655E.7050906@freemail.hu>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:38358 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbYJWMhr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 08:37:47 -0400
Received: by gxk9 with SMTP id 9so1209148gxk.13
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 05:37:44 -0700 (PDT)
In-Reply-To: <4900655E.7050906@freemail.hu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thu, Oct 23, 2008 at 1:51 PM, N=E9meth M=E1rton <nm127@freemail.hu> =
wrote:
> From: M=E1rton N=E9meth <nm127@freemail.hu>
>
> The "TEAC CD-ROM CD-224E" cannot close its tray, so add it to the NO_=
AUTOCLOSE list. This
> will correct the "Can close tray" field of /proc/sys/dev/cdrom/info.
>
> Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>

Acked-by: Borislav Petkov <petkovbb@gmail.com>

> ---
> --- linux-2.6.27/drivers/ide/ide-cd.c.orig      2008-10-10 00:13:53.0=
00000000 +0200
> +++ linux-2.6.27/drivers/ide/ide-cd.c   2008-10-23 11:34:59.000000000=
 +0200
> @@ -1863,6 +1863,7 @@ static const struct cd_list_entry ide_cd
>        { "Optiarc DVD RW AD-5200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK  =
       },
>        { "Optiarc DVD RW AD-7200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK  =
       },
>        { "Optiarc DVD RW AD-7543A", NULL,   IDE_AFLAG_NO_AUTOCLOSE   =
       },
> +       { "TEAC CD-ROM CD-224E",     NULL,   IDE_AFLAG_NO_AUTOCLOSE  =
        },
>        { NULL, NULL, 0 }
>  };
>
>

--=20
Regards/Gruss,
Boris
