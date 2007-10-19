From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: Spurious completions during NCQ
Date: Fri, 19 Oct 2007 16:46:08 -0700
Message-ID: <20071019164608.3e97dbe7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43811 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755455AbXJSXrA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 19:47:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Marco Lamberto <lm@sunnyspot.org>



Begin forwarded message:

Date: Sat, 13 Oct 2007 15:12:31 +0200 (CEST)
From: Marco Lamberto <lm@sunnyspot.org>
To: linux-kernel@vger.kernel.org
Subject: Spurious completions during NCQ


Hi, I think that my drives should be NCQ blacklisted too.
That's what I'm getting in my /var/log/messages:

-------------------------------------------------------------------------------
Oct 13 13:55:52 ko kernel: ata1.00: exception Emask 0x2 SAct 0x3f9 SErr 0x0 action 0x2 frozen
Oct 13 13:55:53 ko kernel: ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x3f9 FIS=004040a1:00000004)
Oct 13 13:55:53 ko kernel: ata1.00: cmd 61/08:00:d0:5e:8f/00:00:0f:00:00/40 tag 0 cdb 0x0 data 4096 out
Oct 13 13:55:53 ko kernel:          res 40/00:48:38:63:8f/00:00:0f:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:55:53 ko kernel: ata1.00: cmd 61/08:18:f8:7f:50/00:00:0d:00:00/40 tag 3 cdb 0x0 data 4096 out
Oct 13 13:55:53 ko kernel:          res 40/00:48:38:63:8f/00:00:0f:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:55:53 ko kernel: ata1.00: cmd 61/10:20:10:80:50/00:00:0d:00:00/40 tag 4 cdb 0x0 data 8192 out
Oct 13 13:55:53 ko kernel:          res 40/00:48:38:63:8f/00:00:0f:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:55:53 ko kernel: ata1.00: cmd 61/08:28:a0:4a:5c/00:00:0d:00:00/40 tag 5 cdb 0x0 data 4096 out
Oct 13 13:55:53 ko kernel:          res 40/00:48:38:63:8f/00:00:0f:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:55:53 ko kernel: ata1.00: cmd 61/08:30:b8:d7:5c/00:00:0d:00:00/40 tag 6 cdb 0x0 data 4096 out
Oct 13 13:55:53 ko kernel:          res 40/00:48:38:63:8f/00:00:0f:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:55:53 ko kernel: ata1.00: cmd 61/08:38:30:5e:8f/00:00:0f:00:00/40 tag 7 cdb 0x0 data 4096 out
Oct 13 13:55:53 ko kernel:          res 40/00:48:38:63:8f/00:00:0f:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:55:53 ko kernel: ata1.00: cmd 61/08:40:e8:61:8f/00:00:0f:00:00/40 tag 8 cdb 0x0 data 4096 out
Oct 13 13:55:53 ko kernel:          res 40/00:48:38:63:8f/00:00:0f:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:55:53 ko kernel: ata1.00: cmd 61/08:48:38:63:8f/00:00:0f:00:00/40 tag 9 cdb 0x0 data 4096 out
Oct 13 13:55:53 ko kernel:          res 40/00:48:38:63:8f/00:00:0f:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:55:53 ko kernel: ata1: soft resetting port
Oct 13 13:55:53 ko kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 13 13:55:53 ko kernel: ata1.00: configured for UDMA/133
Oct 13 13:55:53 ko kernel: ata1: EH complete
Oct 13 13:55:53 ko kernel: sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
Oct 13 13:55:53 ko kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 13 13:55:53 ko kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 13 13:57:56 ko kernel: ata2.00: exception Emask 0x2 SAct 0x1fff7 SErr 0x0 action 0x2 frozen
Oct 13 13:57:56 ko kernel: ata2.00: (spurious completions during NCQ issue=0x0 SAct=0x1fff7 FIS=004040a1:00040000)
Oct 13 13:57:56 ko kernel: ata2.00: cmd 61/08:00:40:1b:b3/00:00:08:00:00/40 tag 0 cdb 0x0 data 4096 out
Oct 13 13:57:56 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:56 ko kernel: ata2.00: cmd 61/08:08:e8:1d:27/00:00:0d:00:00/40 tag 1 cdb 0x0 data 4096 out
Oct 13 13:57:56 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:56 ko kernel: ata2.00: cmd 61/08:10:40:1c:4b/00:00:0d:00:00/40 tag 2 cdb 0x0 data 4096 out
Oct 13 13:57:56 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:56 ko kernel: ata2.00: cmd 61/08:20:60:1b:f7/00:00:06:00:00/40 tag 4 cdb 0x0 data 4096 out
Oct 13 13:57:56 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:56 ko kernel: ata2.00: cmd 61/08:28:80:1b:07/00:00:07:00:00/40 tag 5 cdb 0x0 data 4096 out
Oct 13 13:57:56 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:56 ko kernel: ata2.00: cmd 61/08:30:50:1b:2f/00:00:07:00:00/40 tag 6 cdb 0x0 data 4096 out
Oct 13 13:57:56 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:56 ko kernel: ata2.00: cmd 61/08:38:30:1b:3b/00:00:07:00:00/40 tag 7 cdb 0x0 data 4096 out
Oct 13 13:57:56 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2.00: cmd 61/08:40:38:1b:43/00:00:07:00:00/40 tag 8 cdb 0x0 data 4096 out
Oct 13 13:57:57 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2.00: cmd 61/08:48:58:1b:67/00:00:07:00:00/40 tag 9 cdb 0x0 data 4096 out
Oct 13 13:57:57 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2.00: cmd 61/08:50:38:1b:6b/00:00:07:00:00/40 tag 10 cdb 0x0 data 4096 out
Oct 13 13:57:57 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2.00: cmd 61/08:58:90:1b:97/00:00:07:00:00/40 tag 11 cdb 0x0 data 4096 out
Oct 13 13:57:57 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2.00: cmd 61/08:60:38:1b:53/00:00:0b:00:00/40 tag 12 cdb 0x0 data 4096 out
Oct 13 13:57:57 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2.00: cmd 61/08:68:60:1b:cb/00:00:0b:00:00/40 tag 13 cdb 0x0 data 4096 out
Oct 13 13:57:57 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2.00: cmd 61/08:70:30:1d:27/00:00:0d:00:00/40 tag 14 cdb 0x0 data 4096 out
Oct 13 13:57:57 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2.00: cmd 61/10:78:10:1d:4b/00:00:0d:00:00/40 tag 15 cdb 0x0 data 8192 out
Oct 13 13:57:57 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2.00: cmd 61/08:80:58:1d:4b/00:00:0d:00:00/40 tag 16 cdb 0x0 data 4096 out
Oct 13 13:57:57 ko kernel:          res 40/00:10:40:1c:4b/00:00:0d:00:00/40 Emask 0x2 (HSM violation)
Oct 13 13:57:57 ko kernel: ata2: soft resetting port
Oct 13 13:57:57 ko kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 13 13:57:57 ko kernel: ata2.00: configured for UDMA/133
Oct 13 13:57:57 ko kernel: ata2: EH complete
Oct 13 13:57:57 ko kernel: sd 1:0:0:0: [sdb] 490234752 512-byte hardware sectors (251000 MB)
Oct 13 13:57:57 ko kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 13 13:57:57 ko kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-------------------------------------------------------------------------------

