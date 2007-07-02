From: Stefan Skotte <sfs@enhance-it.dk>
Subject: Re: State of Port Multiplier Support in libata?
Date: Mon, 02 Jul 2007 11:21:51 +0200
Message-ID: <4688C3AF.2060100@enhance-it.dk>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com> <4688AB51.8080801@enhance-it.dk> <4688AE9D.7060008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from csmtp.b-one.net ([195.47.247.21]:37507 "EHLO csmtp1.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbXGBJVy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 05:21:54 -0400
In-Reply-To: <4688AE9D.7060008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tejun,

I've just compiled, and I'm now running the kernel with the patches applied.

It seems to work, however I'm not sure why the SATA Link is 1.5gb/s ?
Both my disks are SATA-II 300.

Here's some system information related to the patch(es):

========== hdparm -Tt /dev/sd[bc]1 ===========
/dev/sdb1:
 Timing cached reads:   2786 MB in  2.00 seconds = 1393.25 MB/sec
 Timing buffered disk reads:  232 MB in  3.01 seconds =  77.17 MB/sec

/dev/sdc1:
 Timing cached reads:   2742 MB in  2.00 seconds = 1370.87 MB/sec
 Timing buffered disk reads:  208 MB in  3.02 seconds =  68.88 MB/sec

========== dmesg ==========
[   90.256606] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa
frozen
[   90.256615] ata1: irq_stat 0x00b40090 <PHY RDY changed>
[   90.256625] ata1: hard resetting link
[   92.449372] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   92.593106] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x9/0x9
[   92.720891] ata1.00: hard resetting link
[   93.204061] ata1.00: softreset failed (SRST command error)
[   93.204068] ata1.00: reset failed (errno=-5), retrying in 10 secs
[  102.703482] ata1.00: hard resetting link
[  103.314425] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  103.330386] ata1.01: hard resetting link
[  103.893414] ata1.01: SATA link down (SStatus 0 SControl 300)
[  103.909388] ata1.02: hard resetting link
[  104.472403] ata1.02: SATA link down (SStatus 0 SControl 300)
[  104.488388] ata1.03: hard resetting link
[  105.051395] ata1.03: SATA link down (SStatus 0 SControl 300)
[  105.067367] ata1.04: hard resetting link
[  105.662330] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  105.662336] ata1.05: hard resetting link
[  106.225347] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  106.260017] ata1.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[  106.260023] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  106.318220] ata1.00: configured for UDMA/100
[  106.333611] ata1.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
[  106.333617] ata1.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  106.334621] ata1.04: configured for UDMA/100
[  106.349138] ata1: EH complete
[  106.349170] PM: Adding info for No Bus:target0:0:0
[  106.349323] scsi 0:0:0:0: Direct-Access     ATA      ST3750640AS
 3.AA PQ: 0 ANSI: 5
[  106.349336] PM: Adding info for scsi:0:0:0:0
[  106.350572] sd 0:0:0:0: [sdb] 1465149168 512-byte hardware sectors
(750156 MB)
[  106.350589] sd 0:0:0:0: [sdb] Write Protect is off
[  106.350591] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  106.350615] sd 0:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  106.350666] sd 0:0:0:0: [sdb] 1465149168 512-byte hardware sectors
(750156 MB)
[  106.350678] sd 0:0:0:0: [sdb] Write Protect is off
[  106.350680] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  106.350702] sd 0:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  106.350705]  sdb: sdb1
[  106.366234] sd 0:0:0:0: [sdb] Attached SCSI disk
[  106.366296] sd 0:0:0:0: Attached scsi generic sg2 type 0
[  106.366329] PM: Adding info for No Bus:target0:0:4
[  106.366807] scsi 0:0:4:0: Direct-Access     ATA      WDC WD5000YS-01M
09.0 PQ: 0 ANSI: 5
[  106.366814] PM: Adding info for scsi:0:0:4:0
[  106.367883] sd 0:0:4:0: [sdc] 976773168 512-byte hardware sectors
(500108 MB)
[  106.367896] sd 0:0:4:0: [sdc] Write Protect is off
[  106.367899] sd 0:0:4:0: [sdc] Mode Sense: 00 3a 00 00
[  106.367922] sd 0:0:4:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  106.367963] sd 0:0:4:0: [sdc] 976773168 512-byte hardware sectors
(500108 MB)
[  106.367976] sd 0:0:4:0: [sdc] Write Protect is off
[  106.367978] sd 0:0:4:0: [sdc] Mode Sense: 00 3a 00 00
[  106.368000] sd 0:0:4:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  106.368003]  sdc: sdc1
[  106.373944] sd 0:0:4:0: [sdc] Attached SCSI disk
[  106.373977] sd 0:0:4:0: Attached scsi generic sg3 type 0
[  154.013280] kjournald starting.  Commit interval 5 seconds
[  154.018158] EXT3 FS on sdb1, internal journal
[  154.018168] EXT3-fs: mounted filesystem with ordered data mode.
[  156.854093] kjournald starting.  Commit interval 5 seconds
[  156.861351] EXT3 FS on sdc1, internal journal
[  156.861361] EXT3-fs: mounted filesystem with ordered data mode.
============================

Still my controller is not identified (PCI id?); dont know if thats
something you want to change for the final patch:

01:00.0 Mass storage controller: Silicon Image, Inc. Unknown device 3531
(rev 01)



- -Stefan

Tejun Heo wrote:
> Stefan Skotte wrote:
>> drivers/scsi/ipr.c: In function __ipr_eh_dev_reset:
>> drivers/scsi/ipr.c:3955: warning: passing argument 4 of ata_do_eh from
>> incompatible pointer type
>> drivers/scsi/ipr.c: In function ipr_ata_phy_reset:
>> drivers/scsi/ipr.c:5049: error: struct ata_port has no member named
>> device
>> drivers/scsi/ipr.c:5053: error: struct ata_port has no member named
>> device
>> drivers/scsi/ipr.c:5056: error: struct ata_port has no member named
>> device
>> make[3]: *** [drivers/scsi/ipr.o] Error 1
>> make[2]: *** [drivers/scsi] Error 2
>> make[1]: *** [drivers] Error 2
>> make[1]: Leaving directory `/usr/src/linux-2.6.22-rc6'
>> make: *** [debian/stamp-build-kernel] Error 2
> 
> Aiee, that's my bad.  I forgot to convert ipr.
> 
>> I just removed the ipr module since I'm not going to use it, but maybe
>> I'm doing something wrong since I'm usng the debian build process (?),
>> anyways I downloaded 2.6.22-rc6 from testing on kernel.org, so that
>> should atleast be right.
>>
>> Thanks for getting back to me, I will report back how well my 3531-based
>> controller fares...
> 
> Thanks.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGiMOv+vG8YFo3LPMRAkpOAKCjNCxGz4f+S20SOM8azZGnnMgufwCcCZXI
py27dunJY0xf+Q8EU8hM7bc=
=8cHz
-----END PGP SIGNATURE-----
