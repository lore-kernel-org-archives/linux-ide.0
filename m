From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] fix sata_sil quirk
Date: Tue, 22 Jun 2004 18:12:38 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D8AED6.8050503@pobox.com>
References: <Pine.GSO.4.33.0406221620300.25702-200000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5537 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266022AbUFVWMy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jun 2004 18:12:54 -0400
In-Reply-To: <Pine.GSO.4.33.0406221620300.25702-200000@sweetums.bluetronic.net>
List-Id: linux-ide@vger.kernel.org
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Ricky Beam wrote:
> On Tue, 22 Jun 2004, Jeff Garzik wrote:
> 
>> Here's my suggested fix...  good catch Ricky.
> 
> 
> And I don't even know why I looked at max_sectors :-) (I need more Dew.)
> 
>> Yes, unfortunately performance will be dog slow.
> 
> 
> Well, at least puppy slow...
> Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
> sda            1811.65         0.00      9629.85          0     577887
> sdb            1807.15         0.00      9629.60          0     577872
> sdc            1807.25         0.00      9629.86          0     577888
> sdd            1807.05         0.00      9629.86          0     577888
> md_d0         14444.64         0.00     48148.84          0    2889412
> md_d0p2        9629.78         0.00     38519.11          0    2311532
> (over 60sec,  8M O_DIRECT accesses, 128 stripes * 16k RAID0)
> 
> Without the MOD15 hack, the numbers are 2x higher, but they stop after
> a few minutes :-)

Is this with my patch?

If so, I'll go ahead and forward it upstream, since I would certainly 
like a stabilization fix applied ASAP.


>> I've got contacts at Silicon Image, and have been meaning to bug them
>> for a "real fix" for a while.  It is rumored that there is a much better
>> fix, which allows full performance while at the same time not killing
>> your SATA drive due to odd-sized SATA frames on the wire.
> 
> 
> Ask them what they do in their driver? (the linux one and the windows one)
> Looking at the linux driver, the mod15 quirk is there, but there doesn't
> appear to be any associated device list. (I've already post the single
> Maxtor device listed.)  FreeBSD detects the stall, resets the chip and
> hopes that clears the problem. (People are not happy about that.)

The full-speed fix requires splitting affected DMA writes into two 
separate commands, when the sector count matches "sectors % 15 == 1".

	Jeff


