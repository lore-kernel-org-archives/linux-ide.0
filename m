From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Libata VIA woes continue. Worked around - *wrong*
Date: Sun, 29 Aug 2004 05:04:31 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41319C1F.6030207@pobox.com>
References: <412F3DEA.2070307@wasp.net.au> <41318680.8080102@wasp.net.au> <41318C87.9010806@pobox.com> <4131910B.6020000@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27318 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267410AbUH2JEt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Aug 2004 05:04:49 -0400
In-Reply-To: <4131910B.6020000@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Jeff Garzik wrote:
> 
>>
>> Well, there are some cases on a few controllers (SiI is one that comes 
>> to mind) where -- IIRC -- bridges dictate the max is UDMA/100, not 
>> UDMA/133, even if the underlying device is UDMA/133.
>>
>> In sata_promise.c or sata_via.c, what happens if you change udma_mask 
>> from 0x7f to 0x3f?  Do the failures go away?
> 
> 
> These drives are UDMA/100. On the VIA controller I changed the udma_mask 
> to 0x1f and the failures "appeared" to go away but that was before I 
> realised the exact nature of the failure mode. (That being it will 
> either fail on bootup, or very soon after or it will work perfectly 
> until the next boot)
> 
> I can always hook the drives up and hammer them if you'd like me to do 
> further testing but I'm not sure how we can then let libata know that 
> the drives connected need to be slowed down as we can't identify we have 
> a bridge connected really.
> 
> I'm still not convinced that it's not something else.
> Sure transfers > 200 sectors killed it on the VIA controller at UDMA/100 
> while they appeared to work ok at UDMA/66. I guess I need to run a 
> defined array of tests.
> 
> - Large transfers (> 200) at UDMA/100 and UDMA/66
> - Small transfers (<=200) at UDMA/100 and UDMA/66
> - Something like 10 reboot cycles of each.
> 
> It's very hard to hit on the Promise controller (Perhaps < 10% of 
> reboots) while on the VIA controller it happens maybe 60% of the time.
> 
> And of course 2.6.5 never hits it at all. (And given I patched the VIA 
> driver in 2.6.9-rc1 to keep transfers < 200 sectors and still hit the 
> bug it's not that!)

Well, if you are completely unable to reproduce in 2.6.5, there are a 
couple things to try:

* copy drivers/scsi/libata*, drivers/scsi/sata_*, 
drivers/scsi/ata_piix.c, include/linux/libata.h, include/linux/ata.h 
from 2.6.9-rc1-bk into 2.6.5, and see if you can reproduce the failure. 
  (I can help if there are any compile/API problems you can't figure 
out)  That will eliminate non-libata changes at least.

* look at the changes from 2.6.5 -> 2.6.6 and see which change breaks 
things.  You can get a list of each change like this:

	bk changes -rv2.6.5..v2.6.6

then you can revert each patch in order, or bsearch.  Here's an example 
of reverting each libata patch in order:

bk clone http://linux.bkbits.net/linux-2.5 vanilla-2.6
bk clone -ql -rv2.6.6 vanilla-2.6 brad-test-2.6.6
cd brad-test-2.6.6
bk -r co -Sq
bk changes -rv2.6.5.. > /tmp/changes-list.txt
less /tmp/changes-list.txt	# scan for a libata-related change
bk cset -x1.1587.39.2		# applies reverse of cset 1.1587.39.2
make				# create test
				# ... test fails
bk cset -x1.1587.39.1		# applies reverse of cset 1.1587.39.1
				# _on top of_ previous reverted patch
