From: Learner Study <learner.study@gmail.com>
Subject: Re: SATA port multiplier support in 2.6.21
Date: Mon, 14 Sep 2009 18:47:51 -0700
Message-ID: <7efa8a7d0909141847n4d6f51f5wd87d2b156c006c89@mail.gmail.com>
References: <24580821.post@talk.nabble.com> <20090721025034.GA15894@psychosis.jim.sh>
	<4A684F49.3020904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:64795 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbZIOBsI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2009 21:48:08 -0400
Received: by pxi27 with SMTP id 27so2745182pxi.15
        for <linux-ide@vger.kernel.org>; Mon, 14 Sep 2009 18:48:11 -0700 (PDT)
In-Reply-To: <4A684F49.3020904@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jim Paris <jim@jtan.com>, linux-ide@vger.kernel.org

Hi Tejun:

I tried the following link but am getting HTTP 403 error!

I would appreciate if you could please point me to patch for port
multiplier back ported to 2.6.21?

Thanks a lot!


On Thu, Jul 23, 2009 at 4:53 AM, Tejun Heo <htejun@gmail.com> wrote:
>
> Jim Paris wrote:
> > Learner Study wrote:
> >> Hello:
> >>
> >> I understand that SATA port multiplier support was added in 2.6.24=
=2E
> >> I would like to use 2.6.21 and still use port multilplier. Can som=
eone point
> >> me to a patch I may use to do this? Any other ideas?
> >
> > There were patches from Tejun (libata-tj-stable) for 2.6.18 and 2.6=
=2E22
> > at one point, but I don't know where you'd find them anymore (the
> > original site at http://home-tj.org/wiki/index.php/Libata-tj-stable
> > is down). =A0You may have some luck googling around for those.
>
> Here are old patches.
>
> =A0http://htj.dyndns.org/export/libata-tj-old/
>
> > 2.6.21 is over two years old, so your best bet would be to upgrade =
to
> > a more recent version, or, if you're stuck with some distribution
> > kernel, talk to your vendor for support.
>
> But, yeah, seriously, if at all possible, please use newer kernels.
> There have been a lot of updates.
>
> Thanks.
>
> --
> tejun
