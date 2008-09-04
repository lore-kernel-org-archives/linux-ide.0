From: "Mark Nelson" <mdnelson8@gmail.com>
Subject: Re: Hotplug
Date: Thu, 4 Sep 2008 20:32:05 +1000
Message-ID: <65a6ef750809040332n1cfcb009ue9f2ea5d42da18b7@mail.gmail.com>
References: <27a624370809021427h5d619e03qf23ea426387b0a6@mail.gmail.com>
	 <48BE362D.2050705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:53219 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYIDKcH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Sep 2008 06:32:07 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1858079yxm.1
        for <linux-ide@vger.kernel.org>; Thu, 04 Sep 2008 03:32:05 -0700 (PDT)
In-Reply-To: <48BE362D.2050705@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jason Davis <mohadib@openactive.org>, linux-ide@vger.kernel.org, "Boulder (Colorado) Linux Users Group -- General Mailing List" <lug@lug.boulder.co.us>

On Wed, Sep 3, 2008 at 5:01 PM, Tejun Heo <tj@kernel.org> wrote:
> Jason Davis wrote:
>> Hello,
>>  I'm trying to confirm hot/warm plugging is working on my system. When
>> I plug in the drive shows up as expected. I just want to make sure the
>> stuff I see in the logs is ok.
>
> Yeah, those are as okay as they get.  :-)

Hi Tejun,

Can you check these too (I'm testing hotplug on the PDC42819 with ahci driver)?

after powering up eSATA connected drive:

 ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
 ata7: irq_stat 0x00000040, connection status changed
 ata7: SError: { PHYRdyChg CommWake DevExch }
 ata7: hard resetting link
 ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 ata7.00: ATA-7: HTS721060G9SA00, MC3IC10H, max UDMA/100
 ata7.00: 117210240 sectors, multi 0: LBA48
 ata7.00: configured for UDMA/100
 ata7: EH complete
 scsi 6:0:0:0: Direct-Access     ATA      HTS721060G9SA00  MC3I PQ: 0 ANSI: 5
 sd 6:0:0:0: [sdb] 117210240 512-byte hardware sectors (60012 MB)
 sd 6:0:0:0: [sdb] Write Protect is off
 sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
 sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sd 6:0:0:0: [sdb] 117210240 512-byte hardware sectors (60012 MB)
 sd 6:0:0:0: [sdb] Write Protect is off
 sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
 sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
  sdb: sdb1
 sd 6:0:0:0: [sdb] Attached SCSI disk
 sd 6:0:0:0: Attached scsi generic sg1 type 0
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on sdb1, internal journal
 EXT3-fs: recovery complete.
 EXT3-fs: mounted filesystem with ordered data mode.


after unmounting and executing
echo 1 > /sys/class/scsi_device/6\:0\:0\:0/device/delete:

 sd 6:0:0:0: [sdb] Synchronizing SCSI cache
 sd 6:0:0:0: [sdb] Stopping disk
 ata7.00: disabled


and after removing power from eSATA device:

 ata7: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
 ata7: irq_stat 0x00400000, PHY RDY changed
 ata7: SError: { PHYRdyChg }
 ata7: hard resetting link
 ata7: SATA link down (SStatus 0 SControl 300)
 ata7: EH complete


Thanks!

Mark
