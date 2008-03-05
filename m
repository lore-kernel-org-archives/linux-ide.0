From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 stability and performance
Date: Wed, 05 Mar 2008 17:11:31 +0900
Message-ID: <47CE55B3.6070701@gmail.com>
References: <20080219020916.GA29902@denix.org> <20080219043659.GA11936@jim.sh> <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org> <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com> <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com> <20080304062942.GA14335@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:26227 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbYCEILu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 03:11:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1500229wah.23
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 00:11:47 -0800 (PST)
In-Reply-To: <20080304062942.GA14335@denix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>
Cc: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

Denys Dmytriyenko wrote:
> I've got the first exception (but not reset) in several days running in
> the above configuration:
> 
> Mar  3 19:09:04 [kernel] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> Mar  3 19:09:04 [kernel] ata1.00: irq_stat 0x00020002, device error via D2H FIS
> Mar  3 19:09:04 [kernel] ata1.00: cmd ef/42:fe:00:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 0
> Mar  3 19:09:04 [kernel]          res 51/04:fe:00:00:00/00:00:00:00:00/40 Emask 0x1 (device error)
> Mar  3 19:09:04 [kernel] ata1.00: configured for UDMA/100
> Mar  3 19:09:04 [kernel] ata1: EH complete
> Mar  3 19:09:04 [kernel] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> Mar  3 19:09:04 [kernel] sd 0:0:0:0: [sda] Write Protect is off
> Mar  3 19:09:04 [kernel] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> Mar  3 19:09:04 [kernel] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> 
> Is it something I should be worried about?

That's the drive rejecting acoustic setting command probably because the
drive doesn't support it.  Nothing to worry about.  More recent kernels
won't whine about those anymore.

>>> As one of the Gurus on this list, can you suggest any tweaks/settings
>>> to try out to improve/resolve my 17 MB/s write speed limit?
>> How did you test?  W/ dd?  hdparm?
> 
> # hdparm -t /dev/sda
> 
> /dev/sda:
>  Timing buffered disk reads:  170 MB in  3.03 seconds =  56.16 MB/sec

This doesn't look too bad.

> # dd if=/dev/zero of=file bs=100M count=20
> 20+0 records in
> 20+0 records out
> 2097152000 bytes (2.1 GB) copied, 117.053 s, 17.9 MB/s
> 
> # dd if=file of=file1 bs=100M count=20
> 20+0 records in
> 20+0 records out
> 2097152000 bytes (2.1 GB) copied, 161.721 s, 13.0 MB/s

Write seems awfully sluggish.  Does turning off NCQ help?  You can turn
off NCQ by echoing 1 to /sys/block/sdX/device/queue_depth.  Also, which
kernel is this test result from?

> # dd if=file of=/dev/null bs=100M count=20
> 20+0 records in
> 20+0 records out
> 2097152000 bytes (2.1 GB) copied, 34.6141 s, 60.6 MB/s

Read looks okay.

> A similar drive in an ICH7 box shows more consistent results:
> 
> # hdparm -t /dev/sda
> 
> /dev/sda:
>  Timing buffered disk reads:  182 MB in  3.01 seconds =  60.48 MB/sec
> 
> # dd if=/dev/zero of=file bs=100M count=100
> 100+0 records in
> 100+0 records out
> 10485760000 bytes (10 GB) copied, 242.908 s, 43.2 MB/s
> 
> # dd if=file of=/dev/null bs=100M count=100
> 100+0 records in
> 100+0 records out
> 10485760000 bytes (10 GB) copied, 211.132 s, 49.7 MB/s

Hmmm... indeed.  Same kernel version?  Can you post "hdparm -I" results
of both drives?

-- 
tejun
