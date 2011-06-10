From: Hubert Bailey <hbailey@marvell.com>
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Fri, 10 Jun 2011 03:31:32 -0700
Message-ID: <B9B10C29375C5B40A2D240808654F60E5EE470A578@SC-VEXCH2.marvell.com>
References: <20110610102403.GE15235@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33138 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753730Ab1FJKgd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Jun 2011 06:36:33 -0400
In-Reply-To: <20110610102403.GE15235@htj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "'tj@kernel.org'" <tj@kernel.org>, "'tim@seoss.co.uk'" <tim@seoss.co.uk>
Cc: "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

I have forwards this to the SW team. They should contact you shortly. 


----- Original Message -----
From: Tejun Heo [mailto:tj@kernel.org]
Sent: Friday, June 10, 2011 03:24 AM
To: Tim Small <tim@seoss.co.uk>
Cc: linux-ide@vger.kernel.org <linux-ide@vger.kernel.org>; Saeed Bishara; Hubert Bailey
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI controller

Hello,

Cc'ing marvell people.  The original thread can be read from the
following URL.

  http://thread.gmane.org/gmane.linux.ide/49658

On Thu, Jun 09, 2011 at 10:11:27PM +0100, Tim Small wrote:
> Thanks very much for your patch - I gave it a spin (against Debian's
> 2.6.38 kernel) - it's apparently working better than before, but still a
> bit wonky...
...
> Unplugging from the 3132 (and waiting for things to settle), then
> plugging into the 88SE9123 gives the following...
> 
> 541.610033] ata14: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action
> 0xe frozen
> 541.610166] ata14: irq_stat 0x80400040, connection status changed
> 541.610277] ata14: SError: { PHYRdyChg CommWake DevExch }
> 541.610391] ata14: hard resetting link
> 543.288743] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
> 543.289086] ata14.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
> feat 0x1/0x9
> 543.289220] ahci 0000:01:00.0: FBS is enabled.
> 543.289418] ata14.00: hard resetting link
> 543.608852] ata14.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> 543.609031] ata14.01: hard resetting link
> 543.928756] ata14.01: SATA link down (SStatus 0 SControl 320)
> 543.928943] ata14.02: hard resetting link
> 544.248663] ata14.02: SATA link down (SStatus 0 SControl 320)
> 544.248856] ata14.03: hard resetting link
> 544.568553] ata14.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> 544.880294] ata14.05: no reset method available, skipping reset
> 544.880594] ata14.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> 544.881914] ata14.03: ATA-7: Hitachi HUA721010KLA330, GKAOAB0A, max UDMA/133
> 544.882099] ata14.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth
> 31/32), AA
> 544.883774] ata14.03: configured for UDMA/133
> 544.883987] ata14: EH complete
> 544.884213] scsi 13:3:0:0: Direct-Access     ATA      Hitachi HUA72101
> GKAO PQ: 0 ANSI: 5
> 544.884750] sd 13:3:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00
> TB/931 GiB)
> 544.884879] sd 13:3:0:0: [sdb] Write Protect is off
> 544.884892] sd 13:3:0:0: [sdb] Mode Sense: 00 3a 00 00
> 544.884957] sd 13:3:0:0: [sdb] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> 544.897087]  sdb: sdb1 sdb2 < sdb5 >
> 544.897519] sd 13:3:0:0: [sdb] Attached SCSI disk
> 
> ... so definitely some progress, but the Maxtor drive on PMP port zero
> hasn't been found...

That's weird.  Link is up but EH is detected to be up but EH didn't
probe it.  Is the behavior reproducible?

> I then hot-un-plugged the Maxtor from the pmp and got this lot:
> 
>  709.515101] ata14.15: PMP product ID mismatch
>  709.515256] ata14.15: hard resetting link
>  715.043716] ata14.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
>  715.044020] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
>  715.044191] ata14.15: PMP revalidation failed (errno=-19)
>  715.044352] ata14.15: limiting SATA link speed to 1.5 Gbps
>  720.042049] ata14.15: hard resetting link
>  725.572222] ata14.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>  725.572595] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
>  725.572767] ata14.15: PMP revalidation failed (errno=-19)
>  730.570649] ata14.15: hard resetting link
>  736.100725] ata14.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>  736.101093] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
>  736.101259] ata14.15: PMP revalidation failed (errno=-19)
>  736.101417] ata14.15: failed to recover PMP after 5 tries, giving up
>  736.101578] ata14.15: Port Multiplier detaching

This shouldn't happen and seems to be the same problem which triggered
before.  I don't think this is caused by 3726.  The problem is likely
on the controller side.

>  741.099118] ata14: hard resetting link
>  746.629228] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
>  746.629636] ata14.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
> feat 0x1/0x9

So, detaching & re-attaching the PMP brings it back.  Maybe the
controller requires flipping PORT_CMD_PMP after an exception?

> Plugging the Maxtor back in then gave:
> 
> 813.046630] ata14.15: PMP product ID mismatch
> 813.046787] ata14.15: hard resetting link
> 814.766608] ata14.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
> 814.766916] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
> 814.767080] ata14.15: PMP revalidation failed (errno=-19)
...

Ths same problem triggering again.

> 833.208478] ata14: hard resetting link
> 834.931910] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
> 834.932300] ata14.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
> feat 0x1/0x9
...
> 837.323334] sd 13:0:0:0: [sdb] 240121728 512-byte logical blocks: (122
> GB/114 GiB)
> 837.324358] sd 13:3:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00
> TB/931 GiB)

And after re-attaching, at least detection worked, so that's
something.

> .... and reading from each disk individually works, but reading from
> both at the same time doesn't (I/Os time-out, and then the whole lot
> gets reset).

Maybe FBS support doesn't work as advertised?  Can you please try the
following patch?

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index d38c40f..a2f4b68 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -444,6 +444,7 @@ void ahci_save_initial_config(struct device *dev,
 			   "controller can do FBS, turning on CAP_FBS\n");
 		cap |= HOST_CAP_FBS;
 	}
+	cap &= ~HOST_CAP_FBS;
 
 	if (force_port_map && port_map != force_port_map) {
 		dev_printk(KERN_INFO, dev, "forcing port_map 0x%x -> 0x%x\n",

Thanks.

-- 
tejun
