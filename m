From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 20:30:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040328183010.GQ24370@suse.de>
References: <4066021A.20308@pobox.com> <20040328175436.GL24370@suse.de> <20040328181223.GA791@holomorphy.com> <200403282030.11743.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200403282030.11743.bzolnier@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Sun, Mar 28 2004, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 28 of March 2004 20:12, William Lee Irwin III wrote:
> > On Sun, Mar 28, 2004 at 07:54:36PM +0200, Jens Axboe wrote:
> > > Sorry, but I cannot disagree more. You think an artificial limit at the
> > > block layer is better than one imposed at the driver end, which actually
> > > has a lot more of an understanding of what hardware it is driving? This
> > > makes zero sense to me. Take floppy.c for instance, I really don't want
> > > 1MB requests there, since that would take a minute to complete. And I
> > > might not want 1MB requests on my Super-ZXY storage, because that beast
> > > completes io easily at an iorate of 200MB/sec.
> > > So you want to put this _policy_ in the block layer, instead of in the
> > > driver. That's an even worse decision if your reasoning is policy. The
> > > only such limits I would want to put in, are those of the bio where
> > > simply is best to keep that small and contained within a single page to
> > > avoid higher order allocations to do io. Limits based on general sound
> > > principles, not something that caters to some particular piece of
> > > hardware. I absolutely refuse to put a global block layer 'optimal io
> > > size' restriction in, since that is the ugliest of policies and without
> > > having _any_ knowledge of what the hardware can do.
> >
> > How about per-device policies and driver hints wrt. optimal io?
> 
> Yep, user-tunable per-device policies with sane driver defaults.

BTW, these are trivial to expose through sysfs as their as inside the
queue already.

Making something user tunable is usually not the best idea, if you can
deduct these things automagically instead. So whether this is the best
idea, depends on which way you want to go.

-- 
Jens Axboe
