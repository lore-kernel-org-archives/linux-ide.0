From: Sebastian Kuzminsky <seb@highlab.com>
Subject: strange data from iostat (2.6.16.24)
Date: Mon, 10 Jul 2006 13:08:49 -0600
Message-ID: <E1G017h-00075R-2X@highlab.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:38895 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1422790AbWGJTVE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 15:21:04 -0400
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.62)
	(envelope-from <seb@highlab.com>)
	id 1G017h-00075R-2X
	for linux-ide@vger.kernel.org; Mon, 10 Jul 2006 13:08:49 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've got a system with 4 SATA disks hanging off an ICH6 controller,
and I'm seeing output from iostat that I dont understand:

0 seb@slurp /home/seb>  iostat -dkx 1
Linux 2.6.16.24-slurp (slurp)   07/10/06

Device:    rrqm/s wrqm/s   r/s   w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
hda          0.01   0.04  0.18  0.02     0.74     0.26     9.69     0.05  236.03   7.61   0.16
hdb          0.03   2.67  0.89  0.57     6.87    13.01    27.08     0.03   19.34   2.39   0.35
sda          0.04   0.11  0.46  0.14     1.99     1.03    10.00    95.31   22.04 1657.68  99.96
sdb          0.04   0.11  0.30  0.13     1.37     0.95    10.79    95.31   34.64 2326.63  99.96
sdc          0.05   0.10  0.29  0.14     1.34     0.98    10.83    95.31   36.00 2334.50  99.96
sdd          0.05   0.10  0.28  0.14     1.32     0.95    10.95    95.31   33.63 2407.25  99.96
md0          0.00   0.00  1.12  0.46     4.49     1.83     8.00     0.00    0.00   0.00   0.00

Device:    rrqm/s wrqm/s   r/s   w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
hda          0.00   0.00  0.00  0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00
hdb          0.00   0.00  0.00  0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00
sda          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4251470.59    0.00   0.00  99.01
sdb          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4251470.59    0.00   0.00  99.01
sdc          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4251470.59    0.00   0.00  99.01
sdd          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4251470.59    0.00   0.00  99.01
md0          0.00   0.00  0.00  0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00

Device:    rrqm/s wrqm/s   r/s   w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
hda          0.00   0.00  0.00  0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00
hdb          0.00   0.00  0.00  0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00
sda          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4293981.37    0.00   0.00 100.40
sdb          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4293981.37    0.00   0.00 100.40
sdc          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4293981.37    0.00   0.00 100.40
sdd          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4293981.37    0.00   0.00 100.40
md0          0.00   0.00  0.00  0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00

Device:    rrqm/s wrqm/s   r/s   w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
hda          0.00   0.00  0.00  0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00
hdb          0.00   0.00  0.00  0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00
sda          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4251466.70    0.00   0.00  99.41
sdb          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4251466.70    0.00   0.00  99.41
sdc          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4251466.70    0.00   0.00  99.41
sdd          0.00   0.00  0.00  0.00     0.00     0.00     0.00 4251466.70    0.00   0.00  99.41
md0          0.00   0.00  0.00  0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00


md0 is a raid5 of sd[abcd].  The system is pretty much idle, so the
queue size and device utilization make no sense to me.

The system seems fine and stable, just the iostats are surprising.
Any ideas here?


-- 
Sebastian Kuzminsky        If it isn't running programs and it isn't fusing
                           atoms, it's just bending space.   -- Ken MacLeod
