From: maney@two14.net (Martin Maney)
Subject: Re: [PATCH] Re: 2.4.22-rc2 ext2 filesystem corruption
Date: Sat, 10 Jan 2004 17:18:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040110231840.GA2528@furrr.two14.net>
References: <200310311941.31930.bzolnier@elka.pw.edu.pl> <20040104011222.GA1433@furrr.two14.net> <200401040307.48530.bzolnier@elka.pw.edu.pl> <20040108162508.GA4017@furrr.two14.net>
Reply-To: maney@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040108162508.GA4017@furrr.two14.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: maney@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 08, 2004 at 10:25:08AM -0600, Martin Maney wrote:
> On Sun, Jan 04, 2004 at 03:07:48AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > I see nothing in 2.4.23 which can explain this.
> > Probably if you boot from Promise you will see corruption again.

> that.  In fact I did *not* observe the corruption when I booted from
> the Promise, but I didn't have the same file (an XFree86 source

Okay, color me as having no idea what's going on...

Jiggered things around to boot from the drive connected to the Promise
(hereafter the old drive) again, with a copy of the original test
object (xfree86_4.2.1.orig.tar.gz from Branden's Debian archives).  It
still works with 2.4.23.  Rebuilt 2.4.22 (didn't have any of the patches
around, and I'm 99% sure I tested with 22-final just before giving up
originally); that works too.  Shutdown and physically removed the 3ware
card from the machine; dug up the grub boot disk that I'd forgotten I
would need for this, booted into 2.4.22 again.  Still, it works.

Maybe it's because the Promise chip knows it's no longer needed?  :-/

-- 
...and of course you must be careful not to overwrite the bounds of
memory blocks, free a memory block twice, forget to free a memory block,
use a memory block after it's been freed, use memory that you haven't
explicitly allocated, etc.  We C++ programmers have developed tricks
to help us deal with this sort of thing, in much the same way that people
who suffer severe childhood trauma develop psychological mechanisms to
insulate themselves from those experiences.  -- Joseph A. Knapka
