From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: Tree for Oct 11 (ata/pata_of_platform.c)
Date: Thu, 10 Nov 2011 14:57:03 +0100
Message-ID: <20111110135703.GA23609@elte.hu>
References: <20111011201127.455df266dcbffb1d621f8576@canb.auug.org.au>
 <4E94A920.40503@xenotime.net>
 <4E987829.3080104@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E987829.3080104@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org


* Randy Dunlap <rdunlap@xenotime.net> wrote:

> On 10/11/2011 01:37 PM, Randy Dunlap wrote:
> > On 10/11/11 02:11, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> The linux-next tree is now available from
> >> git://github.com/sfrothwell/linux-next.git as a temporary measure while
> >> the kernel.org servers are unavailable.
> >>
> >> It may also turn up on git.kernel.org (depending on the mirroring).  The
> >> patch set is still absent, however.
> >>
> >> Changes since 20111007:
> >>
> >> Removed tree: ide (at the maintainer's request)
> > 
> > 
> > drivers/ata/pata_of_platform.c:55:13: error: 'NO_IRQ' undeclared (first use in this function)
> 
> 
> [adding Author: Anton]
> 
> Build error still present in linux-next of 20111014.

This build failure regression report was ignored twice and then 
pushed upstream and is still unfixed a month after the initial 
report. Upstream now fails to build on like 25% of x86 configs.

What's going on with this bug guys?

Thanks,

	Ingo
