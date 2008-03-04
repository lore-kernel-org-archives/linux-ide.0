From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: sata_sil24 stability and performance
Date: Mon, 03 Mar 2008 19:22:15 -0500
Message-ID: <20080304002215.GA13317@denix.org>
References: <20080219020916.GA29902@denix.org> <20080219043659.GA11936@jim.sh>
 <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org>
 <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:64808 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758976AbYCDAWR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 19:22:17 -0500
Received: from gandalf.denix.org ([71.255.237.139])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JX600D3ZJP45VD1@vms042.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 03 Mar 2008 18:22:17 -0600 (CST)
In-reply-to: <47CC9197.9050609@gmail.com>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

On Tue, Mar 04, 2008 at 09:02:31AM +0900, Tejun Heo wrote:
> Hello, Gabor.
> 
> Gabor FUNK wrote:
> > I have/had a similar (hard resetting) problem (2+8 disks, kernel
> > 2.6.24), see thread:
> > http://www.mail-archive.com/linux-ide@vger.kernel.org/msg15950.html
> > 
> > I tried replacing the PSU and also run the system with two 650W PSU-s,
> > also failed. I also think that PSU shouldn't be the problem as I see they
> > eat much less in operation than at spinup.
> 
> It's not that simple tho.  Some PSUs which happily spin up all the
> drives simultaneously have problems maintaining stable operation
> afterwards.  Anyways, if you used two separate PSUs, and didn't see any
> change in failure pattern (ie. drives connected to certain PSU fails or
> swapping to which PSU the board is connected alleviates the problem),
> it's probably safe to say it's not PSU problem.

Gabor,

I am pretty much convinced at this point that my exceptions/resetting
problem is due to the PSU. I've been testing different configurations
lately and was able to get stable system powering 14 (!) drives by both
PSUs together. The limiting factor is Amps on a single +12V rail:
Coolermaster 750 limits single rail to 19A (6 drives @ 2.8A/drive) and
my old Enermax 550 has 24A limit (8 drives @ 2.8A/drive). Even though
Coolermaster 750 has 4 rails, the wiring is not optimal and only 1 rail
is available for the hard drives...

See item #8 here:
http://www.pcpower.com/technology/myths/

I am going to try their single-rail Silencer 750, rated at 60A.

That said, I'm still puzzled with the low write performance issue.

Tejun,

As one of the Gurus on this list, can you suggest any tweaks/settings
to try out to improve/resolve my 17 MB/s write speed limit?

I played with different PCI latencies, read FAQ topic on 32-bit
I/O support in libata and ran out of ideas... Please help :)

Regards,
Denys
