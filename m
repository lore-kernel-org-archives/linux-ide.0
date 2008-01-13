From: "Paul Surgeon" <surgpm@gmail.com>
Subject: SATA timeouts on CD DVD RW
Date: Sun, 13 Jan 2008 05:57:15 +0200
Message-ID: <6d98c5450801121957jb4c5a10xe5a3b8b866585732@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:28558 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbYAMD5Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 22:57:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2791796wah.23
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 19:57:15 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I keep getting the following error messages during bootup with kernel
2.6.23.12 :

scsi 4:0:0:0: CD-ROM            TSSTcorp CDDVDW TS-L633A  UO00 PQ: 0 ANSI: 5
ata3.00: qc timeout (cmd 0xa0)
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: (irq_stat 0x40000001)
ata3.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
        res 51/60:03:00:00:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata3: soft resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for PIO4
ata3: EH complete

The error repeats many times and it takes about 10 minutes for the box to boot.
If I unplug the DVD drive the problem naturally disappears.
The machine is an Intel SR1530SH.

Below is the output from lspci :
00:00.0 Host bridge: Intel Corporation Server DRAM Controller
00:01.0 PCI bridge: Intel Corporation Server Host-Primary PCI Express Bridge
00:19.0 Ethernet controller: Intel Corporation 82566DM-2 Gigabit
Network Connection (rev 02)
00:1c.0 PCI bridge: Intel Corporation PCI Express Port 1 (rev 02)
00:1c.4 PCI bridge: Intel Corporation PCI Express Port 5 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92)
00:1f.0 ISA bridge: Intel Corporation LPC Interface Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 6 port SATA AHCI Controller (rev 02)
00:1f.3 SMBus: Intel Corporation SMBus Controller (rev 02)
01:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit
Ethernet Controller (rev 06)
01:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit
Ethernet Controller (rev 06)
03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200e
[Pilot] ServerEngines (SEP1) (rev 02)
04:02.0 Ethernet controller: Intel Corporation 82541GI Gigabit
Ethernet Controller (rev 05)

I've tried switching acpi off, using irqpoll, switching from AHCI to
RAID in the BIOS but it makes no difference at all.
I also tried kernel 2.6.21.5 (Slackware 12.0) and the problem is still there.
Any ideas?

Thanks
Paul
