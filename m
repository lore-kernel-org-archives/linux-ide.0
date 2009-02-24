From: Mark Lord <liml@rtr.ca>
Subject: Re: strange hdparm results with serverworks and pata-serverworks
Date: Tue, 24 Feb 2009 08:29:30 -0500
Message-ID: <49A3F63A.2080805@rtr.ca>
References: <49A30901.1@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:41978 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbZBXN3d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Feb 2009 08:29:33 -0500
In-Reply-To: <49A30901.1@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-ide@vger.kernel.org

Tomasz Chmielewski wrote:
> I have a ProLiant BL30p G1 machine running Debian Lenny (2.6.26 kernel).
> 
> It also has two identical, 2.5 inch WDC WD2500BEVE-00WZT0 IDE drives 
> (new drives, no smart/badblock errors). Both drives are connected to a 
> single IDE channel this machine has.
> 
> "hdparm -t" gives me different results for these drives: ~10 MB/s for 
> hda, and ~20 MB/s for hdb with "serverworks" driver on Debian's 2.6.26 
> kernel.
> When using "pata-serverworks" with 2.6.28.7 kernel, hdparm shows the 
> same results (~10 MB/s for sda, ~20 MB/s for sdb).
> 
> 
> However, when I run "dd if=/dev/sda of=/dev/null bs=64k", I can see with 
> iostat that for the first 7-8 seconds, reads are with ~10 MB/s speed. 
> Then, reads from sda are with ~20 MB/s or more and are on par with sdb.
> 
> Similar dd test for sdb shows that it delivers with speed of ~20 MB/s 
> from the first second.
> 
> Is there an explanation for that?
..

Well, as you have shown, both hdparm and dd give the same results
when doing (almost) the same test:  the first 3 seconds are slow.

After that, I would assume that the kernel read-ahead algorithms
kick in better and improve things.

But 10-20Mbytes/sec is slow for most modern drives,
even for 2.5" drives.  Older ones, sure, that's fine,
but the newest 2.5" drives should score between 40
and 100Mbytes/sec.

The drive you listed is a WD 250GB mobile drive, PATA interface.
I have a very similar WD drive here (WD2500BEAS) that regularly
tops 60Mbytes/sec with "hdparm -t".

The difference could easily be in the chipset used to communicate
with the drive.  You said "serverworks" driver, and "pata-serverworks".
The kernel start up logs will have more information,
including the timing info chosen by libata.

Cheers
