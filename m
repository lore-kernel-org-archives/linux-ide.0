From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9921] New: Problem burning DVDs with Marvell 88SE6121 on pata_marvell
Date: Fri,  8 Feb 2008 23:12:00 -0800 (PST)
Message-ID: <bug-9921-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50635 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640AbYBIHNd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 02:13:33 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m197CA7x001041
	for <linux-ide@vger.kernel.org>; Fri, 8 Feb 2008 23:12:11 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9921

           Summary: Problem burning DVDs with Marvell 88SE6121 on
                    pata_marvell
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: kernel+bugs@gozer.org


Latest working kernel version:
Earliest failing kernel version: 2.6.23
Distribution: Debian (unstable)
Hardware Environment: Intel Core 2 Duo, MSI P35 Platinum
Software Environment:
Problem Description:

(copy and paste from my lkml message)

I recently put together a new system with a MSI P35 PLATINUM and although
reading from data CDs, DVDs, and watching DVD movies is working fine, DVD
burning isn't. MSI's manual says "1 IDE port by Marvell 88SE6111", but
lspci says it's a 88SE6121. I have two DVD burners, a SONY DRU-510A and
a DRU-820A. They were both working fine with TDK DVD+R media on my ASUS
K8V SE DELUXE (VIA IDE controller) prior to the upgrade.

Here's what I see with dvd+rw-tools version 7.0-9:

sh# dvd+rw-mediainfo /dev/dvd > /dev/null          # this is blank media
:-[ GET CURRENT PERFORMACE failed with SK=5h/ASC=24h/ACQ=00h]: Input/output
error
:-[ READ TOC failed with SK=5h/ASC=24h/ACQ=00h]: Input/output error

