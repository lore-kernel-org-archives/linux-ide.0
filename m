From: Trevor Cordes <trevor@tecnopolis.ca>
Subject: ide dma bug?
Date: Sun, 4 Sep 2005 15:18:44 -0500
Message-ID: <20050904201844.GA12464@pog.tecnopolis.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from S0106000092a70907.wp.shawcable.net ([24.76.183.245]:29569 "EHLO
	pog.tecnopolis.ca") by vger.kernel.org with ESMTP id S1751086AbVIDUSp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Sep 2005 16:18:45 -0400
Received: from pog.tecnopolis.ca (pog.tecnopolis.ca [127.0.0.1])
	by pog.tecnopolis.ca (8.13.1/8.13.1) with ESMTP id j84KIi6k012672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 4 Sep 2005 15:18:44 -0500
Received: (from trevor@localhost)
	by pog.tecnopolis.ca (8.13.1/8.13.1/Submit) id j84KIibB012671
	for linux-ide@vger.kernel.org; Sun, 4 Sep 2005 15:18:44 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm getting a couple of times every couple of days:

Sep  1 07:09:53 piles kernel: hdq: dma_intr: bad DMA status (dma_stat=75)
Sep  1 07:09:53 piles kernel: hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
Sep  1 07:09:53 piles kernel: ide: failed opcode was: unknown
Sep  1 07:10:26 piles kernel: hdr: dma_intr: bad DMA status (dma_stat=75)
Sep  1 07:10:26 piles kernel: hdr: dma_intr: status=0x50 { DriveReady SeekComplete }
Sep  1 07:10:26 piles kernel: ide: failed opcode was: unknown
Sep  3 19:41:36 piles kernel: hdt: dma_intr: bad DMA status (dma_stat=75)
Sep  3 19:41:36 piles kernel: hdt: dma_intr: status=0x50 { DriveReady SeekComplete }
Sep  3 19:41:36 piles kernel: ide: failed opcode was: unknown

It's my franken-computer file-server that has 12 IDE PATA drives running a
combo of RAID6 and RAID0 (and a little RAID1).  They're running off of the
onboard Intel 845D IDE, onboard Promise PDC20276 (used only as a simple
IDE controller), 1 Promise Ultra100 TX2 PDC20268, and 2 CMD680-based
cards.  8 drives are 250GB (3 diff brands -- on purpose!), 4 are 160GB. 
The 8 250's are all IDE masters.  The 4 160's share 2 IDE channels
(master+slave).

The 160's are hdq, hdr, hds, and hdt.  Those are the ONLY drives that show
these intermittent dma errors.  Obviously the problem has to do with using
some drives as slaves.  I was reluctant to put in another IDE card (having
so many already scares me), but have one on order right now.  I'm hoping
having them all on master will alleviate this problem.

Note, besides the log messages, I see no other symptoms.  The RAID array 
stays up and things seem to run fine.  However, a friend said to me the 
following and so I write this email:

"Not good... means you've got DMA problems.  Possibly related to 
having too many scatter-gather operations pending simultaneously all 
being triggered off one or two IRQs... ???  I'd post to either ATA or 
Kernel or RAID mailing lists and ask for opinions, since that's a 
potential BIG problem in terms of CPU usage."

"What you're telling me about those disks tells me that there's a slight 
bug in the driver code - basically straggler interrup handler looks for 
DMA results, sees bogosity, checks drive for errors and print message 
about bad-DMA-but-drives-are-fine."

My kernel is 2.6.12-1.1372_FC3

My hdparm's are all identical:
#hdparm /dev/hds
/dev/hds:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
