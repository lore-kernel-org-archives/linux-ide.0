From: Tim Small <tim@seoss.co.uk>
Subject: Power-up-in-standby Hitachi 5K3000 fails with either sata_sil24 or
 pmp, but not direct to AHCI controllers
Date: Thu, 09 Jun 2011 14:16:07 +0100
Message-ID: <4DF0C797.201@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay0.allsecurenet.com ([109.169.27.60]:44686 "EHLO
	relay0.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242Ab1FINQK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2011 09:16:10 -0400
Received: from [78.105.152.189] (helo=zebedee.buttersideup.com)
	by relay0.allsecurenet.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <tim@seoss.co.uk>)
	id 1QUf5j-0006uF-NB
	for linux-ide@vger.kernel.org; Thu, 09 Jun 2011 14:16:07 +0100
Received: from [91.208.163.30] (ermintrude [91.208.163.30])
	by zebedee.buttersideup.com (Postfix) with ESMTP id 50C2040DFF
	for <linux-ide@vger.kernel.org>; Thu,  9 Jun 2011 14:16:07 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm building a storage server with a number of 2TB Hitachi "5K3000"
5900rpm drives.  The drives support power up in standby, and I'd like to
make use of this so that I can use a smaller (and thus more efficient)
power supply in the system (each drive is speced at 4.4 watts idle, but
32 watts max startup power - I haven't taken peak current draw when busy
yet, but I'm guessing it'll end up at less than half of 32 watts per
drive...).

The drives work with power-up-in-standby with the AHCI driver (Intel H67
SATA2 and SATA3 ports, as well as Marvel 88SE9123 SATA3) - however there
do seem to be quite a few hard link resets...

The drives fail to appear at all when connected to either Silicon Image
3132 controllers, 3124 controllers, or any controller when used with a
Silicon Image 3726 port multiplier.  I haven't been able to test with
any other drive models yet.

Some dmesg extracts when hot-plugging the drives (all with Debian's
2.6.38 kernel) follow:

Intel AHCI direct-attached:

1220.664341] ata11: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen
1220.664572] ata11: irq_stat 0x00000040, connection status changed
1220.664734] ata11: SError: { CommWake DevExch }
1220.664887] ata11: hard resetting link
1221.557691] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1226.556112] ata11.00: qc timeout (cmd 0xef)
1226.556277] ata11.00: failed to IDENTIFY (SPINUP failed, err_mask=0x4)
1226.556445] ata11: hard resetting link
1231.638339] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1231.640024] ata11.00: ATA-8: Hitachi HDS5C3020ALA632, ML6OA580, max UDMA/133
1231.640206] ata11.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
1231.642049] ata11.00: configured for UDMA/133
1231.642215] ata11: EH complete
1231.642436] scsi 10:0:0:0: Direct-Access     ATA      Hitachi HDS5C302 ML6O PQ: 0 ANSI: 5
1231.643337] sd 10:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
1231.643462] sd 10:0:0:0: [sdd] Write Protect is off
1231.643468] sd 10:0:0:0: [sdd] Mode Sense: 00 3a 00 00
1231.643524] sd 10:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
1231.668042]  sdd: unknown partition table
1231.668377] sd 10:0:0:0: [sdd] Attached SCSI disk

Same for Marvel 9123 AHCI direct-attached:

1404.848982] ata18: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
1404.849216] ata18: irq_stat 0x80400040, connection status changed
1404.849378] ata18: SError: { PHYRdyChg CommWake DevExch }
1404.849538] ata18: hard resetting link
1405.744394] ata18: SATA link up 6.0 Gbps (SStatus 133 SControl 370)
1410.742706] ata18.00: qc timeout (cmd 0xef)
1410.742874] ata18.00: failed to IDENTIFY (SPINUP failed, err_mask=0x4)
1410.743043] ata18: hard resetting link
1415.769067] ata18: SATA link up 6.0 Gbps (SStatus 133 SControl 370)
1415.770782] ata18.00: ATA-8: Hitachi HDS5C3020ALA632, ML6OA580, max UDMA/133
1415.770968] ata18.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
1415.772799] ata18.00: configured for UDMA/133
1415.772963] ata18: EH complete
1415.773184] scsi 17:0:0:0: Direct-Access     ATA      Hitachi HDS5C302 ML6O PQ: 0 ANSI: 5
1415.773911] sd 17:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
1415.774030] sd 17:0:0:0: [sdd] Write Protect is off
1415.774033] sd 17:0:0:0: [sdd] Mode Sense: 00 3a 00 00
1415.774115] sd 17:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
1415.796796]  sdd: unknown partition table
1415.797143] sd 17:0:0:0: [sdd] Attached SCSI disk

Same for Silicon Image 3124:

