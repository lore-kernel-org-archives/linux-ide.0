From: Lars Michael Jogback <lm@jogback.se>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Mon, 27 Oct 2008 20:40:38 +0100
Message-ID: <20081027194038.GA7004@cleopatra.jogback.se>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org> <20081014201917.GA5974@cleopatra.jogback.se> <48F595DB.4030301@kernel.org> <20081018165209.GA7754@cleopatra.jogback.se> <20081023181443.GA7323@cleopatra.jogback.se> <49056F2C.20101@kernel.org> <49056FEA.4070405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.jogback.se ([192.165.82.10]:49103 "EHLO mail.jogback.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbYJ0To4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 15:44:56 -0400
Content-Disposition: inline
In-Reply-To: <49056FEA.4070405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

* Tejun Heo <tj@kernel.org> [2008-10-27 16:38:18]:

> Oh.. one more thing.  Can you please try the attached patch and post the
> failing log?

Yank the drive:
[  423.185630] ata7: XXX error_intr irq_stat=0x8040800
[  423.200853] ata7.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  423.200930] ata7: SError: { PHYRdyChg CommWake DevExch }
[  423.201065] ata7.02: hard resetting link
[  423.988033] ata7.02: SATA link down (SStatus 0 SControl 320)
[  423.988033] ata7: failed to recover some devices, retrying in 5 secs
[  429.320975] ata7.02: hard resetting link
[  429.657112] ata7.02: SATA link down (SStatus 0 SControl 320)
[  429.657215] ata7: failed to recover some devices, retrying in 5 secs
[  435.205828] ata7.02: hard resetting link
[  435.663470] ata7.02: SATA link down (SStatus 0 SControl 320)
[  435.663573] ata7.02: disabled
[  436.233999] ata7: EH complete
[  436.234100] ata7.02: detaching (SCSI 7:2:0:0)
[  436.234390] sd 7:2:0:0: [sdn] Synchronizing SCSI cache
[  436.237266] sd 7:2:0:0: [sdn] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  436.237399] sd 7:2:0:0: [sdn] Stopping disk
[  436.237471] sd 7:2:0:0: [sdn] START_STOP FAILED
[  436.237537] sd 7:2:0:0: [sdn] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

Hotplug the drive:
[  457.946173] ata7: XXX error_intr irq_stat=0x8040800
[  457.946173] ata7: XXX error_intr irq_stat=0x8000800
[  457.959773] ata7.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  457.959849] ata7: SError: { PHYRdyChg CommWake DevExch }
[  457.959985] ata7.02: hard resetting link
[  458.740089] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  458.740173] ata7: XXX error_intr irq_stat=0x60002
[  458.740252] ata7: XXX error_intr cerr=4
[  458.755959] ata7.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  458.756096] ata7.15: hard resetting link
[  461.059644] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  461.059946] ata7.00: hard resetting link
[  461.395778] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  461.395852] ata7.01: hard resetting link
[  461.736413] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  461.736490] ata7.02: hard resetting link
[  462.107859] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  462.107935] ata7.03: hard resetting link
[  462.471134] ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  462.471210] ata7.04: hard resetting link
[  462.810982] ata7.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  462.811057] ata7.05: hard resetting link
[  463.146993] ata7.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  463.159869] ata7.00: configured for UDMA/100
[  463.172734] ata7.01: configured for UDMA/100
[  463.172811] ata7: XXX error_intr irq_stat=0x60002
[  463.172882] ata7: XXX error_intr cerr=4
[  463.186852] ata7.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  463.186927] ata7.15: hard resetting link
[  465.319661] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  465.319970] ata7.00: hard resetting link
[  465.657449] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  465.657525] ata7.01: hard resetting link
[  465.992843] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  465.992918] ata7.02: hard resetting link
[  466.328237] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  466.328312] ata7.03: hard resetting link
[  466.663786] ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  466.663861] ata7.04: hard resetting link
[  467.002569] ata7.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  467.002646] ata7.05: hard resetting link
[  467.336553] ata7.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  467.351825] ata7.00: configured for UDMA/100
[  467.364948] ata7.01: configured for UDMA/100
[  467.365025] ata7: XXX error_intr irq_stat=0x60002
[  467.365096] ata7: XXX error_intr cerr=4
[  467.379054] ata7.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  467.379128] ata7.02: failed to recover link after 3 tries, disabling
[  467.379200] ata7: failed to recover PMP, retrying in 5 secs
[  472.390964] ata7.15: hard resetting link
[  474.544791] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  474.859237] ata7.00: hard resetting link
[  475.195706] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  475.195793] ata7.01: hard resetting link
[  475.535565] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  475.535641] ata7.03: hard resetting link
[  475.871163] ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  475.871238] ata7.04: hard resetting link
[  476.208521] ata7.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  476.208597] ata7.05: hard resetting link
[  476.547685] ata7.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  476.560025] ata7.00: configured for UDMA/100
[  476.572026] ata7.01: configured for UDMA/100
[  476.584854] ata7.03: configured for UDMA/100
[  476.597676] ata7.04: configured for UDMA/100
[  476.935580] ata7: EH complete
[  476.935691] sd 7:0:0:0: [sdl] 1953525168 512-byte hardware sectors (1000205 MB)
[  476.935798] sd 7:0:0:0: [sdl] Write Protect is off
[  476.935865] sd 7:0:0:0: [sdl] Mode Sense: 00 3a 00 00
[  476.935885] sd 7:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  476.935991] sd 7:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
[  476.936086] sd 7:1:0:0: [sdm] Write Protect is off
[  476.936152] sd 7:1:0:0: [sdm] Mode Sense: 00 3a 00 00
[  476.936171] sd 7:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  476.936276] sd 7:3:0:0: [sdo] 1953525168 512-byte hardware sectors (1000205 MB)
[  476.936370] sd 7:3:0:0: [sdo] Write Protect is off
[  476.936437] sd 7:3:0:0: [sdo] Mode Sense: 00 3a 00 00
[  476.936456] sd 7:3:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  476.936561] sd 7:4:0:0: [sdp] 1953525168 512-byte hardware sectors (1000205 MB)
[  476.936655] sd 7:4:0:0: [sdp] Write Protect is off
[  476.936722] sd 7:4:0:0: [sdp] Mode Sense: 00 3a 00 00
[  476.936740] sd 7:4:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  476.936845] sd 7:0:0:0: [sdl] 1953525168 512-byte hardware sectors (1000205 MB)
[  476.936938] sd 7:0:0:0: [sdl] Write Protect is off
[  476.937005] sd 7:0:0:0: [sdl] Mode Sense: 00 3a 00 00
[  476.937024] sd 7:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  476.937128] sd 7:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
[  476.937236] sd 7:1:0:0: [sdm] Write Protect is off
[  476.937303] sd 7:1:0:0: [sdm] Mode Sense: 00 3a 00 00
[  476.937322] sd 7:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  476.937427] sd 7:3:0:0: [sdo] 1953525168 512-byte hardware sectors (1000205 MB)
[  476.937521] sd 7:3:0:0: [sdo] Write Protect is off
[  476.937588] sd 7:3:0:0: [sdo] Mode Sense: 00 3a 00 00
[  476.937606] sd 7:3:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  476.937710] sd 7:4:0:0: [sdp] 1953525168 512-byte hardware sectors (1000205 MB)
[  476.937804] sd 7:4:0:0: [sdp] Write Protect is off
[  476.937871] sd 7:4:0:0: [sdp] Mode Sense: 00 3a 00 00
[  476.937890] sd 7:4:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Best Regards,
/LM

