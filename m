From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 1 Mar 2006 13:32:17 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603011331200.2708@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca>
 <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca>
 <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750891AbWCAScX@vger.kernel.org>
In-Reply-To: <4405E83D.9000906@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Wed, 1 Mar 2006, Mark Lord wrote:

> David Greaves wrote:
>> 
>> haze:/usr/src# smartctl -data -o off /dev/sdc
>> succeeds but gives me:
>> 
>> ata3: status=0x50 { DriveReady SeekComplete }
>> ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>> ata3: status=0x51 { DriveReady SeekComplete Error }
>> ata3: error=0x04 { DriveStatusError }
>> ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>> ata3: status=0x51 { DriveReady SeekComplete Error }
>> ata3: error=0x04 { DriveStatusError }
>> ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>> ata3: status=0x51 { DriveReady SeekComplete Error }
>> ata3: error=0x04 { DriveStatusError }
>
> "DriveStatusError" is "Command Aborted" in ac-speak.
> From the man page for smartctl, we read:
>
>> -o VALUE  Enables or disables SMART automatic offline test ...
>> Note that the SMART automatic offline test command is listed as "Obsolete" 
> in every
>> version  of  the  ATA  and ATA/ATAPI Specifications.  It was originally part 
> of the
>> SFF-8035i Revision 2.0 specification, but was never part of any ATA 
> specification.
>
> There's a chance that your drives simply do not fully support this feature,
> and are rejecting attempts to use it.
>
> By the way, the latest 2.6.16-rc5-git4 is available,
> and has FUA turned off by default now.  So it should
> work with your drives, and *you* are expected to verify
> that for us all now.
>
> Cheers
>
> -ml
>

When running that command, I get it too:

[4294684.510000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 22 (level, 
low) -> I
RQ 17
[4294686.762000] process `syslogd' is using obsolete setsockopt 
SO_BSDCOMPAT
[4295292.736000] +++PATCH: Original kernel error:
[4295292.736000] ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI 
SK/ASC/AS
CQ 0xb/00/00
[4295292.736000] +++PATCH: Mark Lord's extended verbosity patch:
[4295292.736000] ata3: translated op=0x85 cmd=0xb0 ATA stat/err 0x51/04 to 
SCSI
SK/ASC/ASCQ 0xb/00/00
[4295292.736000] ata3: status=0x51 { DriveReady SeekComplete Error }
[4295292.736000] ata3: error=0x04 { DriveStatusError }
[4295292.736000] +++PATCH: Original kernel error:
[4295292.736000] ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI 
SK/ASC/AS
CQ 0xb/00/00
[4295292.736000] +++PATCH: Mark Lord's extended verbosity patch:
[4295292.736000] ata3: translated op=0x85 cmd=0xb0 ATA stat/err 0x51/04 to 
SCSI
SK/ASC/ASCQ 0xb/00/00
[4295292.736000] ata3: status=0x51 { DriveReady SeekComplete Error }
[4295292.736000] ata3: error=0x04 { DriveStatusError }
[4295292.736000] +++PATCH: Original kernel error:
[4295292.736000] ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI 
SK/ASC/AS
CQ 0xb/00/00
[4295292.736000] +++PATCH: Mark Lord's extended verbosity patch:
[4295292.736000] ata3: translated op=0x85 cmd=0xb0 ATA stat/err 0x51/04 to 
SCSI
SK/ASC/ASCQ 0xb/00/00
[4295292.736000] ata3: status=0x51 { DriveReady SeekComplete Error }
[4295292.736000] ata3: error=0x04 { DriveStatusError }
[4295292.736000] +++PATCH: Original kernel error:
[4295292.736000] ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI 
SK/ASC/AS
CQ 0xb/00/00
[4295292.736000] +++PATCH: Mark Lord's extended verbosity patch:
[4295292.736000] ata3: translated op=0x85 cmd=0xb0 ATA stat/err 0x51/04 to 
SCSI
SK/ASC/ASCQ 0xb/00/00
[4295292.736000] ata3: status=0x51 { DriveReady SeekComplete Error }
[4295292.736000] ata3: error=0x04 { DriveStatusError }
[4295292.736000] +++PATCH: Original kernel error:
[4295292.736000] ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI 
SK/ASC/AS
CQ 0xb/00/00
[4295292.736000] +++PATCH: Mark Lord's extended verbosity patch:
[4295292.736000] ata3: translated op=0x85 cmd=0xb0 ATA stat/err 0x51/04 to 
SCSI
SK/ASC/ASCQ 0xb/00/00
[4295292.736000] ata3: status=0x51 { DriveReady SeekComplete Error }
[4295292.736000] ata3: error=0x04 { DriveStatusError }