1588.754223] ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
1588.754408] ata5: irq_stat 0x00b40090, PHY RDY changed
1588.754565] ata5: hard resetting link
1590.950794] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
1595.949092] ata5.00: qc timeout (cmd 0xef)
1595.964485] ata5.00: failed to IDENTIFY (SPINUP failed, err_mask=0x4)
1595.964657] ata5: hard resetting link
1600.863497] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
1605.861974] ata5.00: qc timeout (cmd 0xec)
1605.862143] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
1605.862310] ata5: limiting SATA link speed to 1.5 Gbps
1605.862468] ata5: hard resetting link
1615.866464] ata5: softreset failed (timeout)
1615.866626] ata5: hard resetting link
1625.871134] ata5: softreset failed (timeout)
1625.871297] ata5: hard resetting link
1660.859489] ata5: softreset failed (timeout)
1660.859648] ata5: hard resetting link
1665.857825] ata5: softreset failed (timeout)
1665.857988] ata5: reset failed, giving up
1665.858151] ata5: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen t4
1665.858378] ata5: SError: { PHYRdyChg CommWake DevExch }
1665.858540] ata5: hard resetting link
1675.862496] ata5: softreset failed (timeout)
1675.862660] ata5: hard resetting link
1685.867165] ata5: softreset failed (timeout)
1685.867332] ata5: hard resetting link
1720.855520] ata5: softreset failed (timeout)
1720.855685] ata5: limiting SATA link speed to 1.5 Gbps
1720.855840] ata5: hard resetting link
1725.853857] ata5: softreset failed (timeout)
1725.854020] ata5: reset failed, giving up
1725.854172] ata5: EH complete

... if I then didn't power down the drive, but instead attached it to the Marvell controller, it didn't come back, so I'd guess the interaction with the 3124 has wedged the drive permanently.

1767.839737] ata16: exception Emask 0x10 SAct 0x0 SErr 0x4000000 action 0xe frozen
1767.839987] ata16: irq_stat 0x80000040, connection status changed
1767.840154] ata16: SError: { DevExch }
1767.840310] ata16: hard resetting link
1777.860539] ata16: softreset failed (device not ready)
1777.860712] ata16: hard resetting link
1787.881203] ata16: softreset failed (device not ready)
1787.881370] ata16: hard resetting link
1798.853551] ata16: link is slow to respond, please be patient (ready=0)
1822.925540] ata16: softreset failed (device not ready)
1822.925713] ata16: limiting SATA link speed to 3.0 Gbps
1822.925871] ata16: hard resetting link
1828.123801] ata16: softreset failed (device not ready)
1828.123963] ata16: reset failed, giving up
1828.124110] ata16: EH complete



I then power-cycled the drive and attached it to the Intel H67 with Silicon Image 3726:

1918.840790] ata8.04: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
1918.840964] ata8.04: SError: { PHYRdyChg CommWake DevExch }
1918.841179] ata8.04: hard resetting link
1919.561559] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
1924.559728] ata8.04: qc timeout (cmd 0xef)
1924.559900] ata8.04: failed to IDENTIFY (SPINUP failed, err_mask=0x4)
1924.560070] ata8.15: hard resetting link
1925.331456] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1925.331867] ata8.00: hard resetting link
1925.651543] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
1925.651736] ata8.01: hard resetting link
1925.971437] ata8.01: SATA link down (SStatus 0 SControl 320)
1925.971632] ata8.02: hard resetting link
1926.291329] ata8.02: SATA link down (SStatus 0 SControl 320)
1926.291530] ata8.03: hard resetting link
1926.611227] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1926.611416] ata8.04: hard resetting link
1926.931121] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1926.931292] ata8.05: hard resetting link
1927.251013] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
1927.349262] ata8.00: configured for UDMA/133
1927.351871] ata8.03: configured for UDMA/133
1927.352041] ata8.04: failed to IDENTIFY (I/O error, err_mask=0x100)
1927.352204] ata8.15: hard resetting link
1928.122528] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1928.122887] ata8.00: hard resetting link
1928.442601] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
1928.442780] ata8.01: hard resetting linkutilise
1928.762495] ata8.01: SATA link down (SStatus 0 SControl 320)
1928.762683] ata8.02: hard resetting link
1929.082419] ata8.02: SATA link down (SStatus 0 SControl 320)
1929.082621] ata8.03: hard resetting link
1929.402296] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1931.929261] ata8.04: hard resetting link
1932.249355] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1932.249543] ata8.05: hard resetting link
1932.569276] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
1932.669961] ata8.00: configured for UDMA/133
1932.672764] ata8.03: configured for UDMA/133
1932.672940] ata8.04: failed to IDENTIFY (I/O error, err_mask=0x100)
1932.673114] ata8.04: failed to recover link after 3 tries, disabling
1932.673283] ata8.15: hard resetting link
1933.444764] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1933.764736] ata8.00: hard resetting link
1934.084728] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
1934.084908] ata8.01: hard resetting link
1934.404621] ata8.01: SATA link down (SStatus 0 SControl 320)
1934.404809] ata8.02: hard resetting link
1934.724515] ata8.02: SATA link down (SStatus 0 SControl 320)
1934.724699] ata8.03: hard resetting link
1935.044419] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1937.567385] ata8.05: hard resetting link
1937.887472] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
1937.990659] ata8.00: configured for UDMA/133
1937.993318] ata8.03: configured for UDMA/133
1937.993509] ata8: EH complete

Any ideas?  My initial thought is perhaps the drive gets a reset whilst it was loading it's microcode or something, and then doesn't recover from that?

Cheers,

Tim.




-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

