From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 19:31:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040328173126.GH24370@suse.de>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040327170257.24c82915.akpm@osdl.org> <406625D4.7090605@pobox.com> <20040328135907.GC24370@suse.de> <40670B63.8040704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <40670B63.8040704@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Mar 28 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sat, Mar 27 2004, Jeff Garzik wrote:
> >
> >>"IOPs" are what make a lot of storage peeps excited these days, so they 
> >>are being pushed in a low-latency direction anyway.
> >
> >
> >IOPS says nothing about latency, it's still 100% throughput oriented.
> 
> 
> In order to achieve a large IOPs number, one must sent a ton of small 
> requests.  Per-request latency as well as overall throughput is a factor.

I don't see how per-request latency is a factor at all, if your metric
is simply iops/sec. You could infinitely starve lots of requests
without hurting your io rate, nor throughput.

-- 
Jens Axboe
