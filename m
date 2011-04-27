From: Maciej Grela <maciej.grela@gmail.com>
Subject: How to perform SECURITY ERASE on a SEC4 (security enabled/locked)
 PATA drive ?
Date: Wed, 27 Apr 2011 22:15:47 +0200
Message-ID: <BANLkTikZt4Nr3DK3CkZXZ_ORgqjy-MGOUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48550 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab1D0UPs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Apr 2011 16:15:48 -0400
Received: by fxm17 with SMTP id 17so1383744fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 27 Apr 2011 13:15:47 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi ata gurus,

I have a 2.5'' PATA drive with security enabled and unknown password.
I'd like to erase that disk and use it. I've been trying to apply the
instructions at the libata wiki:
https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase but they cover
only the scenario in which the drive doesn't have security enabled
before we start the procedure. In my case this approach doesn't work
because I cannot set the password (step 3a):

8< ------------------------------------------------------------------------------
root@hikari:~# hdparm --verbose --user-master u --security-set-pass
abcd /dev/sdb
security_password="abcd"

/dev/sdb:
 Issuing SECURITY_SET_PASS command, password="abcd", user=user, mode=high
oflags.lob_all=0x82, flags={ feat command }
oflags.hob_all=0x82, flags={ feat }
using LBA48 taskfile
outgoing cdb:  85 0b 26 00 00 00 00 00 00 00 00 00 00 40 f1 00
data:  00 00 61 62 63 64 00 00 00 00 00 00 00 00 00 00
SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8
SG_IO: sb[]:  72 0b 00 00 00 00 00 0e 09 0c 01 04 00 00 00 00 00 00 00
00 e0 51 00 00 00 00 00 00 00 00 00 00
SG_IO: desc[]:  09 0c 01 04 00 00 00 00 00 00 00 00
     ATA_16 stat=51 err=04 nsect=00 lbal=00 lbam=00 lbah=00 dev=e0
I/O error, ata_op=0xf1 ata_status=0x51 ata_error=0x04
SECURITY_SET_PASS: Input/output error
root@hikari:~#
8< ------------------------------------------------------------------------------

The complete hdparm output for the drive is show below:

8< ------------------------------------------------------------------------------
root@hikari:~# hadparm -I /dev/sdb

/dev/sdb:

ATA device, with non-removable media
       Model Number:       Hitachi HTE541680J9AT00
       Serial Number:      SB024CGGJM5BGD
       Firmware Revision:  SB2OA75H
Standards:
       Used: ATA/ATAPI-7 T13 1532D revision 1
       Supported: 7 6 5 4
Configuration:
       Logical         max     current
       cylinders       16383   16383
       heads           16      16
       sectors/track   63      63
       --
       CHS current addressable sectors:   16514064
       LBA    user addressable sectors:  156301488
       LBA48  user addressable sectors:  156301488
       Logical/Physical Sector size:           512 bytes
       device size with M = 1024*1024:       76319 MBytes
       device size with M = 1000*1000:       80026 MBytes (80 GB)
       cache/buffer size  = 7512 KBytes (type=DualPortCache)
Capabilities:
       LBA, IORDY(can be disabled)
       Standby timer values: spec'd by Vendor, no device specific minimum
       R/W multiple sector transfer: Max = 16  Current = 16
       Advanced power management level: 254
       Recommended acoustic management value: 128, current value: 254
       DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
            Cycle time: min=120ns recommended=120ns
       PIO: pio0 pio1 pio2 pio3 pio4
            Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
       Enabled Supported:
          *    SMART feature set
          *    Security Mode feature set
          *    Power Management feature set
          *    Write cache
          *    Look-ahead
          *    Host Protected Area feature set
          *    WRITE_BUFFER command
          *    READ_BUFFER command
          *    NOP cmd
          *    DOWNLOAD_MICROCODE
          *    Advanced Power Management feature set
               Power-Up In Standby feature set
          *    SET_FEATURES required to spinup after power up
               Address Offset Reserved Area Boot
               SET_MAX security extension
          *    Automatic Acoustic Management feature set
          *    48-bit Address feature set
          *    Device Configuration Overlay feature set
          *    Mandatory FLUSH_CACHE
          *    FLUSH_CACHE_EXT
          *    SMART error logging
          *    SMART self-test
          *    General Purpose Logging feature set
          *    WRITE_{DMA|MULTIPLE}_FUA_EXT
          *    64-bit World wide name
Security:
       Master password revision code = 65534
               supported
               enabled
               locked
       not     frozen
       not     expired: security count
       not     supported: enhanced erase
       Security level high
       42min for SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 5000cca550e4e637
       NAA             : 5
       IEEE OUI        : 000cca
       Unique ID       : 550e4e637
HW reset results:
       CBLID- above Vih
       Device num = 0 determined by the jumper
Checksum: correct
root@hikari:~#
8< ------------------------------------------------------------------------------

The disk seems to be in SEC4 state (Security enabled / Locked)
according to the ATA spec. My interpretation of the state graph at
this point is, that issuing the SECURITY ERASE PREPARE and SECURITY
ERASE UNIT should erase the drive and switch it to SEC1 (Security
disabled/not Frozen). However, I cannot do this using hdparm in the
following way:

8< ------------------------------------------------------------------------------
root@hikari:~# hdparm --verbose --user-master  u --security-erase NULL /dev/sdb
security_password=""

/dev/sdb:
 Issuing SECURITY_ERASE command, password="", user=user
outgoing cdb:  85 06 20 00 00 00 00 00 00 00 00 00 00 40 f3 00
SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8
SG_IO: sb[]:  72 00 00 00 00 00 00 0e 09 0c 00 00 00 00 00 00 00 00 00
00 e0 50 00 00 00 00 00 00 00 00 00 00
SG_IO: desc[]:  09 0c 00 00 00 00 00 00 00 00 00 00
     ATA_16 stat=50 err=00 nsect=00 lbal=00 lbam=00 lbah=00 dev=e0
oflags.lob_all=0x82, flags={ feat command }
oflags.hob_all=0x82, flags={ feat }
using LBA48 taskfile
outgoing cdb:  85 0b 26 00 00 00 00 00 00 00 00 00 00 40 f4 00
data:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8
SG_IO: sb[]:  72 0b 00 00 00 00 00 0e 09 0c 01 04 00 00 00 00 00 00 00
00 e0 51 00 00 00 00 00 00 00 00 00 00
SG_IO: desc[]:  09 0c 01 04 00 00 00 00 00 00 00 00
     ATA_16 stat=51 err=04 nsect=00 lbal=00 lbam=00 lbah=00 dev=e0
I/O error, ata_op=0xf4 ata_status=0x51 ata_error=0x04
SECURITY_ERASE: Input/output error
root@hikari:~#
8< ------------------------------------------------------------------------------

The thing is, I don't know the password. Can you send the SECURITY
ERASE commands without knowing the password ? What am I missing ? Is
the operation I'm trying to perform even possible ?

Best regards,
Maciej Grela

PS. Please keep me on CC as I'm not subscribed to this list.
