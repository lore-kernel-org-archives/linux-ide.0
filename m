From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Wed, 7 Jan 2015 15:15:37 +1100
Message-ID: <20150107041537.GH31508@dastard>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
 <20141204170611.GB2995@htj.dyndns.org>
 <yq14mtahmil.fsf@sermon.lab.mkp.net>
 <20141205145148.GI4080@htj.dyndns.org>
 <1418184578.2121.3.camel@HansenPartnership.com>
 <20141210142927.GA6294@htj.dyndns.org>
 <yq1oarbcj6f.fsf@sermon.lab.mkp.net>
 <20150105162830.GP15833@htj.dyndns.org>
 <yq1387n8nfv.fsf@sermon.lab.mkp.net>
 <20150107025455.GL3077@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150107025455.GL3077@htj.dyndns.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jan 06, 2015 at 09:54:55PM -0500, Tejun Heo wrote:
> Hello, Martin.
> 
> On Tue, Jan 06, 2015 at 07:05:40PM -0500, Martin K. Petersen wrote:
> > Tejun> Isn't that kinda niche and specialized tho?  
> > 
> > I don't think so. There are two reasons for zeroing block ranges:
> > 
> >  1) To ensure they contain zeroes on subsequent reads
> > 
> >  2) To preallocate them or anchor them down on thin provisioned devices
> > 
> > The filesystem folks have specifically asked to be able to make that
> > distinction. Hence the patch that changes blkdev_issue_zeroout().
> > 
> > You really don't want to write out gobs and gobs of zeroes and cause
> > unnecessary flash wear if all you care about is the blocks being in a
> > deterministic state.
> 
> I think I'm still missing something.  Are there enough cases where
> filesystems want to write out zeroes during operation?

IMO, yes.

w.r.t. thinp devices, we need to be able to guarantee that
prellocated regions in the filesystem are actually backed by real
blocks in the thinp device so we don't get ENOSPC from the thinp
device. No filesystems do this yet because we don't have a mechanism
for telling the lower layers "preallocate these blocks to zero".

The biggest issue is that we currently have no easy way to say
"these blocks need to contain zeros, but we aren't actually using
them yet". i.e. the filesystem code assumes that they contain zeros
(e.g. in ext4 inode tables because mkfs used to zero them) if they
haven't been used, so when it reads them it detects that
initialisation is needed because the blocks are empty....

FWIW, some filesystems need these regions to actually contain
zeros because they can't track unwritten extents (e.g.
gfs2). having sb_issue_zeroout() just do the right thing enables us
to efficiently zero the regions they are preallocating...

> Earlier in the
> thread, it was mentioned that this is currently mostly useful for
> raids which need the blocks actually cleared for checksum consistency,
> which basically means that raid metadata handling isn't (yet) capable
> of just marking those (parts of) stripes as unused.  If a filesystem
> wants to read back zeros from data blocks, wouldn't it be just marking
> the matching index as such?

Not all filesystems can do this for user data (see gfs2 case above)
and no linux filesystem tracks whether free space contains zeros or
stale data. Hence if we want blocks to be zeroed on disk, we
currently have to write zeros to them and hence they get pinned in
devices as "used space" even though they may never get used again.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
