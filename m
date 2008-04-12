From: "Marko Koivusalo" <marko.koivusalo@gmail.com>
Subject: Promise TX4 performance problems
Date: Sat, 12 Apr 2008 15:56:33 +0300
Message-ID: <cdcaea5a0804120556w6ef4479fi86c05a4613b12a97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:41077 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757004AbYDLM4g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 08:56:36 -0400
Received: by an-out-0708.google.com with SMTP id d31so213091and.103
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 05:56:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

I'm unfortunate owner of Promise TX4 SATA300 (rev2). In Feb 2007 my
raid started to drop drives under heavy load. Back then it was not
known to hapend because of TX4 asic bug or at least I was unable to
find such information at the time. And the card had worked fine for a
year or so. Well eventually I ended up replacing whole home server
piece by piece and finally deemed that the TX4 was propably broken.

Now a year later and after finding out that asic bug was found & fixed
I thought to utilize TX4 once more. I'm currently running driver from
kernel 2.6.24.4 which I had to backport into 2.6.23.1 due my TX4
replacement card (HPT rr174x) that has binary-wrapper drivers only
(sigh) and I'm unable to compile them in 2.6.24.4.

However the problem with Promise TX4 is now extremely poor
performance, it writes around 5.2MB/s  with average CPU utilization of
3.2 on my 2.4GHz p4 (measured over 12 hours).

First thought was that DMA is not enabled, but according to hdparm it
is. My plan to use this for RAID once again is doomed unless solution
is found.

I think iostat revealed something out of ordinary:

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.00    0.00    0.00  100.00    0.00    0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s
avgrq-sz avgqu-sz   await  svctm  %util
sdh               0.00  4640.00    0.00    8.00     0.00     3.94
1008.00   134.82 4807.00 125.50 100.40

For non TX4 devices these numbers are quite different. Full details
and other possibly related info can be found at
http://pastebin.com/f40f5ae27

Perhaps the asic patch made things this slow? If so, no wonder that it
hides problem that occurs only under heavy load?

I'm building unmodified 2.6.24.4 kernel to test this, but I doubt my
few lines of backporting are cause of this slowness.

Since I somewhat need to get this working, I'm ready to test patches
and so on. Any ideas or comments ?

--
Marko Koivusalo
