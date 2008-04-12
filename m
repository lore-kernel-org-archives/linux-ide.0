From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Promise TX4 performance problems
Date: Sat, 12 Apr 2008 19:47:21 +0200
Message-ID: <18432.62889.136514.375224@harpo.it.uu.se>
References: <cdcaea5a0804120556w6ef4479fi86c05a4613b12a97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:46417 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754642AbYDLRrd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 13:47:33 -0400
In-Reply-To: <cdcaea5a0804120556w6ef4479fi86c05a4613b12a97@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marko Koivusalo <marko.koivusalo@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Marko Koivusalo writes:
 > Hello,
 > 
 > I'm unfortunate owner of Promise TX4 SATA300 (rev2). In Feb 2007 my
 > raid started to drop drives under heavy load. Back then it was not
 > known to hapend because of TX4 asic bug or at least I was unable to
 > find such information at the time. And the card had worked fine for a
 > year or so. Well eventually I ended up replacing whole home server
 > piece by piece and finally deemed that the TX4 was propably broken.
 > 
 > Now a year later and after finding out that asic bug was found & fixed
 > I thought to utilize TX4 once more. I'm currently running driver from
 > kernel 2.6.24.4 which I had to backport into 2.6.23.1 due my TX4
 > replacement card (HPT rr174x) that has binary-wrapper drivers only
 > (sigh) and I'm unable to compile them in 2.6.24.4.
 > 
 > However the problem with Promise TX4 is now extremely poor
 > performance, it writes around 5.2MB/s  with average CPU utilization of
 > 3.2 on my 2.4GHz p4 (measured over 12 hours).
 > 
 > First thought was that DMA is not enabled, but according to hdparm it
 > is. My plan to use this for RAID once again is doomed unless solution
 > is found.
 > 
 > I think iostat revealed something out of ordinary:
 > 
 > avg-cpu:  %user   %nice %system %iowait  %steal   %idle
 >            0.00    0.00    0.00  100.00    0.00    0.00
 > 
 > Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s
 > avgrq-sz avgqu-sz   await  svctm  %util
 > sdh               0.00  4640.00    0.00    8.00     0.00     3.94
 > 1008.00   134.82 4807.00 125.50 100.40
 > 
 > For non TX4 devices these numbers are quite different. Full details
 > and other possibly related info can be found at
 > http://pastebin.com/f40f5ae27
 > 
 > Perhaps the asic patch made things this slow? If so, no wonder that it
 > hides problem that occurs only under heavy load?

My News server (PDC20378, VIA KT800 chipset, 2GHz Athlon64) gets
69MB/s reads and 56MB/s writes on a non-raid ext3 fs. My Promise
test box (550MHz Athlon, AMD751/756 chipset) gets 55MB/s reads and
and 42MB/s writes on one disk, and 69MB/s reads and 49MB/s writes
on another disk, with non-raid ext3.

So I don't think the ASIC bug workaround is related to your poor
write performance. Your performance problem could be due to:
- that HPT rr174x driver
- a dodgy mainboard or ACPI
- disk errors and I/O retries caused by an underdimensioned PSU
But we'd need a lot more detailed information about your system
to make any sort of educated guess.

It would be interesting to see raw read and write performance on
your TX4 with a vanilla 2.6.25-rc9 kernel. You can for instance
use dd or hdparm on /dev/sdh to do the measurements. (And please
include lspci output and the complete kernel log as well.)

/Mikael