sh# growisofs -dvd-compat -speed=2.4 -Z /dev/dvd -rJ -joliet-long -quiet "burn"
Executing 'genisoimage -rJ -joliet-long -quiet burn | builtin_dd of=/dev/dvd
obs=32k seek=0'
/dev/dvd: "Current Write Speed" is 2.5x1352KBps.
:-[ WRITE@LBA=70h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output error
:-( write failed: Input/output error
/dev/dvd: flushing cache
/dev/dvd: closing track
:-[ CLOSE TRACK failed with SK=5h/ASC=30h/ACQ=05h]: Wrong medium type
/dev/dvd: closing disc
:-[ CLOSE DISC failed with SK=5h/ASC=30h/ACQ=05h]: Wrong medium type

sh# dvd+rw-mediainfo /dev/dvd > /dev/null
:-[ READ TRACK INFORMATION failed with SK=3h/ASC=11h/ACQ=05h]: Input/output
error

And from cdrecord version 1.1.6-1:

sh# mkisofs -rJ -joliet-long -quiet "burn" | cdrecord -v dev=/dev/dvd -
wodim: No write mode specified.
wodim: Asuming -tao mode.
wodim: Future versions of wodim may have different drive dependent defaults.
TOC Type: 1 = CD-ROM
scsidev: '/dev/dvd'
devname: '/dev/dvd'
scsibus: -2 target: -2 lun: -2
Linux sg driver version: 3.5.27
Wodim version: 1.1.6
SCSI buffer size: 64512
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   :
Vendor_info    : 'SONY    '
Identification : 'DVD RW DRU-820A '
Revision       : '1.0c'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Current: 0x0009 (CD-R)
Profile: 0x002B (DVD+R/DL)
Profile: 0x001B (DVD+R)
Profile: 0x001A (DVD+RW)
Profile: 0x0016 (DVD-R/DL layer jump recording)
Profile: 0x0015 (DVD-R/DL sequential recording)
Profile: 0x0014 (DVD-RW sequential recording)
Profile: 0x0013 (DVD-RW restricted overwrite)
Profile: 0x0012 (DVD-RAM)
Profile: 0x0011 (DVD-R sequential recording)
Profile: 0x0010 (DVD-ROM)
Profile: 0x000A (CD-RW)
Profile: 0x0009 (CD-R) (current)
Profile: 0x0008 (CD-ROM)
Profile: 0x0002 (Removable disk)
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Drive buf size : 1114112 = 1088 KB
Beginning DMA speed test. Set CDR_NODMATEST environment variable if device
communication breaks or freezes immediately after that.
FIFO size      : 12582912 = 12288 KB
Track 01: data  unknown length
Total size:        0 MB (00:00.00) = 0 sectors
Lout start:        0 MB (00:02/00) = 0 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 4
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type A, high Beta category (A+) (3)
  ATIP start of lead in:  -11849 (97:24/01)
  ATIP start of lead out: 359847 (79:59/72)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 25
Manufacturer: Taiyo Yuden Company Limited
wodim: WARNING: Total disk size unknown. Data may not fit on disk.
Speed set to 7056 KB/s
Starting to write CD/DVD at speed  40.0 in real TAO mode for single session.
Last chance to quit, starting real write i   0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
Performing OPC...
Starting new track at sector: 0
Track 01:    1 MB written (fifo 100%) [buf  97%]   5.4x.Errno: 5 (Input/output
error), write_g1 scsi sendcmd: no error
CDB:  2A 00 00 00 03 64 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 04 00 00 00 00 0A CF DC 00 00 08 03 00 00
Sense Key: 0x4 Hardware Error, Segment 0
Sense Code: 0x08 Qual 0x03 (logical unit communication crc error
(ultra-dma/32)) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 30.186s timeout 40s

write track data: error after 1777664 bytes
wodim: A write error occured.
wodim: Please properly read the error message above.
Writing  time:   46.572s
Fixating...
Errno: 5 (Input/output error), close track/session scsi sendcmd: no error
CDB:  5B 00 02 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 72 04 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x72 Qual 0x04 (empty or partially written reserved track) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.000s timeout 480s
cmd finished after 0.000s timeout 480s
wodim: Cannot fixate disk.
Fixating time:    0.001s
wodim: fifo had 220 puts and 29 gets.
wodim: fifo was 0 times empty and 19 times full, min fill was 97%.

There's nothing in dmesg after any of these events.

sh# cat /proc/version
Linux version 2.6.24 (root@jam) (gcc version 4.2.3 20080114 (prerelease)
(Debian 4.2.2-7)) #14 SMP Sat Feb 2 14:20:01 CST 2008

# (bits from my vanilla 2.6.24 .config)
# CONFIG_IDE is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_WAIT_SCAN=m
CONFIG_ATA=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_AHCI=y
CONFIG_ATA_PIIX=y
CONFIG_PATA_MARVELL=y

# (from dmesg)
scsi6 : pata_marvell
scsi7 : pata_marvell
ata7: PATA max UDMA/100 cmd 0xcc00 ctl 0xc880 bmdma 0xc400 irq 16
ata8: PATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 0xc408 irq 16
BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 08:00 09:00 0A:00 0B:00
0C:07 0D:00 0E:00 0F:00
ata7.00: ATAPI: SONY    DVD RW DRU-510A, 1.1a, max UDMA/33
ata7.01: ATAPI: DVD RW DRU-820A, 1.0c, max UDMA/66
ata7.01: limited to UDMA/33 due to 40-wire cable
ata7.00: configured for UDMA/33
ata7.01: configured for UDMA/33
BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 08:00 09:00 0A:00 0B:00
0C:07 0D:00 0E:00 0F:00
scsi 6:0:0:0: CD-ROM            SONY     DVD RW DRU-510A  1.1a PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 6:0:0:0: Attached scsi CD-ROM sr0
sr 6:0:0:0: Attached scsi generic sg2 type 5
scsi 6:0:1:0: CD-ROM            SONY     DVD RW DRU-820A  1.0c PQ: 0 ANSI: 5
sr1: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
sr 6:0:1:0: Attached scsi CD-ROM sr1
sr 6:0:1:0: Attached scsi generic sg3 type 5

# (from lspci -vvv)
03:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6121 SATA II
Controller (rev b1) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Marvell Technology Group Ltd. 88SE6121 SATA II Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at cc00 [size=8]
        Region 1: I/O ports at c880 [size=4]
        Region 2: I/O ports at c800 [size=8]
        Region 3: I/O ports at c480 [size=4]
        Region 4: I/O ports at c400 [size=16]
        Region 5: Memory at fe9ffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit- Queue=0/0
Enable-
                Address: 00000000  Data: 0000
        Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0
<256ns, L1 unlimited
                        ClockPM- Suprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        Kernel driver in use: pata_marvell

>Trying older kernels might be interesting, find out if it's a regression or
>if it was always this way.

2.6.13.14 shows the same problems and 2.6.22 doesn't see the controller.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
