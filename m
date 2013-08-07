From: DeadManMoving <sequel@neofreak.org>
Subject: SATA PMP issue
Date: Wed, 07 Aug 2013 12:11:07 -0400
Message-ID: <1375891867.3607.8.camel@lappy.neofreak.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out.neofreak.org ([69.165.217.67]:53576 "EHLO
	vortex.neofreak.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932115Ab3HGQSA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Aug 2013 12:18:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hi Mister Heo and list,

i am unable to get SATA port multiplier to work between a Marvell SATA
88SE9120 CARD (HighPoint Rocket 622A) and four disks within a Mediasonic
HF2-SU3S2 enclosure.

Howerver, the Mediasonic enclosure is working with a SiI 3132 controller
(i can see all four disks) and also, i have a Thermaltake BlacX Duet
which is working on the 88SE9120 (i can see both disks).

Here is what the kernel have to say when i try to get the 88SE9120 to
work with the Mediasonic enclosure :



[  485.988225] ahci 0000:05:00.0: version 3.0
[  485.988282] ahci 0000:05:00.0: irq 69 for MSI/MSI-X
[  485.988320] ahci 0000:05:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps
0x3 impl SATA mode
[  485.988322] ahci 0000:05:00.0: flags: 64bit ncq sntf led only pmp fbs
pio slum part sxs 
[  485.988550] scsi13 : ahci
[  485.988651] scsi14 : ahci
[  485.988805] ata11: SATA max UDMA/133 abar m2048@0xf9fff000 port
0xf9fff100 irq 69
[  485.988807] ata12: SATA max UDMA/133 abar m2048@0xf9fff000 port
0xf9fff180 irq 69
[  486.337917] ata12: SATA link down (SStatus 0 SControl 330)
[  489.412860] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
[  489.413068] ata11.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 15
ports, feat 0x5/0xf
[  489.414144] ahci 0000:05:00.0: FBS is enabled
[  489.414525] ata11.00: hard resetting link
[  489.962128] ata11.00: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  489.962158] ata11.01: hard resetting link
[  491.030211] ata11.01: failed to resume link (SControl 123)
[  491.230038] ata11.01: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  491.230068] ata11.02: hard resetting link
[  492.298122] ata11.02: failed to resume link (SControl 123)
[  492.497942] ata11.02: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  492.497972] ata11.03: hard resetting link
[  493.566041] ata11.03: failed to resume link (SControl 123)
[  493.765862] ata11.03: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  493.765891] ata11.04: hard resetting link
[  494.833949] ata11.04: failed to resume link (SControl 123)
[  495.033771] ata11.04: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  495.033801] ata11.05: hard resetting link
[  496.101863] ata11.05: failed to resume link (SControl 123)
[  496.301680] ata11.05: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  496.301705] ata11.06: hard resetting link
[  497.369777] ata11.06: failed to resume link (SControl 123)
[  497.569604] ata11.06: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  497.569632] ata11.07: hard resetting link
[  498.637685] ata11.07: failed to resume link (SControl 123)
[  498.837513] ata11.07: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  498.837542] ata11.08: hard resetting link
[  499.905610] ata11.08: failed to resume link (SControl 123)
[  500.105431] ata11.08: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  500.105460] ata11.09: hard resetting link
[  501.173513] ata11.09: failed to resume link (SControl 123)
[  501.373336] ata11.09: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  501.373364] ata11.10: hard resetting link
[  502.441428] ata11.10: failed to resume link (SControl 123)
[  502.641245] ata11.10: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  502.641274] ata11.11: hard resetting link
[  503.709341] ata11.11: failed to resume link (SControl 123)
[  503.909165] ata11.11: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  503.909195] ata11.12: hard resetting link
[  504.977254] ata11.12: failed to resume link (SControl 123)
[  505.177078] ata11.12: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  505.177108] ata11.13: hard resetting link
[  506.245167] ata11.13: failed to resume link (SControl 123)
[  506.444986] ata11.13: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  506.445011] ata11.14: hard resetting link
[  507.513083] ata11.14: failed to resume link (SControl 123)
[  507.712905] ata11.14: SATA link up 3.0 Gbps (SStatus 123 SControl
123)
[  507.713704] ata11.00: ATA-8: ST2000DM001-1CH164, CC26, max UDMA/133
[  507.713707] ata11.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
[  507.714583] ata11.00: configured for UDMA/133
[  512.704514] ata11.01: qc timeout (cmd 0xec)
[  512.704522] ata11.01: failed to IDENTIFY (I/O error, err_mask=0x4)
[  512.704526] ata11.15: hard resetting link
[  516.128880] ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl
330)
[  516.129067] ata11.15: Port Multiplier vendor mismatch '0x197b' !=
'0x123'
[  516.129070] ata11.15: PMP revalidation failed (errno=-19)
[  521.120660] ata11.15: hard resetting link
[  524.545031] ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl
330)
[  524.545219] ata11.15: Port Multiplier vendor mismatch '0x197b' !=
'0x123'
[  524.545222] ata11.15: PMP revalidation failed (errno=-19)
[  524.545225] ata11.15: limiting SATA link speed to 1.5 Gbps
[  529.536804] ata11.15: hard resetting link
[  532.961174] ata11.15: SATA link up 1.5 Gbps (SStatus 113 SControl
310)
[  532.961366] ata11.15: Port Multiplier vendor mismatch '0x197b' !=
'0x123'
[  532.961369] ata11.15: PMP revalidation failed (errno=-19)
[  532.961371] ata11.15: failed to recover PMP after 5 tries, giving up
[  532.961373] ata11.15: Port Multiplier detaching
[  532.961376] ata11.00: disabled
[  532.961386] ata11.00: disabled
[  532.961390] ata11: EH complete



I have tried with :

modprobe ahci marvell_enable=1

but does not look to work neither.

I am running vanilla 3.11.0-rc4 from kernel.org

I saw a comment from you on this list
(http://marc.info/?l=linux-ide&m=131434190330255&w=2) stating that the
controller must be in wrong state if the kernel is reporting "Port
Multiplier vendor mismatch" error message but, the controller seem fine
since it is working with the Thermaltake BlacX Duet enclosure.



Regards,

Tony

