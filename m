From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise SATA300TX4 "intermittent problems"
Date: Tue, 13 Mar 2007 09:11:47 +0200 (EET)
Message-ID: <41037.194.237.142.7.1173769907.squirrel@ncircle.nullnet.fi>
References: <45EECD12.1000506@how.dk>
    <17903.7366.875191.751728@alkaid.it.uu.se> <45F0393D.80301@how.dk>
    <45F0FE4C.7060901@how.dk>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:42563 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbXCMHLx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 03:11:53 -0400
In-Reply-To: <45F0FE4C.7060901@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org


Hello,

> Peter Favrholdt wrote:
>> My feeling is this is not caused by 1.5Gbps or 3.0Gbps operation.
>> <...snip>
>> My next test will be a plain 2.6.21rc2. Then I'll apply the patches one
>> by one.
>
> I've tested 2.6.21-rc2 which fails (sdc down after 27 minutes & sdd down
> after 46 minutes).
>
> Then I applied just a single patch to 2.6.21-rc2: Mikael Petterssons
> patch to force 1.5Gbps operation and tested again - this time no
> problems at all!
>
> (BTW: both kernels are running with IO-APIC disabled).
>
> I've put results+dmesg output here: http://sata300tx4.gratiswiki.dk/

I had the oppoturnity to test Mikael's 1,5Gbps patch yesterday evening and
although the system seems to run OK, I still do get the following system
log messages:


Mar 13 06:10:22 alderan kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x0
Mar 13 06:10:22 alderan kernel: ata2.00: cmd
c8/00:30:0f:e2:86/00:00:00:00:00/e7 tag 0 cdb 0x0 data 24576 in
Mar 13 06:10:22 alderan kernel:          res
50/00:00:3e:e2:86/00:00:00:00:00/e7 Emask 0x1 (device error)
Mar 13 06:10:22 alderan kernel: ata2.00: configured for UDMA/133
Mar 13 06:10:22 alderan kernel: ata2: EH complete
Mar 13 06:10:22 alderan kernel: SCSI device sdb: 976773168 512-byte hdwr
sectors (500108 MB)
Mar 13 06:10:22 alderan kernel: sdb: Write Protect is off
Mar 13 06:10:22 alderan kernel: SCSI device sdb: write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Mar 13 06:11:23 alderan kernel: possible SYN flooding on port 52223.
Sending cookies.
Mar 13 06:13:05 alderan kernel: possible SYN flooding on port 52223.
Sending cookies.
Mar 13 06:13:23 alderan kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x0
Mar 13 06:13:23 alderan kernel: ata2.00: cmd
25/00:00:27:29:73/00:02:07:00:00/e0 tag 0 cdb 0x0 data 262144 in
Mar 13 06:13:23 alderan kernel:          res
50/00:00:26:2b:73/00:00:00:00:00/e0 Emask 0x1 (device error)
Mar 13 06:13:23 alderan kernel: ata2.00: configured for UDMA/133
Mar 13 06:13:23 alderan kernel: ata2: EH complete
Mar 13 06:13:23 alderan kernel: SCSI device sdb: 976773168 512-byte hdwr
sectors (500108 MB)
Mar 13 06:13:23 alderan kernel: sdb: Write Protect is off
Mar 13 06:13:23 alderan kernel: SCSI device sdb: write cache: enabled,
read cache: enabled, doesn't support DPO or FUA

If Mikael does have an updated patch for the more detailed error reporting
features, I'll try to run it in a few days of time whenever I get my hands
on it. I would be really interested to know why the Promise Sata300TX4
doesn't play along the newer 500GB Seagate 7200.10 disks while the older
models are Ok (I've already tried with and without 1,5Gbps jumpers and
patches).

Regards,
Tomi Orava


-- 


