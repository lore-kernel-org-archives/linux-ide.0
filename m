From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Libata VIA woes continue. Worked around - *wrong*
Date: Sun, 29 Aug 2004 03:57:59 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41318C87.9010806@pobox.com>
References: <412F3DEA.2070307@wasp.net.au> <41318680.8080102@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59059 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267330AbUH2H6N
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Aug 2004 03:58:13 -0400
In-Reply-To: <41318680.8080102@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Brad Campbell wrote:
> 
>> Ok, so after a couple of reboots with max_sector set to 200 the 
>> problem re-occurs.
>>
>> It must be something to do with programming the controller or timing 
>> or some other issue.
>>
>> I have worked around it by putting my 2 raid-0 drives on my spare 
>> promise ports, and at UDMA100 with transfers of 2048 sectors they 
>> behave fine no matter what I throw at them.
> 
> 
> Scratch that. After a couple of days if intensive testing/rebooting and 
> abuse they play up on the
> Promise controller in exactly the same failure mode. Just far harder to 
> trigger.
> 
> I have removed these bridge board from my system now and thus the 
> problem no longer exists. I'm a
> little concerned that this might show itself for other people in the 
> future but then I guess most
> sane people buy SATA hard disks rather than re-use old ATA drives with 
> bridge boards.

Well, there are some cases on a few controllers (SiI is one that comes 
to mind) where -- IIRC -- bridges dictate the max is UDMA/100, not 
UDMA/133, even if the underlying device is UDMA/133.

In sata_promise.c or sata_via.c, what happens if you change udma_mask 
from 0x7f to 0x3f?  Do the failures go away?


> Cross that bridge if we come to it I guess.

Guffaw ;-)

	Jeff


