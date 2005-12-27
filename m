From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Tue, 27 Dec 2005 15:34:28 -0800
Message-ID: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:54416 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932390AbVL0Xd7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Dec 2005 18:33:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>, axboe <axboe@suse.de>, chris@powerblogs.com

I've probably overlooked 1-2 small things, but this patchset
implements most of the changes that Jeff commented on about
2 weeks ago.  (Sorry for the delay.)

This is a series of 5 patches.  A rolled-up (combined) patch
is available at:
  http://www.xenotime.net/linux/SATA/2.6.15-rc7/libata-combine.patch

and all patches in the series (+ the quilt series file)
are available in:
  http://www.xenotime.net/linux/SATA/2.6.15-rc7/

patchset:
1.  libata_suspend.patch from Jens Axboe

2.  ata_acpi_make.patch
	Makefile, Kconfig, header, and kernel-doc changes

3.  libata-debugging.patch
	libata debugging infrastructure from Borislav Petkov
	(used in libata-acpi.patch)

4.  libata-acpi.patch
	The main SATA ACPI support functions

5.  libata-param.patch
	Add 'noacpi' and 'printk' module parameters.
	Update Documentation/kernel-parameters.txt

NOTES:
1.  not added (yet):  "platform" functions
2.  not yet using ata_exec_internal()

---
~Randy
