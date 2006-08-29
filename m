From: Derek Taubert <taubert@geeks.org>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710, pcmcia based sata_sil24, PMP, and NCQ drive
Date: Mon, 28 Aug 2006 21:58:16 -0700
Message-ID: <20060829045816.GA21746@geeks.org>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jacobs.geeks.org ([204.153.247.1]:17918 "EHLO mail.geeks.org")
	by vger.kernel.org with ESMTP id S1750863AbWH2E6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2006 00:58:19 -0400
Content-Disposition: inline
In-Reply-To: <44F3A8FD.6090108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Derek Taubert <taubert@geeks.org>, linux-ide@vger.kernel.org

On Tue, Aug 29, 2006 at 11:39:57AM +0900, Tejun Heo wrote:
> Derek Taubert wrote:
> ># dd if=/dev/zero of=/dev/sda1 count=4M
> ><ctrl-c, then wait 30 seconds>
> >264205+0 records in
> >264204+0 records out
> >135272448 bytes (135 MB) copied, 111.373 seconds, 1.2 MB/s
> >
> >From iostat -k 10:
> >Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
> >sda            2428.64      2422.46       667.66      24273       6690
> >sda              36.84        23.72      1667.87        237      16662
> >sda            2440.60      2434.90       616.00      24349       6160
> >The read rate is curious (should be 0)...
> >
> >Top shows 1% user, 3% system, 93% wait.
> 
> It seems some kind of read IO is in progress.  Can you repeat the test 
> on an unused/idle (iostat -k 10 shows all zeros...) drive?  The above 
> result actually looks good if you consider both read and write sides. 

I think that 3MBytes/sec total for a drive that can read at 50MBytes/sec
on the same system is quite bad, especially since we're talking about
a linear write test.


> The result doesn't seem to indicate any problem in libata or any storage 
> related kernel subsystem.  I would track down the reader first.

This drive has only been partitioned; there is no filesystem on it.  So,
it certainly isn't mounted anywhere.  There honestly isn't _anything_
other than the dd going on to sda1, and that's the only partition on
sda.


> >2) hdparm -C for all 4 drives always shows "drive state is:  standby"
> >   even when I'm certain that the drives are active.
> 
> hdparm -C says the same thing for my drive.  I think it's safe to 
> ignore.  Hmmm... it needs to be tracked down.  Maybe some problem in 
> HDIO ioctl implementation in libata.

It's a "nice to have" for using smartd.  ie: don't spin the drives up to
poll the failure attributes, but they should be checked if the drive's
already active.


> >I'd really like some assistance debugging the write performance issue.
> >The "hdparm -C" issue would be gravy...
> 
> Please track down the reader.

Before running dd (fuser -v /dev/sda1 shows nothing):

avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.50    0.00    0.20    0.00   99.30

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
fd0               0.00         0.00         0.00          0          0
hda               0.00         0.00         0.00          0          0
md0               0.00         0.00         0.00          0          0
md1               0.00         0.00         0.00          0          0
sda               0.00         0.00         0.00          0          0
sdb               0.00         0.00         0.00          0          0
sdc               0.00         0.00         0.00          0          0
sdd               0.00         0.00         0.00          0          0

After starting dd:

# fuser -v /dev/sda1

                     USER        PID ACCESS COMMAND
/dev/sda1            root      21753 f....  dd

avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.90    0.00   11.01   88.09    0.00

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
fd0               0.00         0.00         0.00          0          0
hda               0.10         0.00         0.40          0          4
md0               0.00         0.00         0.00          0          0
md1               0.00         0.00         0.00          0          0
sda            1306.61      1295.60      1310.11      12943      13088
sdb               0.00         0.00         0.00          0          0
sdc               0.00         0.00         0.00          0          0
sdd               0.00         0.00         0.00          0          0

After stopping dd (fuser -v /dev/sda1 again shows nothing):

avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.80    0.00    0.30    0.00   98.90

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
fd0               0.00         0.00         0.00          0          0
hda               1.00         0.00         5.21          0         52
md0               0.00         0.00         0.00          0          0
md1               0.00         0.00         0.00          0          0
sda               0.00         0.00         0.00          0          0
sdb               0.00         0.00         0.00          0          0
sdc               0.00         0.00         0.00          0          0
sdd               0.00         0.00         0.00          0          0

I'm honestly not sure what else to check...

Thanks for your response,
Derek
