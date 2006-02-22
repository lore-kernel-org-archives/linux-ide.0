From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 0/13] ACPI objects for SATA/PATA
Date: Wed, 22 Feb 2006 14:12:38 -0800
Message-ID: <20060222141238.4d2effa8.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:59528 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751519AbWBVWLq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Feb 2006 17:11:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

This patch series is primarily ACPI objects support for SATA/PATA.
It applies to 2.6.16-rc4.

ACPI objects for SATA/PATA add support for the _GTF, _SDD,
_GTM, and _STM ACPI methods.  ACPI methods are used to:

PATA:  get and set channel timings and modes and taskfiles
SATA:  get and set drive data and taskfiles

Taskfile operations are not limited.  Examples that I have
seen are (not limited to):
- power management:
  . enable or disable drive-initiated power management
- performance:
  . enable drive cache; set transfer mode (PIO/DMA)
- security
  . lock the disk access password

There is also an addition here to send a Standby Immediate
command to SATA/PATA drives during shutdown.  This should be
done (at least for some drives) to cause a safe and orderly
shutdown of the drive heads (i.e., protect data).

Caveat:  Some people are reporting good results from these
patches.  Unfortunately I have problems with them myself.
My test platforms usually suspend successfully but they
don't resume successfully.  Oh, and there may be a BUG
during sleep-shutdown processing where a sleep happens
while a spinlock is held.

These patches definitely need some time in -mm, but be
prepared to revert them or to use
	libata.noacpi=1
to disable them.  Also, please use
	libata.printk=0xff
to enable full debug messages.

If you want to test this without using -mm, you can either
apply the patch series (13 patches) or one rolled-up
(combined) patch.  The combined patch is available at:
http://www.xenotime.net/linux/SATA/2.6.16-rc4/libata-rollup-2616-rc4.patch

Still TBD:  more calls to ata_acpi_push_timing(), e.g.,
during resume, to set PATA hard drive timing and mode.
And fix the BUG above.

---
~Randy
