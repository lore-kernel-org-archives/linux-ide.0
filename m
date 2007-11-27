From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata nodes
Date: Tue, 27 Nov 2007 20:48:26 +0300
Message-ID: <20071127174826.GA15980@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153940.GC14183@localhost.localdomain> <474C3C79.5060908@ru.mvista.com> <20071127164101.GA14790@localhost.localdomain> <474C49D5.2000206@ru.mvista.com> <20071127173456.GA15693@localhost.localdomain> <474C5513.6010801@ru.mvista.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:7567 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757516AbXK0Rnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 12:43:35 -0500
Content-Disposition: inline
In-Reply-To: <474C5513.6010801@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Tue, Nov 27, 2007 at 08:34:11PM +0300, Sergei Shtylyov wrote:
> Anton Vorontsov wrote:
> 
> >>>2. "ioport" because shift^Wstride ;-) applies only to the io range
> >>> (yes, it's obvious, but worth open-wording, no?).
> 
> >>  Contrarywise, to memory range.
> 
> >By io range I meant "I/O base", in contrast to "CTL base".
> 
> >There is no need to apply shifting for CTL. That's why ioport-*
> >appeared in the first place.
> 
>    So, a matter of wrong terminology then. The thing that you meant by 
>    "I/O" is actually called "command block".

Yes. And IO is the second name. It's used widespread in the
drivers/ide/.

Now you understand why I'm so reluctant to hanging up different
labels on the single thing? ;-)

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
