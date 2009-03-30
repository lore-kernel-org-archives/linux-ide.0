From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCHSET pata-2.6] ide: rq->buffer, data, special and
 =?utf-8?q?misc=09cleanups?=
Date: Mon, 30 Mar 2009 16:50:11 +0200
Message-ID: <200903301650.11429.bzolnier@gmail.com>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <20090328140405.GA2741@liondog.tnic> <49D08CEC.3010705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755021AbZC3OrV@vger.kernel.org>
In-Reply-To: <49D08CEC.3010705@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: petkovbb@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org, Boaz Harrosh <bharrosh@panasas.com>
List-Id: linux-ide@vger.kernel.org

On Monday 30 March 2009, Tejun Heo wrote:
> Borislav Petkov wrote:
> > On Sat, Mar 28, 2009 at 02:51:01PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > [..]
> > 
> >>> Bartlomiej, if you're okay with the changes and Jens acks the patches
> >>> and pushing the first three patches via pata-2.6, please feel free to
> >>> include these patches into your tree.
> >> Everything looks fine to me.  Once I get Jens' ack (block bits)
> >> and Borislav's one (ATAPI bits) I'll happily merge this patchset.
> > 
> > Yep, I just finished testing the whole series here so you can go ahead
> > and apply them pending a recast of patch 07/14 you'll hopefully be
> > receiving soon from Tejun.
> 
> After the earlier discussion with Boaz Harrosh, I ended up redoing the
> blk_rq_map_{kern|user}_*() stuff and am now in the process of testing
> it.  The patchset is rather large (20+ patches).  As the prealloc
> patch would fit on top of that series, I think it would be better to
> sequence things via git merge.  Is there a git tree I can use for
> pata-2.6 changes?  Or is the current linus master okay?

Not yet, we discussed this two weeks ago and the only thing that changed
in the meantime is that we are in the merge window now and I'm ultra busy
instead of being just really busy.  Do not worry though -- your last two
patchsets are a very good motivator for quilt->git conversion (much better
than i.e. some unproductive preaching).

Thanks,
Bart
