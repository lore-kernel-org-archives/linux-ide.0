From: Phillip Susi <psusi@ubuntu.com>
Subject: PMP product ID mismatch
Date: Mon, 05 Jan 2015 20:25:38 -0500
Message-ID: <54AB3992.5090106@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:32949 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754175AbbAFBZs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2015 20:25:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm getting a PMP product ID mismatch error after the two drives in my
esata dock are attached to the scsi layer and IO fails to them and
they are then offlined.  When I connect the dock to another controller
it works fine.  What could cause this?  One thing I noticed is that
the good controller does not support FIS Based Switching, but the bad
one does.  Is there a way to disable fbs to see if that fixes it?

Here's what dmesg shows repeatedly:

[  860.620374] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  860.620979] ata9.15: Port Multiplier 1.1, 0x197b:0x2352 r0, 2
ports, feat 0x0/0x0
[  860.620984] ata9.15: Asynchronous notification not supported,
hotplug won't work on fan-out ports. Use warm-plug instead.
[  860.621002] ahci 0000:09:00.0: FBS is enabled
[  860.621134] ata9.00: hard resetting link
[  860.940645] ata9.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  860.940691] ata9.01: hard resetting link
[  861.260340] ata9.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  861.260991] ata9.00: ATA-9: WDC WD10EZEX-08M2NA0, 01.01A01, max
UDMA/100
[  861.260994] ata9.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
[  861.261909] ata9.00: configured for UDMA/100
[  861.262607] ata9.01: ATA-9: WDC WD10EZEX-08M2NA0, 01.01A01, max
UDMA/100
[  861.262612] ata9.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
[  861.263362] ata9.01: configured for UDMA/100
[  861.263445] ata9: EH complete
[  861.263457] ata9.00: detaching (SCSI 8:0:0:0)
[  861.266097] sd 8:0:0:0: [sdc] Synchronizing SCSI cache
[  861.266236] sd 8:0:0:0: [sdc] Stopping disk
[  861.676148] ata9.01: detaching (SCSI 8:1:0:0)
[  861.676650] sd 8:1:0:0: [sde] Synchronizing SCSI cache
[  861.676781] sd 8:1:0:0: [sde] Stopping disk
[  862.086251] scsi 8:0:0:0: Direct-Access     ATA      WDC
WD10EZEX-08M 1A01 PQ: 0 ANSI: 5
[  862.086528] sd 8:0:0:0: Attached scsi generic sg2 type 0
[  862.086637] scsi 8:1:0:0: Direct-Access     ATA      WDC
WD10EZEX-08M 1A01 PQ: 0 ANSI: 5
[  862.086903] sd 8:1:0:0: Attached scsi generic sg5 type 0
[  862.087745] sd 8:0:0:0: [sdc] 1953525168 512-byte logical blocks:
(1.00 TB/931 GiB)
[  862.087750] sd 8:0:0:0: [sdc] 4096-byte physical blocks
[  862.087765] sd 8:1:0:0: [sde] 1953525168 512-byte logical blocks:
(1.00 TB/931 GiB)
[  862.087768] sd 8:1:0:0: [sde] 4096-byte physical blocks
[  862.087851] sd 8:1:0:0: [sde] Write Protect is off
[  862.087854] sd 8:1:0:0: [sde] Mode Sense: 00 3a 00 00
[  862.087867] sd 8:0:0:0: [sdc] Write Protect is off
[  862.087870] sd 8:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  862.087901] sd 8:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  862.087989] sd 8:1:0:0: [sde] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  863.448163]  sde: sde1
[  863.448862] sd 8:1:0:0: [sde] Attached SCSI disk
[  863.523189]  sdc: sdc1
[  863.523947] sd 8:0:0:0: [sdc] Attached SCSI disk
[  863.612233] ata9.15: PMP product ID mismatch
[  863.612239] ata9.15: hard resetting link
[  863.929205] ata9.15: SATA link down (SStatus 0 SControl 300)
[  864.555564] ata9.15: failed to read PMP GSCR[0] (Emask=0x100)
[  864.555569] ata9.15: PMP revalidation failed (errno=-5)
[  864.555574] ata9.15: limiting SATA link speed to 1.5 Gbps
[  868.924411] ata9.15: hard resetting link
[  869.415954] ata9.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  869.416451] ata9.15: Port Multiplier vendor mismatch '0x197b' != '0x0'
[  869.416456] ata9.15: PMP revalidation failed (errno=-19)
[  872.209944] ata9.15: hard resetting link
[  872.700815] ata9.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  872.701358] ata9.15: Port Multiplier vendor mismatch '0x197b' != '0x0'
[  872.701363] ata9.15: PMP revalidation failed (errno=-19)
[  877.696028] ata9.15: hard resetting link
[  878.187571] ata9.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  878.188111] ata9.15: Port Multiplier vendor mismatch '0x197b' != '0x0'
[  878.188115] ata9.15: PMP revalidation failed (errno=-19)
[  878.188118] ata9.15: failed to recover PMP after 5 tries, giving up
[  878.188120] ata9.15: Port Multiplier detaching
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUqzmPAAoJENRVrw2cjl5R4fcH/RI0anQe3J5PcmcSYnW3f2r2
g0FGxVG0uwHWygHrBNt5HjTdJ1hmXM6HU8xFcNl8TfMpCBGtwOi3gu4IV0vGXjZ9
wALRcwQiWwUmvrK+/MUyfmHzSz4ITAhMHVdTDCpMsy/dCstP3p8XwhOl+GWSZe1o
RY0G6353Z3TugyfGLT9ddYRdAMyWns2VNXJbxiVtQUWLNWcmhEdbMUINYjF3BUjE
pYTJ9lnR9irnyXWlyiVtwAD/LYnGnKA7ev/1h/A1vW7azYxou0N90NxXB9I0Tp1M
x9n7tlDxCIjlW+Qi9q9rPwl60gd4sD2JcyQlCf5Q+j3P12OcL2EmKgqUuo+W/eA=
=BeK5
-----END PGP SIGNATURE-----
