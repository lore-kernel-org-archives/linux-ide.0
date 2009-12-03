From: Martin Michlmayr <tbm@cyrius.com>
Subject: sata-mv: Unable to stop eDMA
Date: Thu, 3 Dec 2009 19:12:32 +0000
Message-ID: <20091203191232.GA5382@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:36540 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393AbZLCTMf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 14:12:35 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: saeed@marvell.com, mlord@pobox.com, mail@g-radtke.name, avbidder@fortytwo.ch

Two users of Debian on the QNAP TS-419P have seen the following
"Unable to stop eDMA" error in dmesg.  Rebooting makes the problem go
away.  Can someone explain what this problem is about and whether this
might be a bug in the kernel?

The QNAP TS-419P uses the Marvell Kirkwood SoC and offers 4 SATA ports
via an 88SX7042 chip connected via PCIE (the SATA on the SoC is used
for 2 eSATA ports).

[  673.000000] ata1: Unable to stop eDMA
[  673.100000] ata1.00: exception Emask 0x52 SAct 0x1 SErr 0xffffffff action 0xe frozen
[  673.100000] ata1: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt PHYRdyChg PHYInt
CommWake 10B8B Dispar BadCRC Handshk LinkSeq TrStaTrns UnrecFIS DevExch }
[  673.100000] ata1.00: cmd 60/08:00:6e:b6:34/00:00:03:00:00/40 tag 0 ncq 4096 in
[  673.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[  673.100000] ata1.00: status: { DRDY }
[  673.100000] ata1: hard resetting link

and:

[ 1496.100000] ata2.00: cmd 61/00:30:b9:08:c4/01:00:07:00:00/40 tag 6 ncq 131072 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2.00: cmd 61/80:38:39:0b:c4/00:00:07:00:00/40 tag 7 ncq 65536 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2.00: cmd 61/80:40:b9:09:c4/00:00:07:00:00/40 tag 8 ncq 65536 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2.00: cmd 61/80:48:b9:13:c4/01:00:07:00:00/40 tag 9 ncq 196608 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2.00: cmd 61/00:50:b9:0d:c4/01:00:07:00:00/40 tag 10 ncq 131072 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2.00: cmd 61/00:58:39:10:c4/01:00:07:00:00/40 tag 11 ncq 131072 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2.00: cmd 61/00:60:39:11:c4/01:00:07:00:00/40 tag 12 ncq 131072 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2.00: cmd 61/80:68:39:13:c4/00:00:07:00:00/40 tag 13 ncq 65536 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2.00: cmd 61/00:70:39:0f:c4/01:00:07:00:00/40 tag 14 ncq 131072 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2.00: cmd 61/80:78:39:0d:c4/00:00:07:00:00/40 tag 15 ncq 65536 out
[ 1496.100000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.100000] ata2.00: status: { DRDY }
[ 1496.100000] ata2: hard resetting link
[ 1496.210000] ata1: Unable to stop eDMA
[ 1496.320000] ata1.00: exception Emask 0x52 SAct 0x2 SErr 0xffffffff action 0xe frozen
[ 1496.320000] ata1: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC Handshk LinkSeq TrStaTrns UnrecFIS DevExch }
[ 1496.320000] ata1.00: cmd 60/80:08:b9:16:c4/00:00:07:00:00/40 tag 1 ncq 65536 in
[ 1496.320000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[ 1496.320000] ata1.00: status: { DRDY }
[ 1496.320000] ata1: hard resetting link
[ 1680.700000] INFO: task md0_resync:5946 blocked for more than 120 seconds.
[ 1680.700000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1680.700000] md0_resync    D c0280d94     0  5946      2
[ 1680.700000] [<c0280d94>] (__schedule+0x3b4/0x3f0) from [<c0280dec>] (schedule+0x1c/0x2c)
[ 1680.700000] [<c0280dec>] (schedule+0x1c/0x2c) from [<bf2435d0>] (raise_barrier+0x144/0x188 [raid1])
[ 1680.700000] [<bf2435d0>] (raise_barrier+0x144/0x188 [raid1]) from [<bf24420c>] (sync_request+0x200/0x714 [raid1])
[ 1680.700000] [<bf24420c>] (sync_request+0x200/0x714 [raid1]) from [<bf2192bc>] (md_do_sync+0x7c8/0xd1c [md_mod])
[ 1680.700000] [<bf2192bc>] (md_do_sync+0x7c8/0xd1c [md_mod]) from [<bf21a190>] (md_thread+0x110/0x12c [md_mod])
[ 1680.700000] [<bf21a190>] (md_thread+0x110/0x12c [md_mod]) from [<c0051f78>] (kthread+0x58/0x90)
[ 1680.700000] [<c0051f78>] (kthread+0x58/0x90) from [<c0041710>] (do_exit+0x0/0x638)
[ 1680.700000] [<c0041710>] (do_exit+0x0/0x638) from [<e1a03004>] (0xe1a03004)
[ 1800.700000] INFO: task md0_resync:5946 blocked for more than 120 seconds.
[ 1800.700000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1800.700000] md0_resync    D c0280d94     0  5946      2
[ 1800.700000] [<c0280d94>] (__schedule+0x3b4/0x3f0) from [<c0280dec>] (schedule+0x1c/0x2c)
[ 1800.700000] [<c0280dec>] (schedule+0x1c/0x2c) from [<bf2435d0>] (raise_barrier+0x144/0x188 [raid1])
[ 1800.700000] [<bf2435d0>] (raise_barrier+0x144/0x188 [raid1]) from [<bf24420c>] (sync_request+0x200/0x714 [raid1])
[ 1800.700000] [<bf24420c>] (sync_request+0x200/0x714 [raid1]) from [<bf2192bc>] (md_do_sync+0x7c8/0xd1c [md_mod])
[ 1800.700000] [<bf2192bc>] (md_do_sync+0x7c8/0xd1c [md_mod]) from [<bf21a190>] (md_thread+0x110/0x12c [md_mod])
[ 1800.700000] [<bf21a190>] (md_thread+0x110/0x12c [md_mod]) from [<c0051f78>] (kthread+0x58/0x90)
[ 1800.700000] [<c0051f78>] (kthread+0x58/0x90) from [<c0041710>] (do_exit+0x0/0x638)
[ 1800.700000] [<c0041710>] (do_exit+0x0/0x638) from [<e1a03004>] (0xe1a03004)
[ 1920.700000] INFO: task md0_resync:5946 blocked for more than 120 seconds.
[ 1920.700000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1920.700000] md0_resync    D c0280d94     0  5946      2
[ 1920.700000] [<c0280d94>] (__schedule+0x3b4/0x3f0) from [<c0280dec>] (schedule+0x1c/0x2c)
[ 1920.700000] [<c0280dec>] (schedule+0x1c/0x2c) from [<bf2435d0>] (raise_barrier+0x144/0x188 [raid1])
[ 1920.700000] [<bf2435d0>] (raise_barrier+0x144/0x188 [raid1]) from [<bf24420c>] (sync_request+0x200/0x714 [raid1])
[ 1920.700000] [<bf24420c>] (sync_request+0x200/0x714 [raid1]) from [<bf2192bc>] (md_do_sync+0x7c8/0xd1c [md_mod])
[ 1920.700000] [<bf2192bc>] (md_do_sync+0x7c8/0xd1c [md_mod]) from [<bf21a190>] (md_thread+0x110/0x12c [md_mod])
[ 1920.700000] [<bf21a190>] (md_thread+0x110/0x12c [md_mod]) from [<c0051f78>] (kthread+0x58/0x90)
[ 1920.700000] [<c0051f78>] (kthread+0x58/0x90) from [<c0041710>] (do_exit+0x0/0x638)
[ 1920.700000] [<c0041710>] (do_exit+0x0/0x638) from [<e1a03004>] (0xe1a03004)
[ 1920.700000] INFO: task kjournald:8541 blocked for more than 120 seconds.
[ 1920.700000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1920.700000] kjournald     D c0280d94     0  8541      2
[ 1920.700000] [<c0280d94>] (__schedule+0x3b4/0x3f0) from [<c0280dec>] (schedule+0x1c/0x2c)
[ 1920.700000] [<c0280dec>] (schedule+0x1c/0x2c) from [<bf2436a8>] (wait_barrier+0x94/0xf0 [raid1])
[ 1920.700000] [<bf2436a8>] (wait_barrier+0x94/0xf0 [raid1]) from [<bf2466f8>] (make_request+0x64/0x70c [raid1])
[ 1920.700000] [<bf2466f8>] (make_request+0x64/0x70c [raid1]) from [<bf21810c>] (md_make_request+0xe4/0x13c [md_mod])
[ 1920.700000] [<bf21810c>] (md_make_request+0xe4/0x13c [md_mod]) from [<c01638b0>] (generic_make_request+0x33c/0x3e8)
[ 1920.700000] [<c01638b0>] (generic_make_request+0x33c/0x3e8) from [<c0164afc>] (submit_bio+0xdc/0xf8)
[ 1920.700000] [<c0164afc>] (submit_bio+0xdc/0xf8) from [<c00caedc>] (submit_bh+0x154/0x184)
[ 1920.700000] [<c00caedc>] (submit_bh+0x154/0x184) from [<bf121298>] (journal_commit_transaction+0x44c/0x10d0 [jbd])
[ 1920.700000] [<bf121298>] (journal_commit_transaction+0x44c/0x10d0 [jbd]) from [<bf124c3c>] (kjournald+0xa8/0x1d4 [jbd])
[ 1920.700000] [<bf124c3c>] (kjournald+0xa8/0x1d4 [jbd]) from [<c0051f78>] (kthread+0x58/0x90)
[ 1920.700000] [<c0051f78>] (kthread+0x58/0x90) from [<c0041710>] (do_exit+0x0/0x638)
[ 1920.700000] [<c0041710>] (do_exit+0x0/0x638) from [<00000000>] (0x0)
[ 1920.700000] INFO: task 01setup:27048 blocked for more than 120 seconds.
[ 1920.700000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1920.700000] 01setup       D c0280d94     0 27048  27039
[ 1920.700000] [<c0280d94>] (__schedule+0x3b4/0x3f0) from [<c0280dec>] (schedule+0x1c/0x2c)
[ 1920.700000] [<c0280dec>] (schedule+0x1c/0x2c) from [<bf2436a8>] (wait_barrier+0x94/0xf0 [raid1])
[ 1920.700000] [<bf2436a8>] (wait_barrier+0x94/0xf0 [raid1]) from [<bf2466f8>] (make_request+0x64/0x70c [raid1])

-- 
Martin Michlmayr
http://www.cyrius.com/
