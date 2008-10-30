From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] block: add timer on blkdev_dequeue_request() not elv_next_request()
Date: Thu, 30 Oct 2008 08:58:56 +0100
Message-ID: <20081030075855.GO31673@kernel.dk>
References: <490927CD.2010205@kernel.org> <20081030072956.GL31673@kernel.dk> <49096865.2050006@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49096865.2050006@kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-scsi <linux-scsi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Oct 30 2008, Tejun Heo wrote:
> Jens Axboe wrote:
> > That's actually a pretty dumb error, I'm surprised it hasn't reared its
> > ugly face in more ways. Presumably because the timeout is usually so
> > long, that we'll get to actually issuing and completing it within the
> > normal timeout anyway.
> 
> Heh... it showed its ugly face in many different ways while I was
> playing with PMP connected via a very long eSATA cable.

Ah :-)

If we had it wired up for eg the old IDE drivers, it would have shown up
quite quickly as well I think.

-- 
Jens Axboe

