From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/4] ide-tape: misc stuff
Date: Wed, 15 Jul 2009 20:43:50 +0200
Message-ID: <20090715184350.GA13708@liondog.tnic>
References: <1247671100-8173-1-git-send-email-petkovbb@gmail.com>
 <20090715.111606.193724419.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:38032 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbZGOSn4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2009 14:43:56 -0400
Content-Disposition: inline
In-Reply-To: <20090715.111606.193724419.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 15, 2009 at 11:16:06AM -0700, David Miller wrote:
> From: Borislav Petkov <petkovbb@googlemail.com>
> Date: Wed, 15 Jul 2009 17:18:16 +0200
> 
> > here is some ide-tape stuff.
> > 
> > * 0001: somehow fell through the cracks, DEBUG build fix
> 
> This is OK.
> 
> > * 0002: mostly code unification
> 
> I'm not applying this.  IDE is in deep maintainence mode and
> we really need to avoid changes that don't fix real bugs and
> have only marginal benefit, like this change.
> 
> > * 0003: this one converts ide-tape to the debugging scheme we use with ide-cd
> >   and ide-floppy. It adds some debug calls at important places and has proven
> >   very helpful when working on bug reports with users. No functional change.
> 
> I'm not applying this for the same reason as patch #2.

Well, the downside to that is whenever there's a bug report and I want
the user to do a debug build and send me the output, I'll have to rehash
that debug patch and send it to her/him, maybe teach her/him how to
patch a kernel, build it and catch the output and send it my way before
we do some real work. Having the change upstream makes it _a_ _lot_
_more_ easier to do that and this is experience talking, we had several
scenarious like that already.

So, applying those would be of great help to me without the danger of
introducing any regressions but I guess, it's your call. Still, I'd
really appreciate it if you reconsidered.

Thanks.

> > * 0004: real bugfix
>
> Ok, did you test this?

Yes.

-- 
Regards/Gruss,
    Boris.
