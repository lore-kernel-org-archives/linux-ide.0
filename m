From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Problems with Samsung SH-W163A SATA CD/DVDRW JMicron 20360/20363 2.6.18.1
Date: Wed, 8 Nov 2006 19:17:24 +0000
Message-ID: <f4527be0611081117x4f7610e1wc4aacbbfdcd6993a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161707AbWKHTR3@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 10/24/06, Bill Davidsen <davidsen@tmr.com> wrote:
>
> Andrew Lyon wrote:
> >> Hi,
> >>
> >> I have a Samsung SH-W163A SATA CD/DVDRW connected to jmicron
> >> 20360/20363 onboard sata controller, running kernel 2.6.18 with sr=
_mod
> >> loaded I can mount recorded/original disks and read them, but if I=
 try
> >> to burn a cd or dvd using cdrecord, and somtimes when mounting med=
ia I
> >> get loads of errors in dmesg and the burn fails:
>
> Not having any SATA CD burners, I can only go by my experience using =
USB
> and Firewire burners, which also appear to be SCSI. They work fine us=
ing
> the device name rather than playing with the ATA or ATAPI stuff. And =
if
> you're using ProDVD I suggest you download the latest cdrecord from t=
he
> usual site and build that, DVD support is now in the cdrecord source,=
 as
> it is in most distributions.
>
> I use multiple PATA and USB burners on several systems, and haven't h=
ad
> problems. I actually do have SCSI devices, they have always worked an=
d
> continue to (slowly) do so.
>
> If you post again after trying the current source, please include the
> command used as well as the output from the log. By using the latest =
you
> at least MIGHT get some help from the author, instead of the usual
> "don't bother me with obsolete versions" reply.


Ok, now updated to kernel 2.6.18.1 and newer cdrtools:

 ./cdrecord -sao /store/test.iso dev=3D/dev/dvdrw
Cdrecord-ProDVD-Clone 2.01.01a19 (i686-pc-linux-gnu) Copyright (C)
1995-2006 J=F6rg Schilling
=2E/cdrecord: Warning: Running on Linux-2.6.18-gentoo-r1
=2E/cdrecord: There are unsettled issues with Linux-2.5 and newer.
=2E/cdrecord: If you have unexpected problems, please try Linux-2.4 or =
Solaris.
scsidev: '/dev/dvdrw'
devname: '/dev/dvdrw'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   :
Vendor_info    : 'TSSTcorp'
Identifikation : 'CD/DVDW SH-W163A'
Revision       : 'TS01'
Device seems to be: Generic mmc2 DVD-R/DVD-RW/DVD-RAM.
Using generic SCSI-3/mmc-2 DVD-R/DVD-RW/DVD-RAM driver (mmc_dvd).
Driver flags   : DVD MMC-3 SWABAUDIO BURNFREE
Supported modes: PACKET SAO LAYER_JUMP
=2E/cdrecord: CD/DVD-Recorder not ready.


And the same messages in dmesg:

ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete

Andy




> >>
> >> ata2.00: speed down requested but no transfer mode left
> >> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> >> ata2.00: (irq_stat 0x48000000, interface fatal error)
> >> ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus err=
or)
> >> ata2: soft resetting port
> >> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> ata2.00: configured for PIO0
> >> ata2: EH complete
> >> ata2.00: speed down requested but no transfer mode left
> >> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> >> ata2.00: (irq_stat 0x48000000, interface fatal error)
> >> ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus err=
or)
> >> ata2: soft resetting port
> >> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> ata2.00: configured for PIO0
> >> ata2: EH complete
> >> ata2.00: speed down requested but no transfer mode left
> >> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> >> ata2.00: (irq_stat 0x48000000, interface fatal error)
> >>
> >>
> >> It looks like the interface is trying to run at 1.5Gbps which is
> >> obviously too fast for this drive, is there any way to set the
> >> interface speed ? I have a WD Raptor on the other sata port of the
> >> jmicron and that works perfectly (as long as NCQ is disabled - dri=
ve
> >> firmware bug).
> >>
> >> What is the status of sata cd/dvdrw support? It is getting hard to=
 buy
> >> machines with IDE writers, most of our workstations are dell and h=
ave
> >> only sata devices, we have similar problems with those.
> >>
> >> Andy
> >>
> >
> > I've done some more testing, I do not get the errors above when
> > reading a cd or dvd, only when I try to record using cdrecord (or
> > other apps) using ATAPI, here is some info from cdrecord:
> >
> > cdrecord dev=3DATAPI:0,0,0 -checkdrive
> > Cdrecord-ProDVD-Clone 2.01.01a10 (i686-pc-linux-gnu) Copyright (C)
> > 1995-2006 J=F6rg Schilling
> > scsidev: 'ATAPI:0,0,0'
> > devname: 'ATAPI'
> > scsibus: 0 target: 0 lun: 0
> > Warning: Using ATA Packet interface.
> > Warning: The related Linux kernel interface code seems to be unmain=
tained.
> > Warning: There is absolutely NO DMA, operations thus are slow.
> > Using libscg version 'schily-0.8'.
> > Device type    : Removable CD-ROM
> > Version        : 5
> > Response Format: 2
> > Capabilities   :
> > Vendor_info    : 'TSSTcorp'
> > Identifikation : 'CD/DVDW SH-W163A'
> > Revision       : 'TS01'
> > Device seems to be: Generic mmc2 DVD-R/DVD-RW.
> > Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
> > Driver flags   : DVD MMC-3 SWABAUDIO BURNFREE
> > Supported modes: PACKET SAO
> >
> >
> > Are these codes: Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen , fr=
om
> > the kernel? or from the sata chip? if they are from the chip does
> > anybody know where I might find datasheets for  JMicron 20360/20363
> > AHCI Controller (rev 02) ? perhaps I might find a clue there..
> >
> > Read speeds seem ok, 15MB/sec from a original dvd.
> >
> > andy
>
>
> --
> Bill Davidsen <davidsen@tmr.com>
>    Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run b=
y a
> normal user and is setuid root, with the "vi" line edit mode selected=
,
> and the character set is "big5," an off-by-one errors occurs during
> wildcard (glob) expansion.
>
