From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Libata VIA woes continue. Worked around - *wrong*
Date: Sun, 29 Aug 2004 05:38:57 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4131A431.8080409@pobox.com>
References: <412F3DEA.2070307@wasp.net.au> <41318680.8080102@wasp.net.au> <41318C87.9010806@pobox.com> <4131910B.6020000@wasp.net.au> <41319C1F.6030207@pobox.com> <4131A0C1.3090305@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60343 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267410AbUH2JjM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Aug 2004 05:39:12 -0400
In-Reply-To: <4131A0C1.3090305@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org, linxu-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>

Brad Campbell wrote:
> Jeff Garzik wrote:
> 
>> * look at the changes from 2.6.5 -> 2.6.6 and see which change breaks 
>> things.  You can get a list of each change like this:
>>
>>     bk changes -rv2.6.5..v2.6.6
>>
>> then you can revert each patch in order, or bsearch.  Here's an 
>> example of reverting each libata patch in order:
>>
>> bk clone http://linux.bkbits.net/linux-2.5 vanilla-2.6
>> bk clone -ql -rv2.6.6 vanilla-2.6 brad-test-2.6.6
>> cd brad-test-2.6.6
>> bk -r co -Sq
>> bk changes -rv2.6.5.. > /tmp/changes-list.txt
>> less /tmp/changes-list.txt    # scan for a libata-related change
>> bk cset -x1.1587.39.2        # applies reverse of cset 1.1587.39.2
>> make                # create test
>>                 # ... test fails
>> bk cset -x1.1587.39.1        # applies reverse of cset 1.1587.39.1
>>                 # _on top of_ previous reverted patch
>> -
> 
> 
> Ooooohh. I have been looking for a "Dummies guide to regression testing 
> with BK" and not been able to find one. I have cc'd this to linux-kernel 
> purely for the purpose of more googleable archives for future reference 
> for BK newbies like me.
> 
> Cheers Jeff!
> 
> I'll start hammering on this tonight.

Groovy :)

Since BK changesets are ordered as a progression, you can also do a 
bsearch by clone trees to specific changesets, such as

bk changes -rv2.6.6..2.6.7 > /tmp/changes.txt
# view changes.txt, pick out cset 1.1587.39.1 as your "top of tree"
bk clone -r1.1587.39.1 vanilla-2.6 brad-test-2.6.6-bk
# compile and test the kernel in brad-test-2.6.6-bk

Since we're CC'ing lkml to add to the collective wisdom, maybe Larry or 
Linus have something to add, WRT tips on efficiently narrowing down a 
regression in the kernel, using BK.  I am _definitely_ not a BK wizard 
in this specific area.

	Jeff


