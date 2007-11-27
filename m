From: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and
	pata nodes
Date: Tue, 27 Nov 2007 22:50:46 +0300
Message-ID: <20071127195045.GA1320@zarina>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153940.GC14183@localhost.localdomain> <474C3C79.5060908@ru.mvista.com> <20071127164101.GA14790@localhost.localdomain> <474C49D5.2000206@ru.mvista.com> <20071127173456.GA15693@localhost.localdomain> <474C5513.6010801@ru.mvista.com> <20071127174826.GA15980@localhost.localdomain> <474C5CD2.7080208@ru.mvista.com>
Reply-To: cbou@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx30.mail.ru ([194.67.23.238]:28711 "EHLO mx30.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbXK0T5U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 14:57:20 -0500
Content-Disposition: inline
In-Reply-To: <474C5CD2.7080208@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: avorontsov@ru.mvista.com, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Tue, Nov 27, 2007 at 09:07:14PM +0300, Sergei Shtylyov wrote:
> Anton Vorontsov wrote:
> 
> >>>>>2. "ioport" because shift^Wstride ;-) applies only to the io range
> >>>>>(yes, it's obvious, but worth open-wording, no?).
> 
> >>>> Contrarywise, to memory range.
> 
> >>>By io range I meant "I/O base", in contrast to "CTL base".
> 
> >>>There is no need to apply shifting for CTL. That's why ioport-*
> >>>appeared in the first place.
> 
> >>   So, a matter of wrong terminology then. The thing that you meant by 
> >>   "I/O" is actually called "command block".
> 
> > Yes. And IO is the second name.
> 
>     I'd say the first place in drivers/ide belongs to the historic name 
> "taskfile". The "command block" which is as ATA standard calls it, is hardly used.
> 
> > It's used widespread in the drivers/ide/.
> 
>     Don't remember seeing it.

Oops, thinko -- not drivers/ide/, but include/linux/ide.h.
Grep for io_addr.

> > Now you understand why I'm so reluctant to hanging up different
> > labels on the single thing? ;-)
> 
>     :-)

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
