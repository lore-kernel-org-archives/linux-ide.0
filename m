From: Mike Galbraith <efault@gmx.de>
Subject: Re: regression: CD burning (k3b) went broke
Date: Wed, 27 Feb 2008 03:24:35 +0100
Message-ID: <1204079075.26640.8.camel@homer.simson.net>
References: <1203583379.6244.27.camel@homer.simson.net>
	 <20080222073228.GZ23197@kernel.dk>
	 <1203752563.5225.4.camel@homer.simson.net>
	 <1203839683.17463.9.camel@homer.simson.net>
	 <1204019283.8731.11.camel@homer.simson.net>
	 <1204033003.11828.22.camel@homer.simson.net>
	 <20080226150845.2196bc1a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20080226150845.2196bc1a.akpm@linux-foundation.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Tue, 2008-02-26 at 15:08 -0800, Andrew Morton wrote:
> On Tue, 26 Feb 2008 14:36:43 +0100 Mike Galbraith <efault@gmx.de> wrote:

> > Seems the problem is data_len changes, but raw_data_len doesn't.  I've
> > not the foggiest IO-land clue, but k3b works again, so the below may
> > have some diagnostic value.
> 
> So this change fixes a bug?  Can we have a recap of how it does this?

Yeah, it fixes the problem.  (wrt recap, if I could write it, it would
be a changelog;)

	-Mike

