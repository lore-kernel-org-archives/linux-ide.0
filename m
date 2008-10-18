From: Lars Michael Jogback <lm@jogback.se>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Sat, 18 Oct 2008 18:52:09 +0200
Message-ID: <20081018165209.GA7754@cleopatra.jogback.se>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org> <20081014201917.GA5974@cleopatra.jogback.se> <48F595DB.4030301@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.jogback.se ([192.165.82.10]:41525 "EHLO mail.jogback.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbYJRQyc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Oct 2008 12:54:32 -0400
Content-Disposition: inline
In-Reply-To: <48F595DB.4030301@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

* Tejun Heo <tj@kernel.org> [2008-10-15 16:03:55]:

> Can you please try the followings?
> 
> 1. If you swap the drive on the second slot with another one, does the
>    detection problem stay with the port or follow the drive?

It doesn't follow the drive. It sort of stays with port in that sense
that it happens on the first equipped port after the first one (which is
probed by the controllers BIOS). If I leave the second port empty, it
happens on the third when I do a cold boot.

I have also moved the drives around, and it does not follow the drive.

One odd thing that I've noticed is that it's only happening on my
Samsung drives, I've got a couple of WD aswell and they seem to work.

> 2. Does "libata.force=1.5Gbps" make any difference?

No, same behaviour.

> 3. Apply the patch and post log after failed hotplug.
> 

I had to change it to:
ata_port_printk(ap, KERN_WARNING,  "XXX error_intr irq_stat=0x%x\n", irq_stat);

I hope that was correct.

Yank the drive:
[   82.081889] ata3: XXX error_intr irq_stat=0x8040800
[   82.095851] ata3.04: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[   82.095913] ata3: SError: { PHYRdyChg CommWake DevExch }
[   82.096037] ata3.04: hard resetting link
[   83.183919] ata3.04: SATA link down (SStatus 0 SControl 320)
[   83.184006] ata3: failed to recover some devices, retrying in 5 secs
[   88.756273] ata3.04: hard resetting link
[   89.092417] ata3.04: SATA link down (SStatus 0 SControl 320)
[   89.092504] ata3: failed to recover some devices, retrying in 5 secs
[   95.136519] ata3.04: hard resetting link
[   95.504418] ata3.04: SATA link down (SStatus 0 SControl 320)
[   95.504467] ata3.04: disabled
[   96.102757] ata3: EH complete
[   96.102711] ata3.04: detaching (SCSI 3:4:0:0)
[   96.102711] sd 3:4:0:0: [sdp] Synchronizing SCSI cache
[   96.102711] sd 3:4:0:0: [sdp] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[   96.102711] sd 3:4:0:0: [sdp] Stopping disk
[   96.102711] sd 3:4:0:0: [sdp] START_STOP FAILED
[   96.102711] sd 3:4:0:0: [sdp] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

Plug the drive:
[  103.696514] ata3: XXX error_intr irq_stat=0x8040800
[  103.712305] ata3.04: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  103.712368] ata3: SError: { PHYRdyChg CommWake DevExch }
[  103.712493] ata3.04: hard resetting link
[  104.452364] ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  104.452447] ata3: XXX error_intr irq_stat=0x60002
[  104.468214] ata3.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[  104.468288] ata3.15: hard resetting link
[  107.671458] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  107.671657] ata3.00: hard resetting link
[  108.030320] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  108.030396] ata3.01: hard resetting link
[  108.418464] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  108.418541] ata3.02: hard resetting link
[  108.762278] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  108.762292] ata3.03: hard resetting link
[  109.097482] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  109.097556] ata3.04: hard resetting link
[  109.432900] ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  109.432975] ata3.05: hard resetting link
[  110.062677] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  110.074170] ata3.00: configured for UDMA/100
[  110.087041] ata3.01: configured for UDMA/100
[  110.099889] ata3.02: configured for UDMA/100
[  110.112772] ata3.03: configured for UDMA/100
[  110.112848] ata3: XXX error_intr irq_stat=0x60002
[  110.125182] ata3.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[  110.125257] ata3.15: hard resetting link
[  112.253161] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  112.253413] ata3.00: hard resetting link
[  112.589297] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  112.589372] ata3.01: hard resetting link
[  112.925296] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  112.925371] ata3.02: hard resetting link
[  113.261297] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  113.261372] ata3.03: hard resetting link
[  113.597296] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  113.597371] ata3.04: hard resetting link
[  113.937936] ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  113.938011] ata3.05: hard resetting link
[  114.274271] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  114.289542] ata3.00: configured for UDMA/100
[  114.302397] ata3.01: configured for UDMA/100
[  114.315239] ata3.02: configured for UDMA/100
[  114.328084] ata3.03: configured for UDMA/100
[  114.328161] ata3: XXX error_intr irq_stat=0x60002
[  114.340527] ata3.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[  114.340601] ata3.04: failed to recover link after 3 tries, disabling
[  114.340673] ata3: failed to recover PMP, retrying in 5 secs
[  119.350834] ata3.15: hard resetting link
[  121.478839] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  121.799894] ata3.00: hard resetting link
[  122.135051] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  122.135126] ata3.01: hard resetting link
[  122.470974] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  122.471049] ata3.02: hard resetting link
[  122.806974] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  122.807049] ata3.03: hard resetting link
[  123.142974] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  123.143049] ata3.05: hard resetting link
[  123.478974] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  123.491861] ata3.00: configured for UDMA/100
[  123.504712] ata3.01: configured for UDMA/100
[  123.517553] ata3.02: configured for UDMA/100
[  123.530403] ata3.03: configured for UDMA/100
[  123.862927] ata3: EH complete

The drive seems to come alive and seems to start at [  119.350834] above.
But then it's been tried 3 times and is already disabled.

BR
/LM
