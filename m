From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 00/09] NCQ: generic NCQ completion/error-handling
Date: Fri, 8 Jul 2005 19:27:28 +0900
Message-ID: <20050708102728.GA5426@htj.dyndns.org>
References: <20050627143344.GI11633@suse.de> <20050630073633.GF2243@suse.de> <42C3CEA5.9040509@gmail.com> <20050630152620.GZ2243@suse.de> <20050701002035.GA24878@htj.dyndns.org> <20050701085912.GB2243@suse.de> <20050704055332.GA7249@suse.de> <20050706125500.GA1373@suse.de> <20050706130004.GB1373@suse.de> <20050708080347.GA7050@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:17590 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262480AbVGHK1h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2005 06:27:37 -0400
Received: by wproxy.gmail.com with SMTP id 69so399835wra
        for <linux-ide@vger.kernel.org>; Fri, 08 Jul 2005 03:27:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050708080347.GA7050@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, Jul 08, 2005 at 10:03:48AM +0200, Jens Axboe wrote:
> Hi,
> 
> Ok, one more error, this time from irq context:
> 
> AHCI: ata1: error irq, status=40000001 stat=51 err=04 sstat=00000113
> serr=00000000
> ata1: aborting commands due to error.  active_tag -1, sactive 00000001
> ahci: sactive 1
> ata1: recovering from error
> sactive=0
> ata1: failed to read log page 10h (-110)
> ata1: resetting...
> ata1: started resetting...
> ata1: end resetting, sstatus=00000113
> ata1: status=0x01 { Error }
> ata1: error=0x80 { Sector }
> SCSI error : <0 0 0 0> return code = 0x8000002
> sda: Current: sense key=0x3
>     ASC=0x11 ASCQ=0x4
> end_request: I/O error, dev sda, sector 2120875
> Buffer I/O error on device sda2, logical block 2045
> lost page write due to I/O error on sda2
> 
> -- 
> Jens Axboe

 Hi, Jens.

 I also have a weird lockup log.  This log is generated with the
second take of NCQ patchset I've posted yesterday.  It's Samsung
HD160JJ on ICH7R AHCI.  Every command with tag#3 is scrambled, so
recovery operations are performed constantly (log 10h, if that fails
COMRESET).  After a few hours, the drive failed to become online after
COMRESET.  Rebooting didn't work.  BIOS couldn't detect/recover it.  I
had to power-cycle to make it online again.  I'm running similar test
with much lower error-late (5~6 errors per 3000 requests) to avoid too
many COMRESET's and, for more than six hours, it's been running okay.
Error log follows.

 Jens, can you run your test with the new patchset?


