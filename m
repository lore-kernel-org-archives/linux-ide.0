From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata atapi work #2.1
Date: 16 May 2004 09:39:52 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084721991.3085.6.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:32147 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263640AbUEPPkK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 11:40:10 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> Subject: Re: SATA ATAPI work in progress
> Date: 2004-05-15 16:32:56
> ...
> Seems like we are pretty close.  Once I add
> the code to issue a REQUEST SENSE, I bet
> things start working.

I agree!  I'm delighted to report,

I now see SATA stream up past 1.5 GB/min via ioctl SG_IO read & write of
the disc blocks, after I apply together all four of the patches you
first posted as:

> Subject: [PATCH] libata update 20040515-1
> Subject: [PATCH] libata atapi work #2.1
> Subject: [PATCH] libata DMADIR support
> Subject: [PATCH] Re: SATA ATAPI work in progress

Heads up, I was myself slow to appreciate:

Yes still in -bk3 after patch.2.1 we need to apply that fourth patch
i.e. what I had termed patch.7 i.e. ata_host_intr += ATA_PROT_ATAPI_DMA.

> Once I add the code to issue a REQUEST SENSE, ...

Also, of course, to avoid dying for the lack of auto sense, I have to
duck all errors.

Once I died by mistyping an LBA, off by one nybble.  Repeatedly I die
except when I remember to clear the x 6 29 Reset and x 6 28 GoneReady
unit attentions, via an abuse which works here i.e. repeatedly
unsolicited "REQUEST SENSE".  I notice in particular that, with this
device, modprobe seemingly provokes x 6 29 Reset.

Pat LaVarre


$ # demo of 1.5 GB/min, in or out
$
$ plscsi /dev/sg0 -i x12 -x "03 00:00:00 12 00"
$ plscsi /dev/sg0 -i x12 -x "03 00:00:00 12 00"
$
$ time pldd of if=/dev/sg0 bs=64k sbs=2k skip=0 count=1600
 
real    0m4.134s
user    0m0.002s
sys     0m0.155s
$
$ dc -e '64 1024 * 1600 * 4.134 / p 60 * p'
25364683
1521880980
$
$ time pldd of=/dev/sg0 if bs=64k sbs=2k seek=0 count=1600
 
real    0m4.125s
user    0m0.001s
sys     0m0.150s
$
$ dc -e '64 1024 * 1600 * 4.125 / p 60 * p'
25420024
1525201440
$


$ # demo of reset implicit in modprobe
$
$ plscsi /dev/sg0 -i x12 -x "03 00:00:00 12 00" -v
x 00000000 03 00:00:00 12 00 .. .. .. .. .. .. .. .. .. .. "C@@@R@"
x 00000000 70:00:00:00 00:00:00:18 00:00:00:00 00:00:00:00 "p@@@@@@X@@@@@@@@"
x 00000010 00:00 .. .. .. .. .. .. .. .. .. .. .. .. .. .. "@@"
// 0 = plscsi.main exit int
$
$ sudo modprobe -r ata-piix
$ sudo modprobe ata-piix
$
$ plscsi /dev/sg0 -i x12 -x "03 00:00:00 12 00" -v
x 00000000 03 00:00:00 12 00 .. .. .. .. .. .. .. .. .. .. "C@@@R@"
x 00000000 70:00:06:00 00:00:00:18 00:00:00:00 29:00:00:00 "p@F@@@@X@@@@)@@@"
x 00000010 00:00 .. .. .. .. .. .. .. .. .. .. .. .. .. .. "@@"
// 0 = plscsi.main exit int
$


