From: linux@horizon.com
Subject: Re: sata_sil24 corruption details
Date: 10 Nov 2005 10:26:42 -0500
Message-ID: <20051110152642.30875.qmail@science.horizon.com>
References: <43735C19.4040402@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:49724 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750837AbVKJP0s
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 10:26:48 -0500
In-Reply-To: <43735C19.4040402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: axboe@suse.de, greg.freemyer@gmail.com, htejun@gmail.com
Cc: linux-ide@vger.kernel.org, linux@horizon.com

> I'll run single drive test on sil3112 tonight, but can you please try 
> 2.6.14?  IIRC, there have been some PCI FIFO setting change.  Hmmm.. 
> oh.. it was the following commit.

I was running a post-2.6.14 libata-dev kernel, but my root file system
got corrupted, and the "emergency backup" boot image that I've
been using is 2.6.13 + libata patches.

You asked about bad block patterns...

I ran the test on three dirves at once (hdb, hdc, hdd), and the former
had no problems, while the latter two reported the following
bad blocks.  Note that these are 4096-byte block numbers relative to
a partition starting at sector 91795410.

The whole partition has 687662325 sectors, or 85957790.625 blocks.

Of those, the first pass of "badblocks -b 4096 -c 32768 -w -t random -p1"
found:

11 "bad blocks" in one pass over /dev/sdc4:
 4265401 
23598860
31564978
33854103
35258513
44588559
45069578
59358213
59554821
70448351
73983236

and 13 "bad blocks" in one pass over /dev/sdd4:
  226244  
 6595957 
 7402436 
 9464777 
14395278
14862235
15085611
16072105
16796706
26095323
39376782
46807588
51765692

It's doing a second write pass now.


It found no problems on /dev/sdb4 while there was no particular traffic on
/dev/sda.  I'm doing a run with sda and sdb in parallel.


Anyway, thanks a lot for the attention.
