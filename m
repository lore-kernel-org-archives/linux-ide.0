From: Juraj Holtak <juraj@proaut.org>
Subject: sdc failing on ich6 and asus motherboard
Date: Fri, 16 Dec 2005 21:37:32 +0100
Message-ID: <1134765452.27793.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from static-98-27-159.p-dsl.nextra.sk ([195.98.27.159]:17988 "EHLO
	golem.tn.proaut.org") by vger.kernel.org with ESMTP id S932389AbVLPUhj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Dec 2005 15:37:39 -0500
Received: from t41.tn.proaut.org (t41.tn.proaut.org [10.222.0.34])
	by golem.tn.proaut.org (8.13.4/8.13.4/Debian-3) with ESMTP id jBGKi3mZ003109
	for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2005 20:44:04 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hello,

I have a ASUS P5AD2-E Premium motherboard (ICH6 chipset).
My kernel version is 2.6.11.12-skas3-v8.2 #1 SMP

The machine has 4 SATA drives sda..sdd.
I`m using the ICH6 in AHCI mode.

My problem is, that my sdc drive regullary fails.

Dec 16 20:51:18 xaser kernel: ata2: error occurred, port reset
Dec 16 20:51:18 xaser kernel: ata3: status=0x01 { Error }
Dec 16 20:51:18 xaser kernel: ata3: called with no error (01)!
Dec 16 20:51:48 xaser kernel: ata2: error occurred, port reset
Dec 16 20:51:48 xaser kernel: ata3: status=0x01 { Error }
Dec 16 20:51:48 xaser kernel: ata3: called with no error (01)!
Dec 16 20:51:48 xaser kernel: SCSI error : <2 0 0 0> return code =
0x8000002
Dec 16 20:51:48 xaser kernel: sdc: Current: sense key: Medium Error
Dec 16 20:51:48 xaser kernel:     Additional sense: Write error - auto
reallocat
ion failed

First I thought, the drive (250G Baracuda) is broken so I replaced it
with a brand new one (300G Maxtor), but sdc failed again. I shuffled the
disks so that the sda disk wich ran fine, got sdc and sdc got sda. The
sdc drive failed again, and sda ran fine, so it`s not the harddrive. I
schuffled the cabling (power and data) and sdc failed again.

I think it is a controller/linux-kernel/motherboard/bios issue.

Has anybody seen similar problem?

Could a kernel upgrade help?

thank you,
juraj

