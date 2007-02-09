From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: sata_vsc with iq3124h regression in 2.6.20
Date: Fri, 9 Feb 2007 15:21:15 -0700
Message-ID: <0C7297FA1D2D244A9C7F6959C0BF1E52015235BE@azsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48028 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946120AbXBIWVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 17:21:12 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

When I fire up 2.6.20 with an iq3124h I get:

ata1: SATA max UDMA/133 cmd 0xC8822200 ctl 0xC8822229 bmdma 0xC8822270
irq 25
ata2: SATA max UDMA/133 cmd 0xC8822400 ctl 0xC8822429 bmdma 0xC8822470
irq 25
ata3: SATA max UDMA/133 cmd 0xC8822600 ctl 0xC8822629 bmdma 0xC8822670
irq 25
ata4: SATA max UDMA/133 cmd 0xC8822800 ctl 0xC8822829 bmdma 0xC8822870
irq 25
scsi0 : sata_vsc
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
irq 25: nobody cared (try booting with the "irqpoll" option)
handlers:
[<c01796e0>] (vsc_sata_interrupt+0x0/0x194)
Disabling IRQ #25

I did a git bisect and came up with: [PATCH] libata: always use polling
IDENTIFY (800b399669ad495ad4361d134df87401ae36f44f)

I could probably cobble together a workaround to use irq-driven IDENTIFY
for this card but wanted to see if there was a better way.

Thanks,

Dan
