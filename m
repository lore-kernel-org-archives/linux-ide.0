From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: prevent null pointer deref via cdrom_newpc_intr
Date: Thu, 18 Jun 2009 16:39:40 +0200
Message-ID: <9ea470500906180739qdabce04u7c7875acc05358f@mail.gmail.com>
References: <87zlc58xgd.fsf@fever.mssgmbh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47121 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbZFROjj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 10:39:39 -0400
In-Reply-To: <87zlc58xgd.fsf@fever.mssgmbh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rainer Weikusat <rweikusat@mssgmbh.com>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hi,

we we're just debugging this and I was about to send the patches
tomorrow but you beat me to it :).

On Thu, Jun 18, 2009 at 3:48 PM, Rainer Weikusat<rweikusat@mssgmbh.com>=
 wrote:
> From: Rainer Weikusat <rweikusat@mssgmbh.com>
>
> With 2.6.30, the error handling code in cdrom_newpc_intr was changed
> to deal with partial request failures by normally completing the 'goo=
d'
> parts of a request and only 'error' the last (and presumably,
> incompletely transferred) bio associated with a particular
> request. This doesn't work for requests which don't have bios
> associated with them ('GPCMD_READ_DISC_INFO'), because the first call
> to ide_end_rq, done via ide_complete_rq in order to do the
> partial completion part, returns with a code of zero for all non-bio
> requests, causing the drive->hwif->rq pointer to be set to NULL.

This is a bit misleading, it should be more like: "ide_complete_rq is
called over ide_cd_error_cmd() to partially complete the rq but the rq
is without a bio and the block layer does partial completion only for
requests with bio's so this request is completed as a whole and the rq
freed."

please fix.

> Upon
> calling ide_complete_rq a second time, it is attempted to de-referenc=
e
> this null pointer, resulting in a kernel crash.
>
> Signed-Off-By: Rainer Weikusat <rweikusat@mssgmbh.com>
>
> ---
>
> This is fixed in the linux-ide tree since at about 2009/06/10 [Bug
> 13399, also happens w/ TSSTcorpDVD-ROM SH-D162C],

really, because I can't find it in Bart's trees. Do you have a commit
id?

> but a patch
> against 2.6.30 AFAIK doesn't exist (and I didn't find the
> corresponding thread before digging through all of this ...).
> --- drivers/ide/ide-cd.c.orig =A0 2009-06-18 15:10:24.000000000 +0200
> +++ drivers/ide/ide-cd.c =A0 =A0 =A0 =A02009-06-18 14:10:16.000000000=
 +0200
> @@ -758,7 +758,7 @@ out_end:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rq->er=
rors =3D -EIO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uptodate =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uptodate =3D=3D 0 && rq->bio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ide_cd_error_cmd(drive=
, cmd);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* make sure it's fully ended */
>

--=20
Regards/Gruss,
Boris
