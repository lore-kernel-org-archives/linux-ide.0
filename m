From: "sam song" <sam_song@usish.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Fri, 30 Nov 2007 11:33:15 +0800
Message-ID: <006101c83301$bf79bef0$6539a8c0@usish.com.cn>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn> <474F64F5.9070205@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0062_01C83344.CD9CFEF0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usish.com ([210.5.144.203]:52270 "EHLO sr3.usish.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S934964AbXK3Ddn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 22:33:43 -0500
In-Reply-To: <474F64F5.9070205@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0062_01C83344.CD9CFEF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> sam song wrote:
> > Hi,
> >
> > I am convinced that the SATA Disk does support one vendor specific ATA
> > command and got the whole bus trace via Trainer.
> > However, I cannot implement that in the real cases with either HBA or
SATA
> > Controller like ICH5/7 via ATA Pass Thru.
> > So I wonder whether there is one possible setup including HW and SW
> > supporting the ATA command via ATA Pass directly and no need to
understand
> > the command meaning itself.
> >
> > Here is one result I got.
> >
> > [<unknown opcode>: 85 0b 06 00 01 00 00 00 00 00 00 00 00 e0 fd 00 ]
> >   scsi_status=0x2, host_status=0x0, driver_status=0x8
> >   info=0x1  duration=270111 milliseconds
> >   status=0x2: sense_key=0x7 asc=0x1 ascq=0x0
> 
> That sense key is data protect.  I don't think any code in ATA
> passthrough code path can raise that sense key.  What did you exactly
> do?  Can you post the source code?

I want to zero the whole disk as a certain pattern like 0 or else with
vendor specific WRITE command 0xFD on 1TB SATA Disk in my test. This command
0xFD can support issuing a 1 to 65 block zero pattern to the disk and should
be done about 4-hour on 1TB Disk rather than about 11-hour on 1TB Disk with
SCSI WRITE(10). 

Attached pls see the details debug log on SUSE Linux Enterprise 10 I just
did. As for code, I will send to you in private for it is kind of poor and
confidential. Really sorry for that.

Thanks so much for your input. I think my concern is a specific request but
it's reasonable in real world of SATA domain.

Sam Song

------=_NextPart_000_0062_01C83344.CD9CFEF0
Content-Type: text/plain;
	name="writefd_suse.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="writefd_suse.txt"

# Details WRITE FD debug info on SUSE Enterprise Linux Server 10.
# USI-SS
# Nov. 30, 2007

IT-0010737:/home/sam/upstream # vi makefile
IT-0010737:/home/sam/upstream # uname -a
Linux IT-0010737 2.6.16.21-0.8-smp #1 SMP Mon Jul 3 18:25:39 UTC 2006 =
i686 i686 i386 GNU/Linux
IT-0010737:/home/sam/upstream # cat /proc/partitions
major minor  #blocks  name

   8     0   78150744 sda
   8     1   20482843 sda1
   8     2   20482875 sda2
   8     3          1 sda3
   8     5   18024898 sda5
   8     6    1052226 sda6
   8     7   18105223 sda7
   8    16  976762584 sdb
IT-0010737:/home/sam/upstream #

IT-0010737:/home/sam/smart/reference/image-smart # ./smartctl -i =
/dev/sdb
smartctl version 5.37 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce =
Allen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     HUA721010KLA330
Serial Number:    PAGK65ZE
Firmware Version: GKAOA94A
User Capacity:    1,000,204,886,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 1
Local Time is:    Fri Nov 30 10:28:28 2007 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

IT-0010737:/home/smart/reference/image-smart #

IT-0010737:/home/sam/upstream # lspci
00:00.0 Host bridge: Intel Corporation 945G/GZ/P/PL Express Memory =
Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation 945G/GZ/P/PL Express PCI Express =
Root Port (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 945G/GZ Express =
Integrated Graphics Controller (rev 02)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High =
Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express =
Port 1 (rev 01)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express =
Port 3 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI =
#1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI =
#2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI =
#3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI =
#4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI =
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC =
Interface Bridge (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) =
Serial ATA Storage Controller IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller =
(rev 01)
01:00.0 PCI bridge: Intel Corporation 80333 Segment-A PCI Express-to-PCI =
Express Bridge
01:00.2 PCI bridge: Intel Corporation 80333 Segment-B PCI Express-to-PCI =
Express Bridge
02:0e.0 RAID bus controller: Adaptec AAC-RAID
05:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5789 =
Gigabit Ethernet PCI Express (rev 11)
06:07.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link =
Layer Controller (rev 01)
IT-0010737:/home/sam/upstream #

IT-0010737:/home/sam/upstream # ./WriteFD /dev/sdb
[USI] : parameter input is /dev/sdb
[USI] : Now prepare for zeroing SATA Drive /dev/sdb ...
[USI] WriteFD : version is 0.4 20071121
[USI] WriteFD : Now prepare Zero Pattern Block ...
 00     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 10     ed 5e ff 7f 00 00 00 00  00 00 00 00 00 00 00 00    =
.^..............
 20     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 30     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 40     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 50     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 60     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 70     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 80     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 90     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 a0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 b0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 c0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 d0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 e0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
 f0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00    =
................
[USI]: ata pass through(16) cdb: 85 0b 06 00 41 00 00 00 00 00 00 00 00 =
e0 fd 00
 [<unknown opcode>: 85 0b 06 00 41 00 00 00 00 00 00 00 00 e0 fd 00 ]
  scsi_status=3D0x2, host_status=3D0x0, driver_status=3D0x8
  info=3D0x1  duration=3D31056 milliseconds
  status=3D0x2: sense_key=3D0x7 asc=3D0x1 ascq=3D0x0
[USI] : Time to Perform Zero Disk on /dev/sdb was 0m31secs
[USI] : SATA Drive Zero Action Successfully!
IT-0010737:/home/sam/upstream #

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DKernel =
Oops=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ata2: PIO error
ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata2: status=3D0xd0 { Busy }

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Then the disk access was abnormal and slow response to any command.

------=_NextPart_000_0062_01C83344.CD9CFEF0--

