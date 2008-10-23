From: Lars Michael Jogback <lm@jogback.se>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Thu, 23 Oct 2008 20:14:43 +0200
Message-ID: <20081023181443.GA7323@cleopatra.jogback.se>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org> <20081014201917.GA5974@cleopatra.jogback.se> <48F595DB.4030301@kernel.org> <20081018165209.GA7754@cleopatra.jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.jogback.se ([192.165.82.10]:47973 "EHLO mail.jogback.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237AbYJWSSL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 14:18:11 -0400
Content-Disposition: inline
In-Reply-To: <20081018165209.GA7754@cleopatra.jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi,

I did installed an earlier kernel on the machine, and then hotplug
worked.

This is the log when I did hotplug using v2.6.24 (the kernel from Debian
Etch-n-half)


This is when I yank the drive:
ata7.04: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xb
ata7: SError: { PHYRdyChg CommWake DevExch }
ata7.04: hard resetting link
ata7.04: SATA link down (SStatus 0 SControl 320)
ata7: failed to recover some devices, retrying in 5 secs
ata7.04: hard resetting link
ata7.04: SATA link down (SStatus 0 SControl 320)
ata7: failed to recover some devices, retrying in 5 secs
ata7.04: hard resetting link
ata7.04: SATA link down (SStatus 0 SControl 320)
ata7.04: disabled
ata7.04: soft resetting link
ata7.04: SATA link down (SStatus 0 SControl 320)
ata7: EH complete
ata7.04: detaching (SCSI 7:4:0:0)
sd 7:4:0:0: [sdp] Synchronizing SCSI cache
sd 7:4:0:0: [sdp] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
sd 7:4:0:0: [sdp] Stopping disk
sd 7:4:0:0: [sdp] START_STOP FAILED
sd 7:4:0:0: [sdp] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

And this is when I plug the drive:
ata7.04: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xb
ata7: SError: { PHYRdyChg CommWake DevExch }
ata7.04: hard resetting link
ata7.04: softreset failed (SRST command error)
ata7.04: reset failed (errno=-5), retrying in 10 secs
ata7.04: hard resetting link
ata7.04: hardreset failed (port not ready)
ata7.04: reset failed (errno=-5), retrying in 10 secs
ata7.04: hard resetting link
ata7.04: failed to read SCR 2 (Emask=0x40)
ata7.04: failed to read SCR 2 (Emask=0x40)
ata7.04: COMRESET failed (errno=-5)
ata7.04: failed to read SCR 0 (Emask=0x40)
ata7.04: reset failed, giving up
ata7.15: hard resetting link
ata7: controller in dubious state, performing PORT_RST
ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata7.00: hard resetting link
ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata7.01: hard resetting link
ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.02: hard resetting link
ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.03: hard resetting link
ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.04: hard resetting link
ata7.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.05: hard resetting link
ata7.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata7.00: configured for UDMA/100
ata7.01: configured for UDMA/100
ata7.02: configured for UDMA/100
ata7.03: configured for UDMA/100
ata7.04: ATA-7: SAMSUNG HD103UJ, 1AA01113, max UDMA7
ata7.04: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata7.04: configured for UDMA/100
ata7.00: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x1 t4
ata7.00: irq_stat 0x00060002, failed to transmit command FIS
ata7.00: configured for UDMA/100
ata7: EH complete
sd 7:0:0:0: [sdl] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:0:0:0: [sdl] Write Protect is off
sd 7:0:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:1:0:0: [sdm] Write Protect is off
sd 7:1:0:0: [sdm] Mode Sense: 00 3a 00 00
sd 7:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:2:0:0: [sdn] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:2:0:0: [sdn] Write Protect is off
sd 7:2:0:0: [sdn] Mode Sense: 00 3a 00 00
sd 7:2:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:3:0:0: [sdo] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:3:0:0: [sdo] Write Protect is off
sd 7:3:0:0: [sdo] Mode Sense: 00 3a 00 00
sd 7:3:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:0:0:0: [sdl] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:0:0:0: [sdl] Write Protect is off
sd 7:0:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:1:0:0: [sdm] Write Protect is off
sd 7:1:0:0: [sdm] Mode Sense: 00 3a 00 00
sd 7:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:2:0:0: [sdn] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:2:0:0: [sdn] Write Protect is off
sd 7:2:0:0: [sdn] Mode Sense: 00 3a 00 00
sd 7:2:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:3:0:0: [sdo] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:3:0:0: [sdo] Write Protect is off
sd 7:3:0:0: [sdo] Mode Sense: 00 3a 00 00
sd 7:3:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
scsi 7:4:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
sd 7:4:0:0: [sdp] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:4:0:0: [sdp] Write Protect is off
sd 7:4:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 7:4:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:4:0:0: [sdp] 1953525168 512-byte hardware sectors (1000205 MB)
sd 7:4:0:0: [sdp] Write Protect is off
sd 7:4:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 7:4:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdp:
sd 7:4:0:0: [sdp] Attached SCSI disk

Best Regards,
/LM

