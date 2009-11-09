From: Marc Bevand <m.bevand@gmail.com>
Subject: Re: Abysmal SATA throughput with =?utf-8?b?c2F0YV9zdnc=?= and ST31500341AS
Date: Mon, 9 Nov 2009 02:44:05 +0000 (UTC)
Message-ID: <loom.20091109T032904-630@post.gmane.org>
References: <loom.20091108T012429-447@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35448 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbZKICoZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Nov 2009 21:44:25 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7KF3-0001er-2r
	for linux-ide@vger.kernel.org; Mon, 09 Nov 2009 03:44:29 +0100
Received: from cpe-76-89-196-254.socal.res.rr.com ([cpe-76-89-196-254.socal.res.rr.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 09 Nov 2009 03:44:29 +0100
Received: from m.bevand by cpe-76-89-196-254.socal.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 09 Nov 2009 03:44:29 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Marc Bevand <m.bevand <at> gmail.com> writes:
> 
> One of my machines with 4 SATA disks is resyncing a sdb, which is part of a
> 2-way raid1 MD array with sda, but is doing so _very_ slowly at a speed of
> 5-10 MByte/s. The machine is idle (no CPU, no fs activity on top of the
> array) and dev.raid.speed_limit_max has not been modified (left to the
> default value 200000). The output of iostat doesn't make sense to me: why
> are there 2-3 seconds periods of sdb being 100% utilized with an avgqu-sz
> of 4 but an avgrq-sz of 0 ?! What does this mean, that 0-byte I/O requests
> are being issued to the disk?

I think the avgrq-sz values of 0 are probably a minor bug in iostat when I/O 
requests take more than 1000ms to execute.

Anyway I fixed my problem. sdb was really having a hard time. It had loose 
disk tray screws, which were causing excessive vibration, which in turn were 
causing disk head seek errors, which degraded I/O throughput... This explains 
everything. I should have paid more attention to the SMART data (high 
Seek_Error_Rate.)

This experience reminds me of the blog post from a Sun engineer who 
demonstrated that shouting at a ZFS disk array produced sound waves powerful 
enough to cause vibrations and I/O latency spikes...

-mrb

