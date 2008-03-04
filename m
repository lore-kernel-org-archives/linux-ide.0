From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 04 Mar 2008 01:29:43 -0500
Message-ID: <20080304062942.GA14335@denix.org>
References: <20080219020916.GA29902@denix.org> <20080219043659.GA11936@jim.sh>
 <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org>
 <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com>
 <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59791 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbYCDGaQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 01:30:16 -0500
Received: from gandalf.denix.org ([71.255.237.139])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JX700LT00PKP122@vms046.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Tue, 04 Mar 2008 00:29:44 -0600 (CST)
In-reply-to: <47CCC1C6.5010600@gmail.com>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

On Tue, Mar 04, 2008 at 12:28:06PM +0900, Tejun Heo wrote:
> > I am pretty much convinced at this point that my exceptions/resetting
> > problem is due to the PSU. I've been testing different configurations
> > lately and was able to get stable system powering 14 (!) drives by both
> > PSUs together. The limiting factor is Amps on a single +12V rail:
> > Coolermaster 750 limits single rail to 19A (6 drives @ 2.8A/drive) and
> > my old Enermax 550 has 24A limit (8 drives @ 2.8A/drive). Even though
> > Coolermaster 750 has 4 rails, the wiring is not optimal and only 1 rail
> > is available for the hard drives...
> > 
> > See item #8 here:
> > http://www.pcpower.com/technology/myths/
> 
> Ah... yeah, that's what I've been saying all along.  Fancy powers w/
> multiple 12v rails suck for storage array.  My 15$ no name single lane
> PSU works much better than 40$ dual lane one.

I've got the first exception (but not reset) in several days running in
the above configuration:

Mar  3 19:09:04 [kernel] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Mar  3 19:09:04 [kernel] ata1.00: irq_stat 0x00020002, device error via D2H FIS
Mar  3 19:09:04 [kernel] ata1.00: cmd ef/42:fe:00:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 0
Mar  3 19:09:04 [kernel]          res 51/04:fe:00:00:00/00:00:00:00:00/40 Emask 0x1 (device error)
Mar  3 19:09:04 [kernel] ata1.00: configured for UDMA/100
Mar  3 19:09:04 [kernel] ata1: EH complete
Mar  3 19:09:04 [kernel] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
Mar  3 19:09:04 [kernel] sd 0:0:0:0: [sda] Write Protect is off
Mar  3 19:09:04 [kernel] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Mar  3 19:09:04 [kernel] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Is it something I should be worried about?

> > Tejun,
> > 
> > As one of the Gurus on this list, can you suggest any tweaks/settings
> > to try out to improve/resolve my 17 MB/s write speed limit?
> 
> How did you test?  W/ dd?  hdparm?

# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  170 MB in  3.03 seconds =  56.16 MB/sec

# dd if=/dev/zero of=file bs=100M count=20
20+0 records in
20+0 records out
2097152000 bytes (2.1 GB) copied, 117.053 s, 17.9 MB/s

# dd if=file of=file1 bs=100M count=20
20+0 records in
20+0 records out
2097152000 bytes (2.1 GB) copied, 161.721 s, 13.0 MB/s

# dd if=file of=/dev/null bs=100M count=20
20+0 records in
20+0 records out
2097152000 bytes (2.1 GB) copied, 34.6141 s, 60.6 MB/s

A similar drive in an ICH7 box shows more consistent results:

# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  182 MB in  3.01 seconds =  60.48 MB/sec

# dd if=/dev/zero of=file bs=100M count=100
100+0 records in
100+0 records out
10485760000 bytes (10 GB) copied, 242.908 s, 43.2 MB/s

# dd if=file of=/dev/null bs=100M count=100
100+0 records in
100+0 records out
10485760000 bytes (10 GB) copied, 211.132 s, 49.7 MB/s

Please let me know if you need more details/logs. Thanks in advance!

Regards,
Denys
