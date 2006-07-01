From: "Christian Pernegger" <pernegger@gmail.com>
Subject: Problems with ICH7R (AHCI) and WD5000YS
Date: Sat, 1 Jul 2006 08:42:33 +0200
Message-ID: <bb145bd20606302342h4ed461eid035d80079b1349f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:40818 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751000AbWGAGme (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Jul 2006 02:42:34 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1017901ugf
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2006 23:42:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi list!

I have the following configuration:

4x WD5000YS (Caviar RE2 500 GB) on the SATA ports of an Intel
SE7230NH1-E. The controller is an ICH7R in AHCI mode. Kernel is
2.6.17-1-686 from Debian testing. No jumpers on the drives, which
should be PM2 (whatever that is) off and 300Gb/s mode. The RE series
has special firmware with reduced error correction timeouts --
supposedly the RAID controller (libata and/or Linux Software-RAID in
my case) should take care of errors anyway.

All drives pass the advanced test of WD's diagnostic tool
individually, however when I tried to create an md array I got
something like this:

[...]
ata2: port reset, p_is 8000000 is 2 pis 0 cmd 44017 tf d0 ss 123 se 0
ata2: status=0x50 { DriveReady SeekComplete }
sdc: Current: sense key: No Sense
   Additional sense: No additional sense information
ata2: handling error/timeout
ata2: port reset, p_is 0 is 0 pis 0 cmd 44017 tf 150 ss 123 se 0
ata2: status=0x50 { DriveReady SeekComplete }
ata2: error=0x01 { AddrMarkNotFound }
sdc: Current: sense key: No Sense
   Additional sense: No additional sense information
[repeat]

Those messages loop until a timeout of some sort (a few minutes) is
reached. During that time all current and new processes accessing the
disk hang, but the md layer does not fail the disk at any time. The
other disks in the array stay accessible.

After a few reboots with cable-wiggling in between it created the
array without complaining. I then tested and benchmarked it for well
over a day, and when I'd finally declared it stable and copied some
data over it threw the same errors again :(

- It's not the disks themselves
- It's might be the cables, even though the diagnostic is fine,
especially if it forces 150 Gb/s. Also the error is (always? not sure)
on ata2. I don't have enough cables to test, unfortunately.
- It might be md, though the md guru (Neil Brown) says it is not.
- It might be the libata driver.

I appreciate any help,

Christian
