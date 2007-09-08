From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fwd: Intel 82801G (ICH7) SATA port reset
Date: Sat, 08 Sep 2007 16:34:53 +0900
Message-ID: <46E2509D.1030808@gmail.com>
References: <6b9952490708260411g22dede8ew6549acf0436b6e2e@mail.gmail.com> <6b9952490708260414o290c953enec86c6b2c16ac1d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:42612 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578AbXIHRHg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:07:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so940117wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:07:36 -0700 (PDT)
In-Reply-To: <6b9952490708260414o290c953enec86c6b2c16ac1d4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joris <joris@v5.be>
Cc: linux-ide@vger.kernel.org

Joris wrote:
> Hello List,
> 
> 
> I have a rather annoying problem.
> On an Intel S3000AHLX
> (http://www.intel.com/design/servers/boards/s3000ah/index.htm)
> motherboard, I can't seem to utilize all SATA interfaces to the
> maximum.
> The first sata interface frequently resets every few seconds under
> heavy IO, the net result being ridiculous slow transfers (attach:
> dmesg_random_collection_of_errors)
> 
> Running debian unstable and it's version of 2.6.22. System contains a
> xeon 3210 and an adaptec scsi controller from which I currently boot.
> 
> There is little logic in the symptoms:
> * if there is no or light IO, no resets occur.
> * it's always the sda port that resets (changing cables or disks
> doesn't make a difference).
> * only specific combinations of disk-usage on the sata disks (attach:
> disk_combinations_causing_reset), just using sda alone does not cause
> resets.
> * reading is enough, writing is (subjectively) worse. dd
> if=/dev/sd{a,b,c,d} of=/dev/null & guarantees trouble.
> * when the port resets, the disk makes a clearly audible clicking noise
> 
> I tried numerous things:
> * having the board exchanged with intel for the latest revision
> (thanks to my hardware supplier), updating to the latest bios and to a
> bios version 6 months old.
> * booting with older versions of the linux kernel, 2.6.18 and 2.6.21.
> * Using all possible combinations of the bios' matrix/lsi fakeraid and
> non-raid modes (always ignoring the "raid" and using the disks
> directly), and enable/disable the one PATA port in the bios.
> * asked seagate for a drive firmware update, to no avail.
> 
> 
> The only workable solution so far is to leave the first sata interface
> unused (remove the disk), which is obviously not a very nice solution.
> 
> Any hints or suggestions would be welcome, I'd be more than happy to
> try out new things.
> things. I'm a bit at a loss on how to proceed at the moment.

Wheee... the link to sda is going up and down (PHY RDY changed) even
when sda itself isn't being accessed.  I bet the clunking sound is head
doing emergency unloading.  There are two possibilities: 1. the harddisk
is dying or 2. the power which gets fed to the drive sucks (ie.
fluctuates too much when other drives suck more power causing sda to do
emergency unload and PHY link loss.)

You can rule out #1 by exchanging disk positions.  You can rule out #2
by connecting the harddrive to a separate PSU or exchanging power
connectors to different disks.

-- 
tejun

