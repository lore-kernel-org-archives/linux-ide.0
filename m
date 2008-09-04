From: Tejun Heo <tj@kernel.org>
Subject: Re: Hotplug
Date: Thu, 04 Sep 2008 12:35:43 +0200
Message-ID: <48BFB9FF.90300@kernel.org>
References: <27a624370809021427h5d619e03qf23ea426387b0a6@mail.gmail.com>	 <48BE362D.2050705@kernel.org> <65a6ef750809040332n1cfcb009ue9f2ea5d42da18b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43999 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbYIDKhM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Sep 2008 06:37:12 -0400
In-Reply-To: <65a6ef750809040332n1cfcb009ue9f2ea5d42da18b7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: Jason Davis <mohadib@openactive.org>, linux-ide@vger.kernel.org, "Boulder (Colorado) Linux Users Group -- General Mailing List" <lug@lug.boulder.co.us>

Hello,

Mark Nelson wrote:
> Can you check these too (I'm testing hotplug on the PDC42819 with
> ahci driver)?
> 
> after powering up eSATA connected drive:
> 
>  ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
>  ata7: irq_stat 0x00000040, connection status changed
>  ata7: SError: { PHYRdyChg CommWake DevExch }
>  ata7: hard resetting link
>  ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  ata7.00: ATA-7: HTS721060G9SA00, MC3IC10H, max UDMA/100
>  ata7.00: 117210240 sectors, multi 0: LBA48
>  ata7.00: configured for UDMA/100
>  ata7: EH complete
>  scsi 6:0:0:0: Direct-Access     ATA      HTS721060G9SA00  MC3I PQ: 0 ANSI: 5
>  sd 6:0:0:0: [sdb] 117210240 512-byte hardware sectors (60012 MB)
>  sd 6:0:0:0: [sdb] Write Protect is off
>  sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>  sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>  sd 6:0:0:0: [sdb] 117210240 512-byte hardware sectors (60012 MB)
>  sd 6:0:0:0: [sdb] Write Protect is off
>  sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>  sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>   sdb: sdb1
>  sd 6:0:0:0: [sdb] Attached SCSI disk
>  sd 6:0:0:0: Attached scsi generic sg1 type 0
>  kjournald starting.  Commit interval 5 seconds
>  EXT3 FS on sdb1, internal journal
>  EXT3-fs: recovery complete.
>  EXT3-fs: mounted filesystem with ordered data mode.

Yeap, looks fine.

> after unmounting and executing
> echo 1 > /sys/class/scsi_device/6\:0\:0\:0/device/delete:
> 
>  sd 6:0:0:0: [sdb] Synchronizing SCSI cache
>  sd 6:0:0:0: [sdb] Stopping disk
>  ata7.00: disabled

Heh.. I usually just pull the power plug doing delete is a good idea.

> and after removing power from eSATA device:
> 
>  ata7: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
>  ata7: irq_stat 0x00400000, PHY RDY changed
>  ata7: SError: { PHYRdyChg }
>  ata7: hard resetting link
>  ata7: SATA link down (SStatus 0 SControl 300)
>  ata7: EH complete

This looks fine too.

-- 
tejun
