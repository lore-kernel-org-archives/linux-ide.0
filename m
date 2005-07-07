From: Tejun Heo <htejun@gmail.com>
Subject: Re: how it's broken....
Date: Thu, 7 Jul 2005 22:30:59 +0900
Message-ID: <20050707133058.GA16044@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org> <20050707130840.63AB5EBF@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:62124 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261465AbVGGNbF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:31:05 -0400
Received: by wproxy.gmail.com with SMTP id 55so209288wri
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:31:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050707130840.63AB5EBF@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Thu, Jul 07, 2005 at 10:10:04PM +0900, Tejun Heo wrote:
> 10_libata_ahci-atapi.patch
> 
> 	This patch adds ATAPI support to ahci driver.  This currently
> 	doesn't work.  I'll write a reply to this thread to tell more
> 	about this.  However, it at least shows that NCQ ATAPI error
> 	handling works.
> 

 Hello again, guys.

 Well, I just added memcpy'ing cdb to ACMD area with this patch and
thought it should work, but it didn't.  Well, it kind of worked but
not really.

 With this patch applied, inquiry succeeds and the device is
identified and attached with no problem.  Things start to go weird
with the first TURs (test unit ready) during initialization.

 When attached to sil, with the same drive and cd inside it, the first
TUR succeeds and initialization just goes on.  But when attached to
ahci, it fails all five attempts of TURs with NOT READY, IN PROCESS OF
BECOMING READY (asc 0x04, ascq 0x01).  This is maybe due to how BIOS
initializes ATAPI devices during POST.  After five attempts, sr seems
to give up and just attaches the drive.

 After boot process is completed, when a read command is issued to
the drive, the drive works fine on sil, but on ahci, the following
things happen.

 * First TUR is failed with MEDIUM CHANGE (asc 0x28 ascq 0x00), which
   seems reasonable.
 * Second TUR succeeds.
 * sr for some reason sends another TUR.  This TUR gets stuck and
   times out.
 * Recovery kicks in and resets the device.
 * sr gives up, unlocks the drive, which the drive fails with RESET
   occurred.
 * read fails.

 The thing is that after a TUR succeeds, the drive completely locks
up.  If I skip the second TUR, whtatever commands come next gets
stuck.  If I don't reset after timeout, all following commands are
timed out.

 When the same controller is put in legacy mode such that it's
attached to ata_piix.  The drive works fine just as with sil
controller.  Any ideas?

 Log follows.  Log is generated with #11 debug patch applied.  The
first part is with sil and the second with ahci.

======================================================================
== On sil
======================================================================

sil initialization starts
-----------------------------------------
SIL6: tf 00000000: H f=00 n=00 l=00 m=00 h=00 L f=00 n=00 l=00 m=00 h=00 C=a1
ata6: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:001f
ata6: dev 0 ATAPI, max UDMA/66
SIL6: tf 00000000: H f=00 n=00 l=00 m=00 h=00 L f=03 n=44 l=00 m=00 h=00 C=ef
ata6: dev 0 configured for UDMA/66
scsi6 : sata_sil
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: WU10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SIL6: tf df512680: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 12 00 00 00 24 00 00 00  5d ac 27 c0 00 00 00 00
SIL6: tf df512680: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 12 00 00 00 60 00 00 00  5d ac 27 c0 00 00 00 00
  Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 05
SIL6: tf df512680: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: a0 00 00 00 00 00 00 00  10 00 00 00 00 00 00 00
ata6: requesting check condition for failed scmd df512680 tag 0
ata6: recovering from error
SIL6: tf 00000000: H f=00 n=00 l=00 m=00 h=00 L f=00 n=00 l=00 m=00 h=20 C=a0
SIL6: PACKET: 03 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
SENSE: 70 00 05 00 00 00 00 0a  00 00 00 00 20 00 00 00
ata6: recovery complete

Other devices get initialized....
-----------------------------------------

SIL6: tf df512680: H f=00 n=00 l=00 m=00 h=00 L f=00 n=00 l=00 m=00 h=20 C=a0
SIL6: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
SIL6: tf df512680: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 5a 00 2a 00 00 00 00 00  80 00 00 00 00 00 00 00
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi6, channel 0, id 0, lun 0

Init complete, head /dev/sr0 | hexdump -C
-----------------------------------------

SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=00 n=00 l=00 m=00 h=20 C=a0
SIL6: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=00 n=00 l=00 m=00 h=20 C=a0
SIL6: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 43 00 00 00 00 00 00 00  0c 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 43 02 00 00 00 00 01 00  0c 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 25 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=00 n=00 l=00 m=00 h=20 C=a0
SIL6: PACKET: 1e 00 00 00 01 00 7a dd  4c 80 37 c0 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 46 00 00 00 00 00 00 00  20 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=00 n=00 l=00 m=00 h=20 C=a0
SIL6: PACKET: 00 00 00 00 00 00 7a dd  50 1e 7a dd 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 43 00 00 00 00 00 00 00  0c 40 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 43 00 00 00 00 00 00 00  0c 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 43 00 00 00 00 00 01 00  0c 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 28 00 00 00 00 00 00 00  10 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 28 00 00 00 00 10 00 00  32 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=01 n=00 l=00 m=00 h=00 C=a0
SIL6: PACKET: 28 00 00 00 00 42 00 00  2e 00 00 00 00 00 00 00
SIL6: tf df512980: H f=00 n=00 l=00 m=00 h=00 L f=00 n=00 l=00 m=00 h=20 C=a0
SIL6: PACKET: 1e 00 00 00 00 00 3a c1  60 07 3a c1 00 00 00 00