Jul  9 01:55:33 jtj kernel: AHCI2: FIS(tag00) dec65b00: 20608027 40492a16 0000000d 08000000 00000000
Jul  9 01:55:33 jtj kernel: AHCI2: FIS(tag01) de412380: 20608027 4033c992 00000006 08000008 00000000
Jul  9 01:55:33 jtj kernel: AHCI2: FIS(tag02) dec59680: 20608027 40f62998 00000007 08000010 00000000
Jul  9 01:55:33 jtj kernel: AHCI2: FAILING 03 dec65980: 28608027 408fe875 0000000c 08000018 00000000
Jul  9 01:55:33 jtj kernel: AHCI2: FIS(tag03) dec65980: 28608027 40ffffff 00ffffff 08000018 00000000
Jul  9 01:55:33 jtj kernel: AHCI2: FIS(tag00) df512800: 28608027 40af6dbe 0000000b 08000000 00000000
Jul  9 01:55:33 jtj kernel: AHCI2: FIS(tag04) dec59c80: 28608027 4054fb45 0000000b 08000020 00000000
Jul  9 01:55:33 jtj kernel: AHCI2: FIS(tag01) dec59e00: 28608027 404e6f5b 0000000a 08000008 00000000
Jul  9 01:55:33 jtj kernel: ata2: aborting commands due to error.  active_tag -1, sactive 0000001f
Jul  9 01:55:33 jtj kernel: ata2: requesting check condition for failed scmd df512800 tag 0
Jul  9 01:55:33 jtj kernel: ata2: requesting check condition for failed scmd dec59e00 tag 1
Jul  9 01:55:33 jtj kernel: ata2: requesting check condition for failed scmd dec65980 tag 3
Jul  9 01:55:33 jtj kernel: ata2: requesting check condition for failed scmd dec59c80 tag 4
Jul  9 01:55:33 jtj kernel: ata2: recovering from error
Jul  9 01:55:33 jtj kernel: ata2: aborting commands due to error.  active_tag -1, sactive 0000001b
Jul  9 01:55:33 jtj kernel: ata2: ignoring command completion for tag 0 during recovery
Jul  9 01:55:33 jtj kernel: ata2: ignoring command completion for tag 1 during recovery
Jul  9 01:55:33 jtj kernel: ata2: ignoring command completion for tag 3 during recovery
Jul  9 01:55:33 jtj kernel: ata2: ignoring command completion for tag 4 during recovery
Jul  9 01:55:33 jtj kernel: ata2: ignoring command error for tag 0 during recovery
Jul  9 01:55:33 jtj kernel: ata2: ignoring command error for tag 1 during recovery
Jul  9 01:55:33 jtj kernel: ata2: ignoring command error for tag 3 during recovery
Jul  9 01:55:33 jtj kernel: ata2: ignoring command error for tag 4 during recovery
Jul  9 01:55:33 jtj kernel: AHCI2: FIS(tag02) 00000000: 002f8027 a0000010 00000000 08000001 00000000
Jul  9 01:55:38 jtj kernel: ata2: failed to read log page 10h (-110)
Jul  9 01:55:38 jtj kernel: ata2: resetting...
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 0 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 1 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 3 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 4 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 0 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 1 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 3 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 4 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 0 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 1 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 3 during recovery
Jul  9 01:55:38 jtj kernel: ata2: ignoring command completion for tag 4 during recovery
Jul  9 01:55:38 jtj kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Jul  9 01:55:38 jtj kernel: ata2: error=0x04 { DriveStatusError }
Jul  9 01:55:38 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:55:39 jtj kernel: sdb: Current: sense key: Aborted Command
Jul  9 01:55:39 jtj kernel:     Additional sense: No additional sense information
Jul  9 01:55:39 jtj kernel: end_request: I/O error, dev sdb, sector 196046270
Jul  9 01:55:39 jtj kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Jul  9 01:55:39 jtj kernel: ata2: error=0x04 { DriveStatusError }
Jul  9 01:55:39 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:55:39 jtj kernel: sdb: Current: sense key: Aborted Command
Jul  9 01:55:39 jtj kernel:     Additional sense: No additional sense information
Jul  9 01:55:39 jtj kernel: end_request: I/O error, dev sdb, sector 172912475
Jul  9 01:55:39 jtj kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Jul  9 01:55:39 jtj kernel: ata2: error=0x04 { DriveStatusError }
Jul  9 01:55:39 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:55:39 jtj kernel: sdb: Current: sense key: Aborted Command
Jul  9 01:55:39 jtj kernel:     Additional sense: No additional sense information
Jul  9 01:55:39 jtj kernel: end_request: I/O error, dev sdb, sector 210757749
Jul  9 01:55:39 jtj kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Jul  9 01:55:39 jtj kernel: ata2: error=0x04 { DriveStatusError }
Jul  9 01:55:39 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:55:39 jtj kernel: sdb: Current: sense key: Aborted Command
Jul  9 01:55:39 jtj kernel:     Additional sense: No additional sense information
Jul  9 01:55:39 jtj kernel: end_request: I/O error, dev sdb, sector 190118725
Jul  9 01:55:39 jtj kernel: ata2: recovery complete
<
< Resuming operation after recover
<
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag00) dec59c80: 20608027 4054fb4d 0000000b 08000000 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag01) dec65980: 20608027 408fe87d 0000000c 08000008 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag02) dec59e00: 20608027 404e6f63 0000000a 08000010 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag00) df512800: 20608027 40af6dc6 0000000b 08000000 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FAILING 03 dec59680: 28608027 402c12c1 00000001 08000018 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag03) dec59680: 28608027 40ffffff 00ffffff 08000018 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag01) de412380: 28608027 40f81a7a 0000000e 08000008 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag00) dec65b00: 28608027 40cc1ef3 0000000c 08000000 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag02) dec65080: 28608027 40cb8b56 00000003 08000010 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag04) dec59980: 28608027 40b3098c 0000000a 08000020 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag05) dec59b00: 28608027 4003cd11 00000000 08000028 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag06) de412500: 28608027 401c742f 00000007 08000030 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag07) de412680: 28608027 40ff60f3 00000006 08000038 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag08) dec65800: 28608027 405a982c 0000000f 08000040 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag09) dec59800: 28608027 40da1b58 00000011 08000048 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag10) de412980: 28608027 40dded2e 00000002 08000050 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag11) de412800: 28608027 403c47f0 00000006 08000058 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag12) df512980: 28608027 405a6009 0000000c 08000060 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag13) dec65500: 28608027 40dd6792 00000009 08000068 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag14) dec65380: 28608027 40d893d5 0000000b 08000070 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag15) dec59500: 28608027 4016977b 0000000a 08000078 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag16) df512680: 28608027 40ef168c 0000000c 08000080 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag17) dec65c80: 28608027 40d892f2 00000001 08000088 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag18) dec65200: 28608027 4039b3ae 00000010 08000090 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag19) dec65e00: 28608027 405d0c0a 00000011 08000098 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag20) de412e00: 28608027 40a52ad3 00000002 080000a0 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag21) de412080: 28608027 405432a4 00000004 080000a8 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag22) de412c80: 28608027 40f7f7cf 00000002 080000b0 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag23) de412200: 28608027 40ab0ea9 00000011 080000b8 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag24) de412b00: 28608027 4025057f 00000004 080000c0 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag25) dec65680: 28608027 40d2921c 00000006 080000c8 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag26) dec59c80: 28608027 40086324 0000000b 080000d0 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag27) dec65980: 28608027 408976b5 00000001 080000d8 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag28) dec59e00: 28608027 40ff90bc 00000001 080000e0 00000000
Jul  9 01:55:39 jtj kernel: AHCI2: FIS(tag29) df512800: 28608027 40eaf199 00000002 080000e8 00000000
<
< All commands timed out.  Recovery kicks in.  Drive seems locked up already.
<
Jul  9 01:56:09 jtj kernel: ata2: recovering from timeout
Jul  9 01:56:09 jtj kernel: ata2: stat=40, issuing COMRESET
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 0 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 1 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 2 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 3 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 4 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 5 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 6 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 7 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 8 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 9 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 10 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 11 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 12 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 13 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 14 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 15 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 16 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 17 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 18 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 19 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 20 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 21 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 22 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 23 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 24 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 25 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 26 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 27 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 28 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 29 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 0 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 1 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 2 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 3 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 4 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 5 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 6 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 7 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 8 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 9 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 10 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 11 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 12 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 13 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 14 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 15 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 16 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 17 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 18 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 19 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 20 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 21 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 22 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 23 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 24 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 25 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 26 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 27 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 28 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 29 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 0 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 1 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 2 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 3 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 4 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 5 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 6 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 7 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 8 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 9 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 10 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 11 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 12 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 13 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 14 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 15 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 16 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 17 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 18 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 19 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 20 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 21 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 22 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 23 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 24 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 25 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 26 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 27 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 28 during recovery
Jul  9 01:56:09 jtj kernel: ata2: ignoring command completion for tag 29 during recovery
Jul  9 01:56:16 jtj kernel: ata2 is slow to respond, please be patient
Jul  9 01:56:39 jtj kernel: ata2 failed to respond (30 secs)
>
> Drive fails to become ata_ok after COMRESET and libata disables the drive.
>
Jul  9 01:56:39 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:39 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:39 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:39 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:39 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:39 jtj kernel: end_request: I/O error, dev sdb, sector 214703859
Jul  9 01:56:39 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:39 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:39 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:39 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 251140730
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 63671126
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 19665601
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 179505548
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 249105
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 119305263
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 117399795
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 257595436
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 299506520
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 48098606
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 104613872
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 207249417
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 165504914
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 198742997
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 169252731
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 216995468
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 30970610
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 272217006
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 291310602
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 44378835
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 72626852
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 49805263
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 296423081
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 69535103
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 114463260
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 185099044
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 25786037
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 33525948
Jul  9 01:56:40 jtj kernel: ata2: status=0x41 { DriveReady Error }
Jul  9 01:56:40 jtj kernel: ata2: called with no error (41)!
Jul  9 01:56:40 jtj kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Jul  9 01:56:40 jtj kernel: sdb: Current: sense key: Medium Error
Jul  9 01:56:40 jtj kernel:     Additional sense: Unrecovered read error - auto reallocate failed
Jul  9 01:56:40 jtj kernel: end_request: I/O error, dev sdb, sector 48951705
Jul  9 01:56:40 jtj kernel: ata2: recovery complete
>
> Drive disabled.  Drive doesn't respond to anything until it's cold
> power cycled.
>
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 48951713
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 33525956
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 25786045
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 185099052
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 114463268
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 69535111
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 296423089
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 49805271
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 72626860
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 44378843
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 291310610
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 272217014
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 30970618
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 216995476
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 169252739
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 198743005
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
Jul  9 01:56:41 jtj kernel: end_request: I/O error, dev sdb, sector 165504922
Jul  9 01:56:41 jtj kernel: SCSI error : <2 0 0 0> return code = 0x40000
