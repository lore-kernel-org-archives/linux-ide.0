From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch][9/9] block: remove bio walking
Date: Thu, 9 Sep 2004 09:01:16 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040909090116.11e7a031.davem@davemloft.net>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl>
	<200409091553.13918.bzolnier@elka.pw.edu.pl>
	<20040909150444.C6434@flint.arm.linux.org.uk>
	<200409091628.25304.bzolnier@elka.pw.edu.pl>
	<20040909155420.D6434@flint.arm.linux.org.uk>
	<20040909154453.GG1737@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:5765
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266143AbUIIQBm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Sep 2004 12:01:42 -0400
In-Reply-To: <20040909154453.GG1737@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: bzolnier@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com

On Thu, 9 Sep 2004 17:44:53 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Thu, Sep 09 2004, Russell King wrote:
> > Essentially, kernel PIO writes data into the page cache, and that action
> > may leave data in the CPU's caches.  Since the kernels mappings may not
> > be coherent with mappings in userspace, data written to the kernel
> > mappings may remain in the data cache, and stale data would be visible
> > to user space.
> > 
> > There has been talk about using flush_dcache_page() to resolve
> > this issue, but I'm not sure what the outcome was.  Certainly
> > flush_dcache_page() is supposed to be used before the data in the
> > kernels page cache is read or written.
> 
> Have you ever tested bouncing on arm? It seems to be lacking a
> flush_dcache_page() indeed, how does this look?

This looks like a good fix to me too.
