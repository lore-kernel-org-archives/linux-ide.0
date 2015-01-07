From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Tue, 6 Jan 2015 21:54:55 -0500
Message-ID: <20150107025455.GL3077@htj.dyndns.org>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
 <20141204170611.GB2995@htj.dyndns.org>
 <yq14mtahmil.fsf@sermon.lab.mkp.net>
 <20141205145148.GI4080@htj.dyndns.org>
 <1418184578.2121.3.camel@HansenPartnership.com>
 <20141210142927.GA6294@htj.dyndns.org>
 <yq1oarbcj6f.fsf@sermon.lab.mkp.net>
 <20150105162830.GP15833@htj.dyndns.org>
 <yq1387n8nfv.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yq1387n8nfv.fsf@sermon.lab.mkp.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Martin.

On Tue, Jan 06, 2015 at 07:05:40PM -0500, Martin K. Petersen wrote:
> Tejun> Isn't that kinda niche and specialized tho?  
> 
> I don't think so. There are two reasons for zeroing block ranges:
> 
>  1) To ensure they contain zeroes on subsequent reads
> 
>  2) To preallocate them or anchor them down on thin provisioned devices
> 
> The filesystem folks have specifically asked to be able to make that
> distinction. Hence the patch that changes blkdev_issue_zeroout().
> 
> You really don't want to write out gobs and gobs of zeroes and cause
> unnecessary flash wear if all you care about is the blocks being in a
> deterministic state.

I think I'm still missing something.  Are there enough cases where
filesystems want to write out zeroes during operation?  Earlier in the
thread, it was mentioned that this is currently mostly useful for
raids which need the blocks actually cleared for checksum consistency,
which basically means that raid metadata handling isn't (yet) capable
of just marking those (parts of) stripes as unused.  If a filesystem
wants to read back zeros from data blocks, wouldn't it be just marking
the matching index as such?  And if you take out the zeroing case,
trims are just trims and whether they return 0 afterwards or not is
irrelevant.

There sure can be use cases where zeroing fast and securely make
noticeable difference but the cases put forth till this point seem
relatively weak.  I mean, after all, requiring trim to zero the blocks
is essentially pushing down that amount of metadata management to the
device - the device would do the exactly same thing.  Pushing it down
the layers can definitely be beneficial especially when there's no
agreed-upon metadata on the medium (so, mkfs time), but it seems kinda
superflous during normal operation.  What am I missing?

Thanks.

-- 
tejun
