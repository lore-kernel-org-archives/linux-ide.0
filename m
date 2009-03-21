From: Mark Lord <liml@rtr.ca>
Subject: Re: Overagressive failing of disk reads, both LIBATA and IDE
Date: Sat, 21 Mar 2009 11:20:21 -0400
Message-ID: <49C505B5.9020804@rtr.ca>
References: <F79C774361EF45A6A68BC08F8621E406@DIAMOND8600>	 <49C30E67.4060702@rtr.ca> <1237645333.4600.9.camel@localhost.localdomain>	 <49C4FFFB.5000601@rtr.ca> <1237648115.4600.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:53269 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbZCUPU2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Mar 2009 11:20:28 -0400
In-Reply-To: <1237648115.4600.12.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Lord <lkml@rtr.ca>, Norman Diamond <n0diamond@yahoo.co.jp>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

James Bottomley wrote:
> On Sat, 2009-03-21 at 10:55 -0400, Mark Lord wrote:
..
>> The patch *does* use the disk supplied data about the error,
>> and returns success for sectors up to that point.  Where it differs
>> from mainline SCSI, is that it then continues attempting the remaining
>> 2000 sectors (or whatever) of the request, hoping that not all of
>> them are bad.
> 
> Um, but so does SCSI without your patch ... that was my point.
..

Does it?  I thought it still just failed everything after the first
bad sector?  Kudos are due if that's working now.

..
> I don't really think we'd do that.  The problem, as you say is request
> combination.  I think if we really wanted to do this, we'd have block do
> it.  Each separate request that's merged gets a separate bio, and block
> already has capabilities to pick up per bio errors, so we'd do the
> partial completion of the failing bio then skip to the next one in the
> request to try.  That would completely solve both readahead problems and
> request merging ones.
..

Yeah, that's a reasonable way to tackle.  And you're right, we *did* discuss
this back two years ago.  It just never made it as far as new code.  :)

Something else that might be good here, would be to have the md layer
pass down a (per-bio?) flag indicating whether it has redundacy capability
or not for the I/O.  Eg. healthy RAID1/4/5/10 etc.. would set the flag,
and SCSI could then just abort immediately on a bad sector, with NO retries
beyond the first bad one.

On RAID0, or a degraded (no spares) RAID1 etc, it would not set the flag,
so SCSI would try harder to recover the data, as we're discussing above.

This sounds like FAST_FAIL, but is different.  And the hint needs to
come from the upper layer that is performing redundancy.



