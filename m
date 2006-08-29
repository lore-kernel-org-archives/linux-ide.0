From: Derek Taubert <taubert@geeks.org>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710, pcmcia based sata_sil24, PMP, and NCQ drive
Date: Tue, 29 Aug 2006 09:44:24 -0700
Message-ID: <20060829164424.GA1603@geeks.org>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org> <44F440BE.80000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jacobs.geeks.org ([204.153.247.1]:32473 "EHLO mail.geeks.org")
	by vger.kernel.org with ESMTP id S965103AbWH2Qo0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2006 12:44:26 -0400
Content-Disposition: inline
In-Reply-To: <44F440BE.80000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Derek Taubert <taubert@geeks.org>, linux-ide@vger.kernel.org

On Tue, Aug 29, 2006 at 10:27:26PM +0900, Tejun Heo wrote:
> >>>2) hdparm -C for all 4 drives always shows "drive state is:  standby"
> >>>  even when I'm certain that the drives are active.
> >>hdparm -C says the same thing for my drive.  I think it's safe to 
> >>ignore.  Hmmm... it needs to be tracked down.  Maybe some problem in 
> >>HDIO ioctl implementation in libata.
> >
> >It's a "nice to have" for using smartd.  ie: don't spin the drives up to
> >poll the failure attributes, but they should be checked if the drive's
> >already active.
> 
> I don't really understand what you mean.  Can you elaborate?

Sure.  See the "-n standby" option here:

http://smartmontools.sourceforge.net/man/smartd.conf.5.html

If the driver always reports "standby", then smartd effectively won't
monitor the device if "-n standby" is configured.

Now I can certainly eliminate the -n option from smartd.conf, but
then smartd will cause the drive(s) to spin up when it polls (see the
-p, -u, -t options).


> >>>I'd really like some assistance debugging the write performance issue.
> >>>The "hdparm -C" issue would be gravy...
> >>Please track down the reader.
> >
> >Before running dd (fuser -v /dev/sda1 shows nothing):
> [--snip--]
> 
> Can you try 'dd if=/dev/zero of=/dev/sdX bs=4M count=1'?

Increasing the block size eliminates the reads (presumably because the
block driver doesn't have to fetch lines to read/modify/write), but the
write throughput is still very slow:

# dd if=/dev/zero of=/dev/sda1 bs=4M count=512

avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.90    0.00    1.30   97.80    0.00

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
fd0               0.00         0.00         0.00          0          0
hda               0.20         0.80         0.00          8          0
md0               0.00         0.00         0.00          0          0
md1               0.00         0.00         0.00          0          0
sda              15.00         0.00      1920.00          0      19200
sdb               0.00         0.00         0.00          0          0
sdc               0.00         0.00         0.00          0          0
sdd               0.00         0.00         0.00          0          0


Compare that with:

# dd of=/dev/null if=/dev/sda1 bs=4M count=512

avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.50    0.00   78.10   21.40    0.00

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
fd0               0.00         0.00         0.00          0          0
hda               1.10         4.40         0.00         44          0
md0               0.00         0.00         0.00          0          0
md1               0.00         0.00         0.00          0          0
sda             426.70     51532.80         0.00     515328          0
sdb               0.00         0.00         0.00          0          0
sdc               0.00         0.00         0.00          0          0
sdd               0.00         0.00         0.00          0          0

Derek
