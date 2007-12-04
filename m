From: Hein-Pieter van Braam <hp@syntomax.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Tue, 04 Dec 2007 20:21:15 +0100
Message-ID: <1196796075.6909.6.camel@liza>
References: <4751A2DA.6030403@rtr.ca>
	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>
	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>
	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>
	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>
	 <47546CF6.30301@rtr.ca> <1196722124.6362.17.camel@liza>
	 <20071203231057.39ae9b71@the-village.bc.nu> <1196726490.6362.21.camel@liza>
	 <47549A26.6080900@rtr.ca>  <1196727475.6362.27.camel@liza>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a80-126-0-120.adsl.xs4all.nl ([80.126.0.120]:56655 "EHLO
	ifolder.erca.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbXLDTYP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 14:24:15 -0500
In-Reply-To: <1196727475.6362.27.camel@liza>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>


On Tue, 2007-12-04 at 01:17 +0100, Hein-Pieter van Braam wrote:
> I'll come up with the hdparm -g output and the results of this test with
> the two different drivers tomorrow. 

Just a little status update, I've been getting some REALLY strange
results when using the disks as raid array, and I'm zeroing all the
disks now to see if that will help. I'm not using the system not anyway,
not as long as it requires the proprietary drivers to function.

(still using 2.6.23.9 + the patch that started this thread)

What I'm seeing now:
pvcreate works
pvscan doesn't work, MOST of the time, but if I say, put it in a watch
loop after a while it'll pick it up, then lose it again, then pick it up
again, sometimes complaining about corrupted meta-data
when it finally finds the pv, I get the same behavior from vgcreate,
after a while it'll work, then fail again, complaining from time to time
then vgscan, same, sometimes complaining that it can't find the volume
group, but still NAMING the volume group
then lvcreate, same deal.

I just want to rule out any screwyness of the previous data on the disk
first, and it'll take about 4 hours to wipe all 8 disks.



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

