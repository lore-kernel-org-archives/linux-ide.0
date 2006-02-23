From: Jon K Hellan <hellan@acm.org>
Subject: Re: sata_sil.c, 3512 and SIL_QUIRK_MOD15WRITE
Date: Thu, 23 Feb 2006 07:59:47 +0100
Message-ID: <1140677987.11943.16.camel@localhost>
References: <loom.20060222T182150-518@post.gmane.org>
	 <43FD18F5.20002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tyholt.uninett.no ([158.38.60.10]:23260 "EHLO tyholt.uninett.no")
	by vger.kernel.org with ESMTP id S1750865AbWBWHAH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Feb 2006 02:00:07 -0500
In-Reply-To: <43FD18F5.20002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

On Thu, 2006-02-23 at 11:07 +0900, Tejun Heo wrote:
> According to the errata information from Silicon Image, SiI3512 does not 
> have m15w bug, neither does ST3200822AS. So, this must be something else 
> and you're not an isolated case.

Glad to hear it.

In that case, you'd probably like to hear about the other disk as well.
Originally, I suspected the disk was about to fail, and bought another
one - a Samsung SP2504C. I never succeeded in copying the data off the
Seagate onto the Samsung. The farthest I got was about 2 gigs. The error
messages would be from sdb (the Samsung):

Feb 21 20:08:31 parus kernel: ata2: command 0x35 timeout, stat 0xd1 host_stat 0x61
Feb 21 20:08:31 parus kernel: ata2: translated ATA stat/err 0xd1/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 21 20:08:31 parus kernel: ata2: status=0xd1 { Busy }
Feb 21 20:08:31 parus kernel: sd 1:0:0:0: SCSI error: return code =
0x8000002
Feb 21 20:08:31 parus kernel: sdb: Current: sense key: Aborted Command
Feb 21 20:08:31 parus kernel:     Additional sense: Scsi parity error
Feb 21 20:08:31 parus kernel: end_request: I/O error, dev sdb, sector
15657695
Feb 21 20:08:31 parus kernel: Buffer I/O error on device sdb1, logical
block 1957204
Feb 21 20:08:31 parus kernel: lost page write due to I/O error on sdb1
Feb 21 20:08:31 parus kernel: ATA: abnormal status 0xD1 on port
0xF88020C7

I didn't bring this up originally, since it looked like the Seagate
problem was a known bug, while Google didn't turn up anything on
Samsung. After reading linux-ide through gmane, I've seen similar issues
about Samsung. You guys should get an archive which Google knows
about :-)

> So, it would be very nice if you can test fixes we'll be able to come up with.

Certainly.

Regards

Jon

