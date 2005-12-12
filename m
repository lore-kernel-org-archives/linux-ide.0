From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 6/6 update] SATA ACPI: ata_acpi functions
Date: Sun, 11 Dec 2005 16:16:45 -0800
Message-ID: <20051211161645.0cf20057.rdunlap@xenotime.net>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
	<20051202100850.11b831ea.randy_d_dunlap@linux.intel.com>
	<20051206135815.5026647c.randy_d_dunlap@linux.intel.com>
	<1133973407.43970f9fdf6dd@www.ijichi.org>
	<20051207091639.00a7a232.randy_d_dunlap@linux.intel.com>
	<1133976270.43971ace1c015@www.ijichi.org>
	<20051207103449.2922faf3.randy_d_dunlap@linux.intel.com>
	<1134035010.4398004299a80@www.ijichi.org>
	<20051208161601.14a07dca.randy_d_dunlap@linux.intel.com>
	<1134087622.4398cdc67c72b@www.ijichi.org>
	<20051208170302.4acc426d.randy_d_dunlap@linux.intel.com>
	<20051208171008.47c688a9.randy_d_dunlap@linux.intel.com>
	<20051209105238.61e1a137.randy_d_dunlap@linux.intel.com>
	<1134241310.439b261e15b78@www.ijichi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:59544 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750932AbVLLAQN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Dec 2005 19:16:13 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sun, 11 Dec 2005 16:16:12 -0800
In-Reply-To: <1134241310.439b261e15b78@www.ijichi.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominic Ijichi <dom@ijichi.org>
Cc: randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org, axboe@suse.de, jgarzik@pobox.com

On Sat, 10 Dec 2005 19:01:50 +0000 Dominic Ijichi wrote:

> Quoting Randy Dunlap <randy_d_dunlap@linux.intel.com>:
> 
> > Dom,
> > 
> > I've updated the ata_apci.patch file to fix this bug.
> > I was misusing some of the ACPI memory alloc/free interfaces.
> > 
> > Updated file is at
> > http://www.xenotime.net/linux/SATA/2.6.15-rc/ata_acpi.patch
> 
> hi
> 
> it applies cleanly now, but unfortunately this doesnt seem to work in my case. 
> on waking from S3 sleep there is still no disk activity and terminals hang on
> first disk access.  dmesg attached, there's some more debug now which hopefully
> will be helpful!

partial dmesg:
ata1: dev 0 cfg 00:045a 49:0b00 82:746b 83:5988 84:4003 85:7469 86:1808 87:4003 88:003f 93:600b
ata1: dev 0 ATA-5, max UDMA/100, 117210240 sectors: LBA
ata1(0): applying bridge limits
do_drive_SDD: ap->id: 1, ix = 0, port#: 0, hard_port#: 0
do_drive_SDD: ata_id_is_sata is False
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The drive is not reported as a SATA drive, so the patch that I wrote
won't work for it.  Have you tried this patch to see if it works/helps
on your machine?

From:	Shaohua Li <shaohua.li@intel.com>
To:	linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [RFC]add ACPI hooks for IDE suspend/resume
Date:	Tue, 06 Dec 2005 14:10:04 +0800


Thanks,
---
~Randy
