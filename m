From: Stefan Skotte <stefan.skotte@gmail.com>
Subject: State of Port Multiplier Support in libata?
Date: Fri, 29 Jun 2007 11:47:54 +0200
Message-ID: <4684D54A.8030307@enhance-it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:44304 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239AbXF2Jr7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 05:47:59 -0400
Received: by ug-out-1314.google.com with SMTP id j3so774972ugf
        for <linux-ide@vger.kernel.org>; Fri, 29 Jun 2007 02:47:57 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I was wondering what the odds are that my setup could be supported:

* Stardom/Raidon SOHOTANK ST-6600 (5 disk SATA array)
(http://www.stardom.com.tw/sohotank%20st6600.htm)
* STLab Silicon Image 3531 NCQ/FIS PMP PCIe adapter with one eSATA port
(uses sata_sil24).
(http://www.st-lab.com/assign.asp?keyid=bf9)

The classical example of it not working properly is that only one disk
in bay 2 is recognized; all other does not respond at all:

(the following denotes a few retries of getting the enclosure to work)

========
[ 2853.136680] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2
frozen
[ 2853.136689] ata1: (irq_stat 0x00b00090, PHY RDY changed)
[ 2853.849146] ata1: soft resetting port
[ 2854.575897] ata1: softreset failed (SRST command error)
[ 2854.575904] ata1: reset failed (errno=-5), retrying in 10 secs
[ 2863.832012] ata1: hard resetting port
[ 2866.116128] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2866.131290] ata1.00: ata_hpa_resize 1: sectors = 976773168,
hpa_sectors = 976773168
[ 2866.131300] ata1.00: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
[ 2866.131305] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 2866.132337] ata1.00: ata_hpa_resize 1: sectors = 976773168,
hpa_sectors = 976773168
[ 2866.132349] ata1.00: configured for UDMA/100
[ 2866.132357] ata1: EH complete
[ 2866.132979] scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000YS-01M
09.0 PQ: 0 ANSI: 5
[ 2866.133196] sd 0:0:0:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[ 2866.133349] sd 0:0:0:0: [sdb] Write Protect is off
[ 2866.133352] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2866.133596] sd 0:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[ 2866.133802] sd 0:0:0:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[ 2866.133951] sd 0:0:0:0: [sdb] Write Protect is off
[ 2866.133954] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2866.134190] sd 0:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[ 2866.134194]  sdb: sdb1
[ 2866.137954] sd 0:0:0:0: [sdb] Attached SCSI disk
[ 2866.138016] sd 0:0:0:0: Attached scsi generic sg2 type 0
[ 2888.640954] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[ 2888.640962] ata1: (irq_stat 0x01100010, PHY RDY changed)
[ 2889.352204] ata1: soft resetting port
[ 2889.352215] ata1: SATA link down (SStatus 0 SControl 300)
[ 2889.352224] ata1: failed to recover some devices, retrying in 5 secs
[ 2894.347612] ata1: hard resetting port
[ 2896.631711] ata1: softreset failed (SRST command error)
[ 2896.631718] ata1: reset failed (errno=-5), retrying in 8 secs
[ 2904.330473] ata1: hard resetting port
[ 2906.614575] ata1: softreset failed (SRST command error)
[ 2906.614582] ata1: reset failed (errno=-5), retrying in 8 secs
[ 2914.313359] ata1: hard resetting port
[ 2916.597439] ata1: softreset failed (SRST command error)
[ 2916.597446] ata1: reset failed (errno=-5), retrying in 33 secs
[ 2949.253385] ata1: hard resetting port
[ 2951.537463] ata1: softreset failed (SRST command error)
[ 2951.537471] ata1: reset failed, giving up
[ 2951.537475] ata1.00: disabled
[ 2951.537481] ata1: EH pending after completion, repeating EH (cnt=4)
[ 2951.537492] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2
frozen
[ 2951.537496] ata1: (irq_stat 0x00a00080, device exchanged)
[ 2952.252216] ata1: soft resetting port
[ 2952.356056] ata1: softreset failed (SRST command error)
[ 2952.356063] ata1: reset failed (errno=-5), retrying in 10 secs
[ 2962.235101] ata1: hard resetting port
[ 2964.519180] ata1: softreset failed (SRST command error)
[ 2964.519187] ata1: reset failed (errno=-5), retrying in 8 secs
[ 2972.217964] ata1: hard resetting port
[ 2974.502045] ata1: softreset failed (SRST command error)
[ 2974.502051] ata1: reset failed (errno=-5), retrying in 33 secs
[ 3007.158016] ata1: hard resetting port
[ 3009.442069] ata1: softreset failed (SRST command error)
[ 3009.442076] ata1: reset failed, giving up
[ 3009.442084] ata1: EH complete
[ 3009.442958] sd 0:0:0:0: [sdb] Synchronizing SCSI cache
[ 3009.444698] sd 0:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[ 3009.444705] sd 0:0:0:0: [sdb] Stopping disk
[ 3009.444722] sd 0:0:0:0: [sdb] START_STOP FAILED
[ 3009.444724] sd 0:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[ 3009.445350] ACPI: PCI interrupt for device 0000:01:00.0 disabled
[ 3014.640966] sata_sil24 0000:01:00.0: version 0.9
[ 3014.640991] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level,
low) -> IRQ 16
[ 3014.641022] PCI: Setting latency timer of device 0000:01:00.0 to 64
[ 3014.641300] scsi3 : sata_sil24
[ 3014.641373] ata4: SATA max UDMA/100 cmd 0xf8b9c000 ctl 0x00000000
bmdma 0x00000000 irq 0
[ 3015.056432] ata4: softreset failed (SRST command error)
[ 3015.056440] ata4: reset failed (errno=-5), retrying in 10 secs
[ 3027.219595] ata4: softreset failed (SRST command error)
[ 3027.219604] ata4: reset failed (errno=-5), retrying in 8 secs
[ 3037.202438] ata4: softreset failed (SRST command error)
[ 3037.202448] ata4: reset failed (errno=-5), retrying in 33 secs
[ 3072.142463] ata4: softreset failed (SRST command error)
[ 3072.142471] ata4: reset failed, giving up
========

As you can see the first try went quite okay since the disk was present
in bay 2, but then I moved it to bay 3-4 in the consecutive attempts;
which let to some timeouts.

Hardware/Configuration information:

Ubuntu Gutsy, stock kernel 2.6.22 (sata_sil24 v0.9). I have previously
tried with Feisty 2.6.20 (sata_sil24 v0.8), but that didn't work either.

Commell LV-677, Intel 945GM Chipset, Core 2 Duo mobile CPU, 3 GB Ram

I have verified the scsi_luns are set to 512, which should be more than
enough (as I found a reference to this in a rPath support issue somewhere).

lspci output:

==============
00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express Memory Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express PCI Express Root Port (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML
Express Integrated Graphics Controller (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controller IDE (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 02)
01:00.0 Mass storage controller: Silicon Image, Inc. Unknown device 3531
(rev 01)
02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
Controller
03:0c.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61)
==============

Do I need a specific patch to enable my adapter, or is the support not
even there yet for my configuration ? (sure hope so :-/ )

Any help will be appreciated !


Kind Regards,
Stefan Skotte

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGhNVK+vG8YFo3LPMRAn9bAJ4/3+oxbbO9S5jEW5lBZWzpmZlVmQCfa65Z
7Z5I8VnK+JyA7XrSjIeVuJ8=
=mrwG
-----END PGP SIGNATURE-----
