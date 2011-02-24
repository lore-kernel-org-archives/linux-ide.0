From: Tejun Heo <tj@kernel.org>
Subject: Re: sata-sil drive detection issues.
Date: Thu, 24 Feb 2011 09:31:23 +0100
Message-ID: <20110224083123.GB7840@htj.dyndns.org>
References: <4D5C92F4.5000906@crc.id.au>
 <4D5CA2B1.8020905@crc.id.au>
 <20110217095815.GN19830@htj.dyndns.org>
 <a9eccac6fe224ef627fc71e819ba30ae@crc.id.au>
 <20110218091629.GC21209@htj.dyndns.org>
 <4D65C155.7080902@crc.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52903 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab1BXIb2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 03:31:28 -0500
Received: by fxm17 with SMTP id 17so304777fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2011 00:31:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D65C155.7080902@crc.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Haigh <netwiz@crc.id.au>
Cc: linux-ide@vger.kernel.org

Hello,

On Thu, Feb 24, 2011 at 01:24:21PM +1100, Steven Haigh wrote:
> >Yeah, it looks like something is wrong with the setup.  Please let us
> >know how the testing goes with the new cable (hopefully shorter).
> 
> Hmmm - the replacement SATA -> eSATA cables arrived today and I
> still get the same problem. On a whim, I connected the same cable +
> adapter + cradle to my i7 system running Fedora 14. This is not a
> sata_sil based adapter, but I believe it may rule out both the cable
> & the cradle as faulty.

Hmmm...

> [  371.217646] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002
> action 0xe frozen
> [  371.217700] ata6: irq_stat 0x00000040, connection status changed
> [  371.217750] ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
> [  371.217807] ata6: hard resetting link
> [  376.326257] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  376.347413] ata6.00: ATA-7: HDS728080PLA380, PF2OA60A, max UDMA/133
> [  376.347417] ata6.00: 160836480 sectors, multi 0: LBA48
> [  376.356485] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x100)
> [  376.356490] ata6.00: revalidation failed (errno=-5)
> [  381.324129] ata6: hard resetting link
> [  381.629014] ata6: SATA link down (SStatus 0 SControl 300)
> [  381.629022] ata6: limiting SATA link speed to 1.5 Gbps
> [  386.626909] ata6: hard resetting link
> [  387.494543] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [  387.533074] ata6.00: configured for UDMA/133
> [  387.533082] ata6: EH complete
> [  387.533262] scsi 5:0:0:0: Direct-Access     ATA
> HDS728080PLA380  PF2O PQ: 0 ANSI: 5
> [  387.533504] sd 5:0:0:0: Attached scsi generic sg3 type 0
> [  387.533721] sd 5:0:0:0: [sdc] 160836480 512-byte logical blocks:
> (82.3 GB/76.6 GiB)
> [  387.533790] sd 5:0:0:0: [sdc] Write Protect is off
> [  387.533794] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [  387.533823] sd 5:0:0:0: [sdc] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [  387.534037]  sdc: sdc1
> [  387.549830] sd 5:0:0:0: [sdc] Attached SCSI disk
> 
> I found it interesting that the drive failed to ident multiple
> times, however retrying eventually worked.

Well, yeah, IDENTIFY failure is still there.  Controllers behave
differently and some may have higher tolerance under certain
circumstances but the setup just seems quite flimsy for whatever
reason.

> Could it just be that the cradle is slow to initialise and therefore
> the sata_sil adapter gives up before the cradle is actually ready?
> 
> Following this logic, I tried powering up the cradle before
> connecting the esata cable. I don't see anything in dmesg connecting
> the esata cable AFTER the cradle has been powered on. Maybe the
> cradle disables the esata connection if theres no cable connected on
> powerup?

Is the cradle an active device or is it just power supply +
eSATA->SATA gender?  Oh, right, you said it also had USB connection,
so it's an active device.  Can you open it up and see which chip is
there?

Thanks.

-- 
tejun
