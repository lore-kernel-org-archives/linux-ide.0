From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: libata: set queue SSD flag for SSD devices
Date: Sat, 11 Oct 2008 16:06:01 +0200
Message-ID: <20081011140600.GR19428@kernel.dk>
References: <200810101904.m9AJ42Gq018897@hera.kernel.org> <20081010202515.446857cc@lxorguk.ukuu.org.uk> <20081010200528.GJ19428@kernel.dk> <20081010175508.3d1ed2a4@infradead.org> <1223710417.4159.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:38495 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059AbYJKOGh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Oct 2008 10:06:37 -0400
Content-Disposition: inline
In-Reply-To: <1223710417.4159.11.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, torvalds@osdl.org

On Sat, Oct 11 2008, James Bottomley wrote:
> On Fri, 2008-10-10 at 17:55 -0700, Arjan van de Ven wrote:
> > On Fri, 10 Oct 2008 22:05:28 +0200
> > Jens Axboe <jens.axboe@oracle.com> wrote:
> > > 
> > > In this specific patch, it'll do no harm at least since I very much
> > > doubt we'll see a false positive. And even if, the consequences wont
> > > be dire. But it does want the version check, of course.
> > > 
> > 
> > also, is "is an ssd" the right question or is "doesn't have seek
> > latency" the right one?
> > (difference is.. well EMC boxes with lots of ram etc)
> 
> For libata, the is ssd is the right test.
> 
> For things like the symmetrix we probably need to look at the caching
> mode page and treat it like ssd if the cache is say > 1GB or whatever
> heuristic is needed.

Still wont quite work, you're still going to have occasional seek
latencies no matter how large the cache is (unless it's == device size
:-)

So we need something a bit more involved, but not too complex. A fine
line...

-- 
Jens Axboe

