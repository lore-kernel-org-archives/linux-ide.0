From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch][9/9] block: remove bio walking
Date: Thu, 9 Sep 2004 19:10:57 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409091910.57137.bzolnier@elka.pw.edu.pl>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl> <200409091628.25304.bzolnier@elka.pw.edu.pl> <20040909155420.D6434@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:64498 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S266425AbUIIRW4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Sep 2004 13:22:56 -0400
In-Reply-To: <20040909155420.D6434@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>

On Thursday 09 September 2004 16:54, Russell King wrote:
> On Thu, Sep 09, 2004 at 04:28:25PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 09 September 2004 16:04, Russell King wrote:
> > > On Thu, Sep 09, 2004 at 03:53:13PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > On Thursday 09 September 2004 10:03, Russell King wrote:
> > > > > On Wed, Sep 08, 2004 at 09:27:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > > > [patch] block: remove bio walking
> > > > > > 
> > > > > > IDE driver was the only user of bio walking code.
> > > > 
> > > > was in -bk10 :-(
> > > > 
> > > > > The MMC driver also uses this.  Please don't remove.
> > > > 
> > > > OK I'll just drop this patch but can't we also use scatterlists in MMC?
> > > > 
> > > > The point is that I now think bio walking was a mistake and accessing
> > > > bios directly from low-level drivers is a layering violation (thus
> > > > all the added complexity). Moreover with fixed IDE PIO and without
> > > > bio walking code it should be possible to shrink struct request by
> > > > removing all "current" entries.
> > > 
> > > I'm wondering whether it is legal to map onto SG lists and then do PIO.
> > > Provided we don't end up using the DMA API and then using PIO to the
> > > original pages, it should work.
> > 
> > Yes, it actually works fine. See the other patches from the patchkit. :-)
> 
> Actually, if you've only tested x86, you don't know if it works fine.
> x86 is a rather benign architecture when it comes to testing whether
> various interfaces are being used correctly.

x86 only

This forced me into rechecking everything and I found one issue:
in ide_pio_sector() sg->length should be used instead of sg_dma_len(sg).

With this fixed patchkit should work on any arch
(testing and comments are welcomed of course).

> > > However, using the SG lists does finally provide us with a nice way to
> > > ensure that we have the right information to finally fix IDE wrt the
> > > PIO cache issues (dirty cache lines being left in the page cache.)
> > 
> > Could you explain the issue a bit more?
> 
> Essentially, kernel PIO writes data into the page cache, and that action
> may leave data in the CPU's caches.  Since the kernels mappings may not
> be coherent with mappings in userspace, data written to the kernel
> mappings may remain in the data cache, and stale data would be visible
> to user space.
> 
> There has been talk about using flush_dcache_page() to resolve
> this issue, but I'm not sure what the outcome was.  Certainly
> flush_dcache_page() is supposed to be used before the data in the
> kernels page cache is read or written.
> 
> See Documentation/cachetlb.txt for further information on this
> interface.

Thanks, now I understand the problem.
