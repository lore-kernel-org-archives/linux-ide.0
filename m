From: GrantC <grant_nospam@dodo.com.au>
Subject: IDE channels not independent in PIIX4E?
Date: Fri, 25 Feb 2005 16:47:46 +1100
Message-ID: <e6dt11lj3pt9v7hl0luqseris0fs2kvr7v@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:63389 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262610AbVBYFry (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Feb 2005 00:47:54 -0500
Received: from [220.240.117.195] (helo=magpie.mire.mine.nu)
	by relay01.mail-hub.dodo.com.au with smtp (Exim 3.36 #2)
	id 1D4YKN-0006hb-00
	for linux-ide@vger.kernel.org; Fri, 25 Feb 2005 16:47:51 +1100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings,

I have an old but reliable Intel SE440BX-2 with 440BX and PIIX4E 
chipset.  120 + 80 GB hard drives on each channel as master, very 
disappointing md software RAID0 or RAID1 performance.

Slackware 10.1 with 2.4.29 or 2.4.30pre2, testing back to 2.4.21.

One thing I noticed is that if I start a 

  dd if=/dev/zero bs=4k of=/dev/hdX

on each drive, then Ctrl-C stop each, one terminal will wait for 
the other drive to complete the write before starting its turn 
to complete the pending write.

It seems that somewhere what I expected to be two parallel data 
streams are serialised.  As the chipset only does udma33 I was 
hoping to get an OS performance gain with RAID0.  Box has 512MB
memory and rarely touches swap.  

Is this a limit of the hardware or did I miss some kernel tuning?

Have benchmarked with tiobench -- that tells me chunk-size has 
little effect, software RAID costs about 8% CPU, and sequential 
writes cost roughly 20%, 40% and 60% for ext2, ext3 and reiserfs.

Filesystem sequential read speed improved from 17 to 25 MB/s for 
RAID0, but no improvement in write speed.

Raw (non-filesystem) dd speeds are about 27MB/s read, 20MB/s write
to non-RAID partition.  All testing done on same partitions, so 
no confusion with fast or slow end of drive.  The drives are 
Seagate 7200.7 series with 2MB cache.  

Any pointers on tuning options appreciated, the Intel datasheets 
don't really tell me much.  As for reading the kernel source, I 
have no idea where to start, not much under Docs, and I dunno 
which or which way to turn the 'knobs'.

Even search terms would be welcome :)

Thanks,
Grant.