(SUCCEEDED)

======================================================================
== On AHCI							    ==
======================================================================

AHCI initialization starts
-----------------------------------------

AHCI3: FIS(tag00) 00000000: 00a18027 a0000000 00000000 08000000 00000000
ata3: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:001f
ata3: dev 0 ATAPI, max UDMA/66
AHCI3: FIS(tag00) 00000000: 03ef8027 a0000000 00000000 08000044 00000000
ata3: dev 0 configured for UDMA/66
scsi3 : ahci
ata4: no device found (phy stat 00000000)
scsi4 : ahci
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: WU10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata1: NCQ enabled, depth 30
AHCI3: FIS(tag00) df512080: 01a08027 a0000000 00000000 08000000 00000000
AHCI3: PACKET: 12 00 00 00 24 00 00 00  5d ac 27 c0 00 00 00 00
AHCI3: FIS(tag00) df512080: 01a08027 a0000000 00000000 08000000 00000000
AHCI3: PACKET: 12 00 00 00 60 00 00 00  5d ac 27 c0 00 00 00 00
  Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 05
AHCI3: FIS(tag00) df512080: 01a08027 a0000000 00000000 08000000 00000000
AHCI3: PACKET: a0 00 00 00 00 00 00 00  10 00 00 00 00 00 00 00
ata3: aborting commands due to error.  active_tag 0, sactive 00000000
ata3: requesting check condition for scmd df512080 tag 0
ata3: recovering from error
AHCI3: FIS(tag01) 00000000: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 03 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
SENSE: 70 00 05 00 00 00 00 0a  00 00 00 00 20 00 00 00
ata3: recovery complete

Other devices get initialized....
-----------------------------------------

AHCI3: FIS(tag00) df512380: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
ata3: aborting commands due to error.  active_tag 0, sactive 00000000
ata3: requesting check condition for scmd df512380 tag 0
ata3: recovering from error
AHCI3: FIS(tag01) 00000000: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 03 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
SENSE: 70 00 02 00 00 00 00 0a  00 00 00 00 04 01 00 00
ata3: recovery complete
AHCI3: FIS(tag00) df512380: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
ata3: aborting commands due to error.  active_tag 0, sactive 00000000
ata3: requesting check condition for scmd df512380 tag 0
ata3: recovering from error
AHCI3: FIS(tag01) 00000000: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 03 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
SENSE: 70 00 02 00 00 00 00 0a  00 00 00 00 04 01 00 00
ata3: recovery complete
AHCI3: FIS(tag00) df512380: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
ata3: aborting commands due to error.  active_tag 0, sactive 00000000
ata3: requesting check condition for scmd df512380 tag 0
ata3: recovering from error
AHCI3: FIS(tag01) 00000000: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 03 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
SENSE: 70 00 02 00 00 00 00 0a  00 00 00 00 04 01 00 00
ata3: recovery complete
AHCI3: FIS(tag00) df512380: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
ata3: aborting commands due to error.  active_tag 0, sactive 00000000
ata3: requesting check condition for scmd df512380 tag 0
ata3: recovering from error
AHCI3: FIS(tag01) 00000000: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 03 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
SENSE: 70 00 02 00 00 00 00 0a  00 00 00 00 04 01 00 00
ata3: recovery complete
AHCI3: FIS(tag00) df512380: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
ata3: aborting commands due to error.  active_tag 0, sactive 00000000
ata3: requesting check condition for scmd df512380 tag 0
ata3: recovering from error
AHCI3: FIS(tag01) 00000000: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 03 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
SENSE: 70 00 02 00 00 00 00 0a  00 00 00 00 04 01 00 00
ata3: recovery complete
AHCI3: FIS(tag00) df512380: 01a08027 a0000000 00000000 08000000 00000000
AHCI3: PACKET: 5a 00 2a 00 00 00 00 00  80 00 00 00 00 00 00 00
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi3, channel 0, id 0, lun 0

Init complete, head /dev/sr0 | hexdump -C
-----------------------------------------

AHCI3: FIS(tag00) df512680: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
ata3: aborting commands due to error.  active_tag 0, sactive 00000000
ata3: requesting check condition for scmd df512680 tag 0
ata3: recovering from error
AHCI3: FIS(tag01) 00000000: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 03 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
SENSE: 70 00 06 00 00 00 00 0a  00 00 00 00 28 00 00 00
ata3: recovery complete
AHCI3: FIS(tag00) df512680: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
AHCI3: FIS(tag00) df512680: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
ata3: recovering from timeout
ata3: stat=50, issuing COMRESET
ata3: ignoring command completion for tag 0 during recovery
ata3: ignoring command completion for tag 0 during recovery
ata3: ignoring command completion for tag 0 during recovery
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: called with no error (51)!
ata3: recovery complete
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current: sense key: Medium Error
    Additional sense: Write error - auto reallocation failed
cdrom: open failed.
AHCI3: FIS(tag00) df512680: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 1e 00 00 00 00 00 63 dd  38 df 11 c0 00 00 00 00
ata3: aborting commands due to error.  active_tag 0, sactive 00000000
ata3: requesting check condition for scmd df512680 tag 0
ata3: recovering from error
AHCI3: FIS(tag01) 00000000: 00a08027 a0200000 00000000 08000000 00000000
AHCI3: PACKET: 03 00 00 00 60 00 00 00  00 00 00 00 00 00 00 00
SENSE: 70 00 06 00 00 00 00 0a  00 00 00 00 29 00 00 00
ata3: recovery complete

(FAILED W/ NO MEDIUM ERROR)
