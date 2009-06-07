From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 16:57:19 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906071651250.6847@localhost.localdomain>
References: <200906071444.33047.bzolnier@gmail.com> <200906072125.40784.bzolnier@gmail.com> <alpine.LFD.2.01.0906071614560.6847@localhost.localdomain> <200906080147.12274.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754560AbZFGX5u@vger.kernel.org>
In-Reply-To: <200906080147.12274.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, James Bottomley <James.Bottomley@hansenpartnership.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



On Mon, 8 Jun 2009, Bartlomiej Zolnierkiewicz wrote:
> 
> This is not a new feature and basing your opinions on opinions of people
> who don't read the code before commenting is bad, really bad, m'kay?

The thing is, I had planned on doing a final release yesterday, even 
before your pull came in. I decided to hold off, let it be, just to test 
the _current_ state a bit more. No way am I then adding some effectively 
totally untested new code-path.

And if you start messing in partitions.c and adding whole new callback 
functions to generic block_device_operations, then that's a new code-path. 
The IDE subsystem has _no_ business adding random new callbacks in 
the very last days of a release.

It sure as hell is not just a bugfix, it's a new feature. The feature may 
be _needed_ for some specific bug report, but that is totally irrelevant. 
We don't do things like that.

It's also almost certainly not a regression, is it? So by no measure does 
it work as a "late in the -rc sequence" patch.

		Linus
