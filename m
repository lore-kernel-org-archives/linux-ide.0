From: linux@horizon.com
Subject: Success report: Silicon Image 3132
Date: 6 Sep 2005 02:14:31 -0400
Message-ID: <20050906061431.11885.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:48195 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932394AbVIFGOm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Sep 2005 02:14:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm currently setting up a new x86_64 server with 6x400G 7200.8
drives using 3x Sil3132 and the sata_sil24 driver.

Kernel 2.6.13 + 2.6.13-rc7-libata1.patch.bz2

So far, it kicks ass.  A simple RAID-0 across 4 drives on 2 controllers
lets me hit 270 MB/sec on zcav, and I'm having trouble getting bonnie++
to produce numbers instead of "++++".  (It failed with 256K files;
I'm trying again with 1024K).

The one problem is that attempting to run hddtemp on one of the
drives kills the machine hard.  (For now, I'll just avoid doing that.)


Anyway, since this is fairly new and I was nervous about SATA support (I
avoided using the Nforce4 on-board SATA), I thought I'd send a success
report.  I couldn't get an AHCI controller on an AMD processor (except
for 2 pprts in a ULi chipset), so after reviewing the alternatives,
it looked like Silicon Image were being among the friendliest to Linux
driver development.