Here follows the hdparm -I output.

-------------------------------------------------------------------------------

/dev/sda:

ATA device, with non-removable media
         Model Number:       Maxtor 6V250F0
         Serial Number:      V596ZL5G
         Firmware Revision:  VA111630
Standards:
         Used: ATA/ATAPI-7 T13 1532D revision 0
         Supported: 7 6 5 4 
Configuration:
         Logical         max     current
         cylinders       16383   16383
         heads           16      16
         sectors/track   63      63
         --
         CHS current addressable sectors:   16514064
         LBA    user addressable sectors:  268435455
         LBA48  user addressable sectors:  490234752
         device size with M = 1024*1024:      239372 MBytes
         device size with M = 1000*1000:      251000 MBytes (251 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         Queue depth: 32
         Standby timer values: spec'd by Standard, no device specific minimum
         R/W multiple sector transfer: Max = 16  Current = 16
         Advanced power management level: unknown setting (0x0000)
         Recommended acoustic management value: 192, current value: 254
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
            *    WRITE_VERIFY command
            *    WRITE_BUFFER command
            *    READ_BUFFER command
            *    NOP cmd
            *    DOWNLOAD_MICROCODE
                 Advanced Power Management feature set
                 SET_MAX security extension
            *    Automatic Acoustic Management feature set
            *    48-bit Address feature set
            *    Device Configuration Overlay feature set
            *    Mandatory FLUSH_CACHE
            *    FLUSH_CACHE_EXT
            *    SMART error logging
            *    SMART self-test
                 Media Card Pass-Through
            *    General Purpose Logging feature set
            *    WRITE_{DMA|MULTIPLE}_FUA_EXT
            *    64-bit World wide name
            *    URG for READ_STREAM[_DMA]_EXT
            *    URG for WRITE_STREAM[_DMA]_EXT
            *    SATA-I signaling speed (1.5Gb/s)
            *    SATA-II signaling speed (3.0Gb/s)
            *    Native Command Queueing (NCQ)
            *    Host-initiated interface power management
            *    Software settings preservation
            *    SMART Command Transport (SCT) feature set
            *    SCT Data Tables (AC5)
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
         not     frozen
         not     expired: security count
         not     supported: enhanced erase
Checksum: correct
-------------------------------------------------------------------------------

/dev/sdb:

ATA device, with non-removable media
 	Model Number:       Maxtor 6V250F0
 	Serial Number:      V596ZJ3G
 	Firmware Revision:  VA111630
Standards:
 	Used: ATA/ATAPI-7 T13 1532D revision 0
 	Supported: 7 6 5 4 
Configuration:
 	Logical		max	current
 	cylinders	16383	16383
 	heads		16	16
 	sectors/track	63	63
 	--
 	CHS current addressable sectors:   16514064
 	LBA    user addressable sectors:  268435455
 	LBA48  user addressable sectors:  490234752
 	device size with M = 1024*1024:      239372 MBytes
 	device size with M = 1000*1000:      251000 MBytes (251 GB)
Capabilities:
 	LBA, IORDY(can be disabled)
 	Queue depth: 32
 	Standby timer values: spec'd by Standard, no device specific minimum
 	R/W multiple sector transfer: Max = 16	Current = 16
 	Advanced power management level: unknown setting (0x0000)
 	Recommended acoustic management value: 192, current value: 254
 	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 	     Cycle time: min=120ns recommended=120ns
 	PIO: pio0 pio1 pio2 pio3 pio4
 	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
 	Enabled	Supported:
 	   *	SMART feature set
 	    	Security Mode feature set
 	   *	Power Management feature set
 	   *	Write cache
 	   *	Look-ahead
 	   *	Host Protected Area feature set
 	   *	WRITE_VERIFY command
 	   *	WRITE_BUFFER command
 	   *	READ_BUFFER command
 	   *	NOP cmd
 	   *	DOWNLOAD_MICROCODE
 	    	Advanced Power Management feature set
 	    	SET_MAX security extension
 	   *	Automatic Acoustic Management feature set
 	   *	48-bit Address feature set
 	   *	Device Configuration Overlay feature set
 	   *	Mandatory FLUSH_CACHE
 	   *	FLUSH_CACHE_EXT
 	   *	SMART error logging
 	   *	SMART self-test
 	    	Media Card Pass-Through
 	   *	General Purpose Logging feature set
 	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
 	   *	64-bit World wide name
 	   *	URG for READ_STREAM[_DMA]_EXT
 	   *	URG for WRITE_STREAM[_DMA]_EXT
 	   *	SATA-I signaling speed (1.5Gb/s)
 	   *	SATA-II signaling speed (3.0Gb/s)
 	   *	Native Command Queueing (NCQ)
 	   *	Host-initiated interface power management
 	   *	Software settings preservation
 	   *	SMART Command Transport (SCT) feature set
 	   *	SCT Data Tables (AC5)
Security:
 	Master password revision code = 65534
 		supported
 	not	enabled
 	not	locked
 	not	frozen
 	not	expired: security count
 	not	supported: enhanced erase
Checksum: correct
-------------------------------------------------------------------------------

Since I'm not subscribed to lkml, please cc any answer to my personal email
address.

Thanks,
Marco
-- 
//\/\ :: Marco Lamberto             < lm AT sunnyspot DOT org > ::
       :: http://the.sunnyspot.org/  :: http://www.siforge.org/  ::
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
