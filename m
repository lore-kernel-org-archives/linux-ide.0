From: Colin Watson <cjwatson@ubuntu.com>
Subject: Re: [RFT] libata hpa support
Date: Fri, 23 Feb 2007 18:23:37 +0000
Message-ID: <20070223182336.GI31945@riva.ucam.org>
References: <20070223181959.56502bf2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from doppler.zen.co.uk ([212.23.3.27]:36158 "EHLO doppler.zen.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933190AbXBWT1P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 14:27:15 -0500
Received: from [212.23.3.140] (helo=pythagoras.zen.co.uk)
	by doppler.zen.co.uk with esmtp (Exim 4.50)
	id 1HKf73-0007Zi-Kz
	for linux-ide@vger.kernel.org; Fri, 23 Feb 2007 18:25:45 +0000
Content-Disposition: inline
In-Reply-To: <20070223181959.56502bf2@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Kyle McMartin <kyle@canonical.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

Alan wrote:
> > A few questions are raised, libata SATA hasn't been resizing disks in the
> > past, should we only disable HPA on PATA only, a la drivers/ide? In any
> 
> drivers/ide disable HPA on SATA ports it manages too.
> 
> > event, supporting HPA lets people who had partitions which extend beyond
> > the protected area boot with libata PATA. Some policy decision needs to be
> > made too... Right now, I'm just disabling it unilaterally.
> 
> Last time we had a Red Hat bitching session about it the main thing the
> installer guys wanted was a way to find out what size the disk thought it
> was before we twiddled with it, so that they can make an intelligent
> attempt to handle partitioning in the case where for example a disk is
> unpartitioned. A partitioned disk isn't so much of a problem as the
> partitioning itself tells you the a lot about the state of disk and
> intended HPA.
> 
> What do the Ubuntu installer/partitioning folk think ?

Suspiciously similar to the Red Hat installer folks. :-) Our partitioner
(and Debian's) asks libparted to create a partition table in memory
(ped_disk_new_fresh) and then works entirely based on what libparted
reports about that partition table before actually committing it. This
obviously only works if you can find out the size of the disk before
writing anything to it.

libparted uses ioctl(BLKGETSIZE[64]) to get the size of the disk at the
moment. Making that report the non-HPA size would be enough to make
libparted create new partition tables properly, but it would defeat the
purpose of Kyle's patch in that you probably couldn't use libparted to
work with existing partition tables extending beyond the HPA. Adding say
ioctl(BLKGETNONHPASIZE) or something and teaching libparted to create
new partition tables excluding the HPA but still be able to read
existing partition tables extending into the HPA seems like it'd be the
best approach, and sounds pretty straightforward. I'd be happy to do the
libparted side of that.

-- 
Colin Watson                                       [cjwatson@ubuntu.com]
