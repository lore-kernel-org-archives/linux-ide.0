From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 15:08:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040329130850.GD24370@suse.de>
References: <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com> <20040329080943.GR24370@suse.de> <20040329124147.GC4984@mail.shareable.org> <20040329124421.GB24370@suse.de> <1080565536.3570.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1080565536.3570.4.camel@laptop.fenrus.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Mar 29 2004, Arjan van de Ven wrote:
> On Mon, 2004-03-29 at 14:44, Jens Axboe wrote:
> > On Mon, Mar 29 2004, Jamie Lokier wrote:
> > > Jens Axboe wrote:
> > > > Could be used to limit tcq depth, not just request sizes solving two
> > > > problems at once. I already have a tiny bit of keeping this
> > > > accounting to do proper unplugs (right now it just looks at missing
> > > > requests from the pool, doesn't work on tcq).
> > > 
> > > Does it make sense to allow different numbers of outstanding TCQ-reads
> > > and TCQ-writes?
> > 
> > Might not be a silly thing to experiment with, definitely something that
> > should be tested (added to list...)
> 
> I wonder if the max read size could/should be correlated with the
> readahead size for such devices... it sounds like a related property at
> least.

Indeed, it would be best to keep the read-ahead window at least a
multiple of the max read size. So you don't get the nasty effects of
having a 128k read-ahead window, but device with 255 sector limit
resulting in 124KB + 4KB read.

-- 
Jens Axboe
