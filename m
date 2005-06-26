From: Tejun Heo <htejun@gmail.com>
Subject: Re: test logs
Date: Mon, 27 Jun 2005 00:34:22 +0900
Message-ID: <20050626153422.GA504@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:53904 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261350AbVFZPe3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:34:29 -0400
Received: by zproxy.gmail.com with SMTP id l1so96546nzf
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:34:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

 Hello, Jeff.
 Hello, Jens.

 These are some of my test logs.  Oh, BTW, I didn't setup lksp config
file correctly and the subject lines say the patches are against
Linux-2.6.12.  They are all against NCQ head of libata-dev-2.6.  Sorry
about the confusion.

##
## Normal recovery from error.  Tag 03 is corrupted before issueing,
## and the drive fails the command.  On recovery, log page 10h reports
## the failing command and that command is failed w/ error.  All other
## in-flight requests are retried.
##
AHCI: FIS(tag02): 08608027 40dd5196 0000000a 08000010 00000000
AHCI: FAILING 03: 08608027 4096c97d 0000000c 08000018 00000000
AHCI: FIS(tag03): 08608027 40ffffff 00ffffff 08000018 00000000
AHCI: FIS(tag00): 08608027 4045382f 00000010 08000000 00000000
ata1: aborting commands due to error.  active_tag -1, sactive 0000000f
ata1: recovering from error
AHCI: FIS(tag31): 002f8027 a0000010 00000000 08000001 00000000
ata1: log_ext_10h, tag=3 stat=51 err=10
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x10 { SectorIdNotFound }
SCSI error : <1 0 0 0> return code = 0x8000002
sdb: Current: sense key: Aborted Command
    Additional sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 211208573
AHCI: FIS(tag00): 08608027 40dd5196 0000000a 08000000 00000000
AHCI: FIS(tag01): 08608027 40bbe638 0000000d 08000008 00000000
AHCI: FIS(tag00): 08608027 4045382f 00000010 08000000 00000000
AHCI: FIS(tag02): 10608027 40780b0c 00000005 08000010 00000000

##
## Similar, but this time we happen to send more commands to the drive
## following the corrupted one before the drive reports error.  On
## Samsung HD160JJ, this causes drive lockup and thus the following
## read_log_page fails with timeout causing COMMRESET and failing of
## all in-flight commands.  The drive becomes fully operational
## after the COMMRESET.
##
AHCI: FIS(tag01): 10608027 40348e58 00000001 08000008 00000000
AHCI: FIS(tag02): 10608027 402bfe4b 00000011 08000010 00000000
AHCI: FAILING 03: 10608027 4096c975 0000000c 08000018 00000000
AHCI: FIS(tag03): 10608027 40ffffff 00ffffff 08000018 00000000
AHCI: FIS(tag00): 10608027 4046335b 0000000d 08000000 00000000
AHCI: FIS(tag01): 10608027 40453827 00000010 08000008 00000000
AHCI: FIS(tag04): 10608027 40dd518e 0000000a 08000020 00000000
AHCI: FIS(tag05): 10608027 40bbe630 0000000d 08000028 00000000
AHCI: FIS(tag06): 10608027 4006ff90 00000004 08000030 00000000
ata1: aborting commands due to error.  active_tag -1, sactive 0000007f
ata1: aborting commands due to error.  active_tag -1, sactive 00000000
ata1: recovering from error
AHCI: FIS(tag31): 002f8027 a0000010 00000000 08000001 00000000
ata1: failed to read log page 10h (-110)
ata1: resetting...
ata1: status=0x01 { Error }
ata1: error=0x80 { Sector }
SCSI error : <1 0 0 0> return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 222704475
ata1: status=0x01 { Error }
ata1: error=0x80 { Sector }
SCSI error : <1 0 0 0> return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 272971815

##
## This is timeout example.
##
AHCI: FIS(tag00): 10608027 40cc69a6 0000000d 08000000 00000000
AHCI: FIS(tag03): 10608027 400d2804 00000008 08000018 00000000
AHCI: SKIPPING 03
AHCI: FIS(tag04): 10608027 409bdbaa 00000000 08000020 00000000
AHCI: FIS(tag05): 10608027 405776d8 00000004 08000028 00000000
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
AHCI: FIS(tag07): 10608027 402f3c4e 00000010 08000038 00000000
AHCI: FIS(tag12): 10608027 402b78dc 0000000f 08000060 00000000
ata1: recovering from error
ata1: status=0x01 { Error }
ata1: error=0x80 { Sector }
SCSI error : <1 0 0 0> return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 135079940
AHCI: FIS(tag00): 08608027 400d280c 00000008 08000000 00000000
AHCI: FIS(tag01): 10608027 40a514dd 00000001 08000008 00000000
AHCI: FIS(tag02): 10608027 4069f4e2 00000002 08000010 00000000


 Thanks.

-- 
tejun
