From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: sata_sil24 stability and performance
Date: Thu, 06 Mar 2008 01:55:13 -0500
Message-ID: <20080306065513.GE7150@denix.org>
References: <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org>
 <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com>
 <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com>
 <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com>
 <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61703 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYCFGz1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 01:55:27 -0500
Received: from gandalf.denix.org ([71.251.63.52]) by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JXA00EUCR3BWACL@vms173003.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Thu, 06 Mar 2008 00:52:24 -0600 (CST)
In-reply-to: <47CF7222.7060702@gmail.com>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

On Thu, Mar 06, 2008 at 01:25:06PM +0900, Tejun Heo wrote:
> Denys Dmytriyenko wrote:
> > 
> > Turning off NCQ does not help. I am currently on 2.6.23.9, but I just tried
> > 2.6.25-rc4 and it is the same.
> > 
> >>> A similar drive in an ICH7 box shows more consistent results:
> >>>
> >>> # hdparm -t /dev/sda
> >>>
> >>> /dev/sda:
> >>>  Timing buffered disk reads:  182 MB in  3.01 seconds =  60.48 MB/sec
> >>>
> >>> # dd if=/dev/zero of=file bs=100M count=100
> >>> 100+0 records in
> >>> 100+0 records out
> >>> 10485760000 bytes (10 GB) copied, 242.908 s, 43.2 MB/s
> >>>
> >>> # dd if=file of=/dev/null bs=100M count=100
> >>> 100+0 records in
> >>> 100+0 records out
> >>> 10485760000 bytes (10 GB) copied, 211.132 s, 49.7 MB/s
> >> Hmmm... indeed.  Same kernel version?  Can you post "hdparm -I" results
> >> of both drives?
> > 
> > The kernel on the second box is also 2.6.23.9. Here are hdparm results for
> > identical drives:
> > 
> > 1. Connected to SiI 3124/sata_sil24 w/ slow write:
> > 
> > # hdparm -I /dev/sda
> > 
> > /dev/sda:
> > 
> > ATA device, with non-removable media
> >         Model Number:       WDC WD1600JS-75NCB1
> >         Serial Number:      WD-WCANM1344866
> >         Firmware Revision:  10.02E01
> > 
> > # hdparm -I /dev/sda
> > 
> > /dev/sda:
> > 
> > ATA device, with non-removable media
> >         Model Number:       WDC WD1600JS-75NCB1
> >         Serial Number:      WD-WCANM1356774
> >         Firmware Revision:  10.02E01
> > 
> > Also, few months ago instead of sata_sil24 I had my drives connected to
> > sata_mv (Supermicro 8-port) and performance was normal...
> 
> Everything seems okay.  I wonder where the difference is.  Does "dd
> if=/dev/zero of=file oflags=direct bs=1M" make any difference?  And can
> you vacate a raw partition and try it on there?

oflag=direct has no effect - same speed. Tried it on a raw /dev/sda device
and still no difference. It maybe slighly better, giving me 18 MB/s.

Can it be something with the way SiI 3124 controller is configured in the
system?

Regards,
Denys
