From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH 06/11] ide: make ide_do_drive_cmd return rq->errors
Date: Wed, 23 Apr 2008 12:27:44 +0200
Message-ID: <9ea470500804230327w166fa9bfn510f6ad058160f4e@mail.gmail.com>
References: <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	 <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	 <20080423073222.GB7482@gollum.tnic> <20080423171232U.tomof@acm.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:53424 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYDWK1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 06:27:45 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1937246wff.4
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 03:27:44 -0700 (PDT)
In-Reply-To: <20080423171232U.tomof@acm.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Wed, Apr 23, 2008 at 10:25 AM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> On Wed, 23 Apr 2008 09:32:22 +0200
>  Borislav Petkov <petkovbb@googlemail.com> wrote:
>
>  > Hi,
>  >
>  > On Tue, Apr 22, 2008 at 09:26:37AM +0900, FUJITA Tomonori wrote:
>  > > ide_do_drive_cmd forges an error value (-EIO) instead of
>  > > rq->errors. idetape_queue_rw_tail wants rq->errors so this patch=
 makes
>  > > ide_do_drive_cmd return rq->errors.
>  > >
>  > > For compatibility, this patch makes the users of ide_do_drive_cm=
d
>  > > return -EIO instead of a return value of ide_do_drive_cmd
>  > > (rq->errors).
>  >
>  > i don't see the reason for it. In the end, the only error type tha=
t is being
>  > handed to and fro is -EIO and nobody is interested in rq->errors. =
So, whether
>  > ide_do_drive_cmd or its callers return -EIO is kinda unimportant. =
In the second
>  > case, however, you have simply added more code (as per the diffsta=
t below) with
>  > no apparent functionality. It would only make sense, IMHO, if you =
would
>  > differentiate behaviour based on rq->errors...
>
>  I did this only because idetape_queue_rw_tail seems to have
>  differentiate behaviour based on rq->errors:
>
>
>  static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int bl=
ocks,
>                                  struct idetape_bh *bh)
>  {
>  ...
>
>         (void) ide_do_drive_cmd(drive, &rq, ide_wait);
>
>         if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) =3D=3D 0)
>                 return 0;
>
>         if (tape->merge_stage)
>                 idetape_init_merge_stage(tape);
>         if (rq.errors =3D=3D IDETAPE_ERROR_GENERAL)
>                 return -EIO;
>
>
>  If we can do something like:
>
>
>         ret =3D ide_do_drive_cmd(drive, &rq, ide_wait);
>
>         if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) =3D=3D 0)
>                 return 0;
>
>         if (tape->merge_stage)
>                 idetape_init_merge_stage(tape);
>         if (ret)
>                 return -EIO;
>
>
>  Then yeah, we don't need this patch.
>

Well, AFAICS, all calls to idetape_queue_rw_tail simply check whether i=
ts return
value is negative, and, if so, discontinue further command queueing. So=
, i think
we're OK if we simply return -EIO. Bart?

--=20
Regards/Gru=DF,
Boris
