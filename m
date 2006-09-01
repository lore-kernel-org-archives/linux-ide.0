From: Derek Taubert <taubert@geeks.org>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710, pcmcia based sata_sil24, PMP, and NCQ drive
Date: Fri, 1 Sep 2006 10:24:35 -0700
Message-ID: <20060901172435.GA26975@geeks.org>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org> <44F440BE.80000@gmail.com> <20060829164424.GA1603@geeks.org> <44F8365C.2020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jacobs.geeks.org ([204.153.247.1]:30180 "EHLO mail.geeks.org")
	by vger.kernel.org with ESMTP id S1751162AbWIARYp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Sep 2006 13:24:45 -0400
Content-Disposition: inline
In-Reply-To: <44F8365C.2020609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Derek Taubert <taubert@geeks.org>, linux-ide@vger.kernel.org

On Fri, Sep 01, 2006 at 10:32:12PM +0900, Tejun Heo wrote:
> ># dd if=/dev/zero of=/dev/sda1 bs=4M count=512
> >
> >avg-cpu:  %user   %nice    %sys %iowait   %idle
> >           0.90    0.00    1.30   97.80    0.00
> >
> >Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
> >sda              15.00         0.00      1920.00          0      19200
> 
> Hmm... this really is weird.  FYI, you're the first to report such 
> problem.  As Jeff said, turning off write-back caching can have adverse 
> effect on write performance, but, then again, you previously reported 
> that the command queue is full.  Please update us on the write-back stuff.

>From searching the list archive, I gather this is controlled by "hdparm
-W"?

root@linux-srv:~ # hdparm -W 1 /dev/sda1                      

/dev/sda1:
 setting drive write-caching to 1 (on)
root@linux-srv:~ # dd if=/dev/zero of=/dev/sda1 bs=1M count=100
100+0 records in
100+0 records out
104857600 bytes (105 MB) copied, 53.8702 seconds, 1.9 MB/s
root@linux-srv:~ # hdparm -W 0 /dev/sda1                       

/dev/sda1:
 setting drive write-caching to 0 (off)
root@linux-srv:~ # dd if=/dev/zero of=/dev/sda1 bs=1M count=100
100+0 records in
100+0 records out
104857600 bytes (105 MB) copied, 53.7884 seconds, 1.9 MB/s

I'm going to try narrowing the scope of the test next.  Will purchase
an eSATA<->SATA cable today and try bypassing the port multiplier.

If that works, I'll try using one drive at a time on the PMP.

Thanks,
Derek
