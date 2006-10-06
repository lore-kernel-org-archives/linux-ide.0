From: Jim Paris <jim@jtan.com>
Subject: sata_sis only recognizing primary drive in 2.6.18
Date: Fri, 6 Oct 2006 02:58:16 -0400
Message-ID: <20061006065816.GA5782@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:14479 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S932631AbWJFG6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Oct 2006 02:58:23 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, muthas@mit.edu, fragmede@gmail.com

Hi Tejun,

My friend has a motherboard with a SIS182 chipset (1039:0182), with
four ports on the motherboard.  BIOS sees it as two controllers,
"IDE2" and "IDE3" with two ports apiece: "IDE2 Primary", "IDE2
Secondary", etc.

If we plug drives into both the IDE2 Primary and IDE2 Secondary ports,
BIOS correctly sees and identifies both drives, and they're both
visible to grub, but sata_sis only sees the primary drive.  The second
drive just never shows up; no errors are reported.  This is with
Debian kernel 2.6.18 (same thing happens in .15, .16, .17).  Changing
various SATA-related BIOS settings doesn't help.

I don't have any logs on me at the moment, but I'm trying to get a
hold of this machine for a few days so I can put in a PATA root disk
and build/test custom libata modules with more debugging info.  Is
there anything in particular I should look for or try?

If I request warmplug with
  echo 0 0 0 > /sys/class/scsi_host/host1/scan
or
  echo 0 1 0 > /sys/class/scsi_host/host1/scan
then there is a soft-reset and the primary disk is rediscovered in
both cases, but neither causes the secondary disk to be discovered.

Also, hotplug polling doesn't seem to work.  Removed disks aren't
recognized as gone until I/O is attempted, and I have to request
warmplug to get an inserted disk recognized.  It's otherwise working
fine.

-jim
