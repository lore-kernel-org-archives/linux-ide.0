From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 15:05:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040329130554.GI3039@dualathlon.random>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <20040329042912.GI18054@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040329042912.GI18054@ca-server1.us.oracle.com>
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Sun, Mar 28, 2004 at 08:29:12PM -0800, Wim Coekaerts wrote:
> > In 2.4 reaching 512k DMA units that helped a lot, but going past 512k
> > didn't help in my measurements.  1M maybe these days is needed (as Jens
> > suggested) but >1M still sounds overkill and I completely agree with
> > Jens about that.
> 
> at least 1Mb... more than 1mb (I doubt 32mb is really necessarily
> useful) is nice for flushing contiguous journal data to disk. between
> 1-8mb in one io.
> 
> at least 1mb is good when you have to process massive amounts of data,
> just read huge chunks of files, we tend to do 1mb. anyway,
> as you said, at some point it's a bit overkill . I thinkg 1-8mb makes
> sense. 

1M certainly it's reasonable, though for 8M I've my doubt you can
measure a throughput improvement, can you?
