From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: sata_sil24 stability and performance
Date: Sat, 15 Mar 2008 17:43:47 -0400
Message-ID: <20080315214347.GA1511@denix.org>
References: <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com>
 <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com>
 <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com>
 <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com>
 <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:41573 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbYCOVoU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 17:44:20 -0400
Received: from gandalf.denix.org ([71.126.191.34]) by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JXS00ATRJTN62KD@vms173001.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Sat, 15 Mar 2008 16:32:12 -0500 (CDT)
In-reply-to: <47CF9880.4080900@gmail.com>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

On Thu, Mar 06, 2008 at 04:08:48PM +0900, Tejun Heo wrote:
> Denys Dmytriyenko wrote:
> >>> Also, few months ago instead of sata_sil24 I had my drives connected to
> >>> sata_mv (Supermicro 8-port) and performance was normal...
> >> Everything seems okay.  I wonder where the difference is.  Does "dd
> >> if=/dev/zero of=file oflags=direct bs=1M" make any difference?  And can
> >> you vacate a raw partition and try it on there?
> > 
> > oflag=direct has no effect - same speed. Tried it on a raw /dev/sda device
> > and still no difference. It maybe slighly better, giving me 18 MB/s.
> > 
> > Can it be something with the way SiI 3124 controller is configured in the
> > system?
> 
> Hmmm... That's strange you did specify the "bs" parameter, right?  It
> should essentially give the same performance as "hdparm -t".  I wonder
> where the difference comes from.

Ok, after countless night-hours trying different configurations and peripheral 
combinations, it seems I can get good write performance (55 MB/s) from SATA 
card sitting in PCI-X slot, but bad write performance (18 MB/s) when it sits 
in PCI slot. And it is far from the PCI bandwidth limit.

I did some research and found out that apparently it is a known issue of 
AMD-760 MPX chipset. PCI-X bus is on the AMD-762 north bridge, while PCI bus 
is on the AMD-768 south bridge, which has a write bandwidth limit of 25 MB/s 
"bug", acknowledged by AMD. See these discussion threads:

http://forums.2cpu.com/showthread.php?s=c8040a4e9c9b6390dd389f1b3cca32de&threadid=31211
http://episteme.arstechnica.com/eve/forums/a/tpc/f/77909774/m/1160910035
http://forums.2cpu.com/showthread.php?s=66da493f719e8e64d15dc974cd567192&threadid=23379

Now, I have 2 options:

1. Keep existing system, but utilize 2 PCI-X slots for SATA controllers. This 
requires using 8-port adapters, like the one I already have Supermicro Marvell 
based. The question is - how stable sata_mv these days? It still says HIGHLY 
EXPERIMENTAL...

2. Replace MoBo+CPU+RAM (at least) and keep using SiI3124 based 4-port SATA 
adapters, as sata_sil24 is supposedly the most stable solution I can get.

I'm leaning towards the second option, but it would cost me more, compared 
to getting the second Marvell based PCI-X SATA card. Can you please advise? 
Thanks in advance.

Regards,
Denys
