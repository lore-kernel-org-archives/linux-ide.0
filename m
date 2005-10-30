From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Re: Serious IDE problem still present in 2.6.14
Date: Sun, 30 Oct 2005 10:52:44 -0500
Message-ID: <1130687564.6290.7.camel@montroll.chem.mcgill.ca>
References: <1130633310.6225.11.camel@montroll.chem.mcgill.ca>
	 <43642CA4.5010109@yahoo.de>
	 <1130642030.6225.15.camel@montroll.chem.mcgill.ca>
	 <436489FA.5080907@yahoo.de>
Reply-To: David.Ronis@mcgill.ca
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from torrent.cc.mcgill.ca ([132.206.27.49]:36553 "EHLO
	torrent.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S932103AbVJ3PxL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Oct 2005 10:53:11 -0500
In-Reply-To: <436489FA.5080907@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan <gentoopower@yahoo.de>
Cc: David.Ronis@mcgill.ca, linux-ide@vger.kernel.org

Hi Stefan,

Here's the information you wanted (as well as output from several other
hdparm reports/tests).  Note that I run

/sbin/hdparm -qS240 -qc1 -qm16 /dev/hda

from rc.local.  The m16 isn't needed on 2.6.12.6 (it's set anyhow) but
is on 2.6.14.  There's a lot of output.  I diff'ed the two sets and
basically there're identical except for:

bash-3.00# diff hdparmreport.2.6.12.6 hdparmreport.2.6.14
27c27
<  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  ATA/ATAPI-1
ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6
---
>  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2: 
159c159
<  Timing buffered disk reads:  102 MB in  3.05 seconds =  33.48 MB/sec
---
>  Timing buffered disk reads:   66 MB in  3.05 seconds =  21.63 MB/sec
164c164
<  Timing cached reads:   1296 MB in  2.00 seconds = 648.10 MB/sec
---
>  Timing cached reads:    28 MB in  2.08 seconds =  13.46 MB/sec

David

OK, here's the full information:

First on 2.6.12.6:
hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 195371568, start = 0

hdparm -i /dev/hda

/dev/hda:

 Model=ST9100823A, FwRev=3.00, SerialNo=3LG0V6AP
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=195371568
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  ATA/ATAPI-1
ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6

 * signifies the current active mode


hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
	Model Number:       ST9100823A                              
	Serial Number:      3LG0V6AP
	Firmware Revision:  3.00    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  195371568
	device size with M = 1024*1024:       95396 MBytes
	device size with M = 1000*1000:      100030 MBytes (100 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: unknown setting (0x8080)
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
		SET MAX security extension
	   *	Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0
Checksum: correct

hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
	Model Number:       ST9100823A                              
	Serial Number:      3LG0V6AP
	Firmware Revision:  3.00    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  195371568
	device size with M = 1024*1024:       95396 MBytes
	device size with M = 1000*1000:      100030 MBytes (100 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: unknown setting (0x8080)
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
		SET MAX security extension
	   *	Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0
Checksum: correct

hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  102 MB in  3.05 seconds =  33.48 MB/sec

hdparm -T /dev/hda

/dev/hda:
 Timing cached reads:   1296 MB in  2.00 seconds = 648.10 MB/sec

Now on 2.6.14:
hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 195371568, start = 0

hdparm -i /dev/hda

/dev/hda:

 Model=ST9100823A, FwRev=3.00, SerialNo=3LG0V6AP
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=195371568
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2: 

 * signifies the current active mode


hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
	Model Number:       ST9100823A                              
	Serial Number:      3LG0V6AP
	Firmware Revision:  3.00    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  195371568
	device size with M = 1024*1024:       95396 MBytes
	device size with M = 1000*1000:      100030 MBytes (100 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: unknown setting (0x8080)
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
		SET MAX security extension
	   *	Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0
Checksum: correct

hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
	Model Number:       ST9100823A                              
	Serial Number:      3LG0V6AP
	Firmware Revision:  3.00    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  195371568
	device size with M = 1024*1024:       95396 MBytes
	device size with M = 1000*1000:      100030 MBytes (100 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: unknown setting (0x8080)
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
		SET MAX security extension
	   *	Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0
Checksum: correct

hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:   66 MB in  3.05 seconds =  21.63 MB/sec

hdparm -T /dev/hda

/dev/hda:
 Timing cached reads:    28 MB in  2.08 seconds =  13.46 MB/sec





On Sun, 2005-10-30 at 09:53 +0100, Stefan wrote:
> David Ronis wrote:
> 
> >Look at the link, all the information (output from hdparm) is there (and
> >yes, usingdma is on).
> >  
> >
> Yes I did look at the link, but I only see output from:
> 
> hdparm -i /dev/hda
> 
> not
> 
> hdparm /dev/hda
> 
> 
> >David
> >
> >On Sun, 2005-10-30 at 03:15 +0100, Stefan wrote:
> >  
> >
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=112802950411697&w=2
> >>    
> >>
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >  
> >
> 
> 
> 	
> 
> 	
> 		
> ___________________________________________________________ 
> Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
> 

