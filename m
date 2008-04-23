From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH 00/11] removing the on-stack struct request
Date: Wed, 23 Apr 2008 12:32:37 +0200
Message-ID: <9ea470500804230332o69035d5ft919bc579cc0697bb@mail.gmail.com>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	 <58cb370e0804220214va6b7379tfa5b18acf36fd1a7@mail.gmail.com>
	 <20080423074010.GA8221@gollum.tnic> <20080423172500J.tomof@acm.org>
	 <20080423082747.GH12774@kernel.dk>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:60379 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYDWKch convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 06:32:37 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1938901wff.4
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 03:32:37 -0700 (PDT)
In-Reply-To: <20080423082747.GH12774@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Wed, Apr 23, 2008 at 10:27 AM, Jens Axboe <jens.axboe@oracle.com> wr=
ote:
>
> On Wed, Apr 23 2008, FUJITA Tomonori wrote:
>  > On Wed, 23 Apr 2008 09:40:11 +0200
>  > Borislav Petkov <petkovbb@googlemail.com> wrote:
>  >
>  > > On Tue, Apr 22, 2008 at 11:14:28AM +0200, Bartlomiej Zolnierkiew=
icz wrote:
>  > >
>  > > [..]
>  > >
>  > > > Looks promising but probably I'll not be able to review it pro=
perly
>  > > > this week (I'm busy with my real job) and the next week (I'll =
be busy
>  > > > with pushing overdue IDE updates).  OTOH I'm hoping that Boris=
lav
>  > > > would be able to take a look in the meantime.
>  > >
>  > > Yep, they're quite straight-forward and look fine except some ni=
tpicking i sent
>  > > in separate mails.
>  >
>  > Thanks for reviewing,
>  >
>  > Yeah, these patches are pretty straightforward mainly because they=
 are
>  > against the paths where we can use __GFP_WAIT.
>  >
>  >
>  > > FWIW, this is what we wanted to do initially but Jens didn't
>  > > agree to that at the time. I guess, it's because i probably didn=
't express
>  > > myself clearly enough then. See http://kerneltrap.org/mailarchiv=
e/linux-kernel/2008/3/1/1037974
>  > > for the whole discussion.
>  >
>  > I think that IDE uses request struct from interrupt context at som=
e
>  > places. In such places, I don't think that converting requests on =
the
>  > stack and a pre-allocated fixed number of requests to
>  > kmalloc/blk_get_request with GFP_ATOMIC is an good idea. It's bett=
er
>  > to remove such code (allocating requests from interrupt context).

Thanks for clarifying that, i've overlooked that case.

--=20
Regards/Gru=DF,
Boris
