From: Moritz Rempel <m.rempel@bee.de>
Subject: sata_promise PDC20575 I/O error
Date: Tue, 5 Sep 2006 15:13:39 +0200
Message-ID: <20060905151339.62e5c9be.m.rempel@bee.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail.bee.de ([213.221.112.22]:61420 "HELO webmail.bee.de")
	by vger.kernel.org with SMTP id S932189AbWIENNZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2006 09:13:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: m.rempel@bee.de

Hi!

I'm getting the following error on a system with a Promise SATAII150
TX2plus Controller:

Sep  4 15:15:26 server kernel: ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep  4 15:15:26 server kernel: ata1: status=0xff { Busy }
Sep  4 15:15:56 server kernel: ata1: command timeout
Sep  4 15:15:56 server kernel: ata1: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Sep  4 15:15:56 server kernel: ata1: status=0xff { Busy }
Sep  4 15:15:56 server kernel: sd 1:0:0:0: SCSI error: return code = 0x8000002
Sep  4 15:15:56 server kernel: sdb: Current: sense key: Aborted Command
Sep  4 15:15:56 server kernel:     Additional sense: Scsi parity error
Sep  4 15:15:56 server kernel: Info fld=0xfffffff
Sep  4 15:15:56 server kernel: end_request: I/O error, dev sdb, sector 839
Sep  4 15:15:56 server kernel: Buffer I/O error on device sdb1, logical block 388
Sep  4 15:15:56 server kernel: lost page write due to I/O error on sdb1
Sep  4 15:16:26 server kernel: ata1: command timeout

I had no problem formatting the drive, but the error showes up short after
issueing mkfs.ext3 on the one partition I created over the whole disk. mkfs
then hangs and those messages repeat with increasing sector and block number.

Attached to the controller is a external 500G Seagate HD (ST3500641AS)
connected via eSATA. As I've tested with different HDs (of the same type),
I think it's not a defective drive.

Kernels I've tested so far: 2.6.16.19 and 2.6.17.11

Any ideas what is goping wrong?

If you need more information or want me to do any tests I'll do my best to
serve your requests.

thanks in advance,
	Moritz

-- 
-----------------------------------------------------------------------
    *  *  *  *   bee Baastrup EDV-Entwicklung GmbH        Moritz Rempel
||  *  *  *  *   Schwanenwall 40                        m.rempel@bee.de
||\\ //\\ //\\   44135 Dortmund / Germany             http://www.bee.de
||// \\-' \\-'   fon: +49 (0)0231 58719-0         Softwareentwicklung &
    *  *  *  *   fax: +49 (0)0231 58719-50        System-Administration
-----------------------------------------------------------------------
