From: kilgota@banach.math.auburn.edu
Subject: Re: apparent need to blacklist Lexar flash drive in ide-dma.c
Date: Sat, 6 Oct 2007 11:51:56 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0710061139540.30775@banach.math.auburn.edu>
References: <Pine.LNX.4.64.0710051600030.29942@banach.math.auburn.edu>
 <20071006002755.37c365bf@the-village.bc.nu> <Pine.LNX.4.64.0710051841340.30041@banach.math.auburn.edu>
 <20071006105711.5ea9c0c5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from banach.math.auburn.edu ([131.204.45.3]:1532 "EHLO
	banach.math.auburn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762046AbXJFQ5o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Oct 2007 12:57:44 -0400
In-Reply-To: <20071006105711.5ea9c0c5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org



On Sat, 6 Oct 2007, Alan Cox wrote:

>> If you think that the Lexar flash drive ought to function with DMA and you
>> suspect that the problem might be in the box (which it could easily be!)
>> then I would be curious if you have any ideas what one could do about
>> that.
>
> If they didn't wire the CF slot for DMA (as sometimes happens, and the
> idea of CF cards with DMA was considered ludicrous not many years ago)
> then you'll need to be very very good with a fine soldering iron 8)
>
> Alan
>

I am good with one, but not that good. And I know some engineers around 
here who are about 10 times better than I am. But still not good enough 
for that kind of job, I think. So, OK.

But then I wonder why the DMA can be and was enabled in the BIOS and, one 
might surmise, DMA was used to access the Sandisk SDP3B-16 -- which is 
not hooked up to the CF slot at all, and which _is_ blacklisted. Strange.

Thanks, I guess that there is not much more to do with this one except to 
get everything else to work.

Cheers,
Theodore Kilgore
