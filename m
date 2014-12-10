From: Tim Small <tim@seoss.co.uk>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Wed, 10 Dec 2014 15:43:03 +0000
Message-ID: <54886A07.5080307@seoss.co.uk>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>	 <20141204170611.GB2995@htj.dyndns.org> <yq14mtahmil.fsf@sermon.lab.mkp.net>	 <20141205145148.GI4080@htj.dyndns.org> <1418184578.2121.3.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay0.allsecuredomains.com ([78.129.187.18]:59180 "EHLO
	relay0.allsecuredomains.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757931AbaLJQLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Dec 2014 11:11:40 -0500
In-Reply-To: <1418184578.2121.3.camel@HansenPartnership.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org


On 10/12/14 04:09, James Bottomley wrote:

> RAID requires that the redundancy verification of the array 
> components matches otherwise a verify of the RAID fails.  This means
> we have to have a guarantee what the verify read of a trimmed block
> of a RAID component will return. So for RAID-1, we just need both
> trimmed components to return the same data (we don't actually care
> what it is, just that it be mirrored);


FWIW, Unless I'm out-of-date, md RAID-1 and RAID-10 currently DON'T
guarantee that the data is always mirrored.  The md(4) man page from
http://git.neil.brown.name/?p=mdadm.git;a=blob;f=md.4 says:

> However on RAID1 and RAID10 it is possible for software issues to 
> cause a mismatch to be reported.  This does not necessarily mean
> that the data on the array is corrupted.  It could simply be that
> the system does not care what is stored on that part of the array -
> it is unused space.
> 
> The most likely cause for an unexpected mismatch on RAID1 or RAID10 
> occurs if a swap partition or swap file is stored on the array.
> 
> When the swap subsystem wants to write a page of memory out, it
> flags the page as 'clean' in the memory manager and requests the
> swap device to write it out.  It is quite possible that the memory
> will be changed while the write-out is happening.  In that case the
> 'clean' flag will be found to be clear when the write completes and
> so the swap subsystem will simply forget that the swapout had been 
> attempted, and will possibly choose a different page to write out.
> 
> If the swap device was on RAID1 (or RAID10), then the data is sent 
> from memory to a device twice (or more depending on the number of 
> devices in the array).  Thus it is possible that the memory gets 
> changed  between the times it is sent, so different data can be 
> written to the different devices in the array.  This will be
> detected by check as a mismatch.  However it does not reflect any
> corruption as the block where this mismatch occurs is being treated
> by the swap system as being empty, and the data will never be read
> from that block.
> 
> It is conceivable for a similar situation to occur on non-swap
> files, though it is less likely.



In my experience these inconsistencies are very common in data written
by certain applications (e.g. DBMS) on md RAID1 and RAID10 devices, and
effectively makes md verify useless for them.  This is a shame -
particularly with things like FTLs where (at least anecdotally) data
scrambling seems to be a reasonably frequent occurrence.

So unreliable read-zero-on-TRIM isn't going to break the md RAID-1 /
RAID-10 use-case significantly, because verify hasn't worked on those
forever anyway.

Of course, a non-deterministic return-zero-on-trim will still cause
problems with md RAID5/6, and with other users such as dm RAID too I'd
guess.

Tim.
