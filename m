From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata dev_config call order wrong.
Date: Sun, 29 Aug 2004 13:59:39 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4132198B.8000504@pobox.com>
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4306 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268245AbUH2R7x
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Aug 2004 13:59:53 -0400
In-Reply-To: <413216CC.5080100@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Jeff Garzik wrote:
> 
>>
>> Take a look at what ATA_DFLAG_LOCK_SECTORS does ;-)  Here's hoping 
>> that's the last piece of the puzzle...
> 
> 
> HAHA! He says. That was not in 2.6.8.1! That solves that one.
> 
> Frankly, now I'm running a WD2500BB on one of those converters on a 
> RAID-5 I'm just going to leave the 200 sector hack in my kernel until we 
> figure out a way to detect the bridges. I can't see any other clean way 
> of doing it.

me either, unless I can figure out a way to detect that a disk is PATA 
not SATA.  Nothing is obvious from the specs on www.t13.org, but who knows.

Honestly I would prefer to apply some "if it's PATA-over-SATA bridge" 
rules, namely,
* limit to udma5 (udma/100)
* limit to 256 sectors [actually 200 in libata]


>> BTW I just sent email to SiI to see if there is a way to detect a 
>> PATA->SATA bridge.
> 
> 
> Man I hope so.. I don't want to resort to having to throw these board 
> away or constantly patch my kernel! I could just go and buy some more 
> SATA drives I guess, but where would the fun be in that!

hehe

Another option is to have a "no large transfers" module option that 
users could specify; that way you wouldn't have to patch the kernel, and 
it would work for all drivers without having to maintain a blacklist.

	Jeff


