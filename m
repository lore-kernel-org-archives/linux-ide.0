From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 13:04:24 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406713A8.6040206@pobox.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328174013.GJ24370@suse.de> <4067101F.9030606@pobox.com> <20040328175559.GM24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60373 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262130AbUC1SEh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 13:04:37 -0500
In-Reply-To: <20040328175559.GM24370@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jens Axboe wrote:
> On Sun, Mar 28 2004, Jeff Garzik wrote:
> 
>>Jens Axboe wrote:
>>
>>>What would be nice (and I seem to recall that Andre also pushed for
>>>this) would be the FUA bit doubling as an ordered tag indicator when
>>>using TCQ. It's one of those things that keep ATA squarely outside of
>>>the big machine uses. That other OS had a differing opinion of what to
>>>do with that, so...
>>
>>Preach on, brother Jens :)
> 
> 
> I think we already lost this one, I'm afraid :-)
> 
> 
>>I agree completely.  Or, the ATA guys could use SCSI's ordered tags / 
>>linked commands.
>>
>>Regardless, there's ATA dain bramage that needs fixing...  Sigh.
> 
> 
> Indeed, and it really hurt that they passed up this oportunity last
> time, ATA TCQ would have kicked so much more ass... Maybe Eric can beat
> some sense into his colleagues.


I bet if we can come up with a decent proposal, with technical rationale 
for the change... that could be presented to the right ATA people :) 
It's worth a shot.

	Jeff



