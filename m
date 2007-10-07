From: diego torres <dtorres@coral.dnsalias.org>
Subject: blacklisting ST3500630AS as not able to do NCQ
Date: Sun, 7 Oct 2007 22:56:27 +0200
Message-ID: <1993911428.20071007225627@coral.dnsalias.org>
Reply-To: diego torres <dtorres@coral.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 198.Red-217-127-201.staticIP.rima-tde.net ([217.127.201.198]:41654
	"EHLO anthalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310AbXJGVYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 17:24:08 -0400
Received: from localhost (anthalia.lan [192.168.49.100])
	by anthalia.com (Postfix) with ESMTP id 4E525CDE8
	for <linux-ide@vger.kernel.org>; Sun,  7 Oct 2007 22:56:48 +0200 (CEST)
Received: from anthalia.com ([217.127.201.198])
	by localhost (anthalia.com [192.168.49.100]) (amavisd-new, port 10024)
	with ESMTP id 93MPDQ4-wNVU for <linux-ide@vger.kernel.org>;
	Sun,  7 Oct 2007 22:56:27 +0200 (CEST)
Received: from atasha.anthalia.lan (atasha.anthalia.lan [192.168.49.19])
	by anthalia.com (Postfix) with ESMTP id 6248BCC7F
	for <linux-ide@vger.kernel.org>; Sun,  7 Oct 2007 22:56:27 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,

This seagate drive ST3500630AS is being recognized as NCQ capable by
hdparm, and has the default queue_depth of 31, so i think it should
work ok. But there are some problems when using smartmontools (for
example in short test mode) as seen in dmesg:

ata2.00: exception Emask 0x2 SAct 0x9 SErr 0x0 action 0x2 frozen
ata2.00: (spurious completions during NCQ issue=0x0 SAct=0x9 FIS=004040a1:00000004)
ata2.00: cmd 61/08:00:f4:28:4e/00:00:00:00:00/40 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:f4:28:4e/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata2.00: cmd 61/08:18:dc:c8:d7/00:00:00:00:00/40 tag 3 cdb 0x0 data 4096 out
         res 40/00:00:f4:28:4e/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

All this problems dissapear when setting queue_depth to 1.

After cheking the seagate website, there is no mention to NCQ in the
spec sheet of this drive, although there are models tagged as using
NCQ interface, for example ST3500620AS

630AS
http://www.seagate.com/ww/v/index.jsp?vgnextoid=b9df99f4fa74c010VgnVCM100000dd04090aRCRD&locale=en-US
620AS
http://www.seagate.com/ww/v/index.jsp?locale=en-US&name=barracuda-7200-11-sata-3-0-gb/s-500-gb-hard-drive-st3500620as&vgnextoid=c58ff141e7f43110VgnVCM100000f5ee0a0aRCRD&vgnextchannel=47f281f8c0f43110VgnVCM100000f5ee0a0aRCRD&reqPage=Model

So, should this drive be blacklisted as not being able to do NCQ
properly?

Thanks in advance.

Details of my setup follow:

# lspci |grep AHCI
0000:00:1f.2 0106: Intel Corporation 82801GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=AHCI (rev 01)
# uname -a
Linux anthalia 2.6.22.6 #1 SMP Sun Sep 16 16:48:12 UTC 2007 i686 GNU/Linux
# hdparm -V
hdparm v7.7
# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       ST3500630AS
        Serial Number:      5QG0QM7A
        Firmware Revision:  3.AAE
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  976773168
        device size with M = 1024*1024:      476940 MBytes
        device size with M = 1000*1000:      500107 MBytes (500 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Phy event counters
                Device-initiated interface power management
           *    Software settings preservation
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct



-- 
Saludos,
 diego                          mailto:dtorres@coral.dnsalias.org

