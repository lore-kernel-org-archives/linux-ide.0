From: "Dominic ES. Ijichi" <dom@ijichi.org>
Subject: Re: [PATCH 6/6 update] SATA ACPI: ata_acpi functions
Date: Mon, 12 Dec 2005 00:24:53 +0000 (GMT)
Message-ID: <24701451.31211134347093224.JavaMail.root@willow.ijichi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from willow.ijichi.org ([217.206.220.50]:14746 "EHLO
	willow.ijichi.org") by vger.kernel.org with ESMTP id S1750919AbVLLAY5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Dec 2005 19:24:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy <rdunlap@xenotime.net>
Cc: randy d dunlap <randy_d_dunlap@linux.intel.com>, linux-ide@vger.kernel.org, axboe@suse.de, jgarzik@pobox.com

----- Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Sat, 10 Dec 2005 19:01:50 +0000 Dominic Ijichi wrote:
> 
> > Quoting Randy Dunlap <randy_d_dunlap@linux.intel.com>:
> > 
> > > Dom,
> > > 
> > > I've updated the ata_apci.patch file to fix this bug.
> > > I was misusing some of the ACPI memory alloc/free interfaces.
> > > 
> > > Updated file is at
> > > http://www.xenotime.net/linux/SATA/2.6.15-rc/ata_acpi.patch
> > 
> > hi
> > 
> > it applies cleanly now, but unfortunately this doesnt seem to work
> in my case. 
> > on waking from S3 sleep there is still no disk activity and
> terminals hang on
> > first disk access.  dmesg attached, there's some more debug now
> which hopefully
> > will be helpful!
> 
> partial dmesg:
> ata1: dev 0 cfg 00:045a 49:0b00 82:746b 83:5988 84:4003 85:7469
> 86:1808 87:4003 88:003f 93:600b
> ata1: dev 0 ATA-5, max UDMA/100, 117210240 sectors: LBA
> ata1(0): applying bridge limits
> do_drive_SDD: ap->id: 1, ix = 0, port#: 0, hard_port#: 0
> do_drive_SDD: ata_id_is_sata is False
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The drive is not reported as a SATA drive, so the patch that I wrote
> won't work for it.  Have you tried this patch to see if it
> works/helps
> on your machine?

oh right.  sorry to trouble you but the list archive has a 'hole' when that patch was released, could you possibly forward it to me?

cheers
dom

> 
> From:	Shaohua Li <shaohua.li@intel.com>
> To:	linux-ide <linux-ide@vger.kernel.org>, lkml
> <linux-kernel@vger.kernel.org>
> Subject: [RFC]add ACPI hooks for IDE suspend/resume
> Date:	Tue, 06 Dec 2005 14:10:04 +0800
> 
> 
> Thanks,
> ---
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

