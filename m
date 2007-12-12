From: Will Trives <will@trivescon.com.au>
Subject: Re: [PATCH #upstream-fixes] libata:
	update	atapi_eh_request_sense() such that lbam/lbah contains buffer size
Date: Wed, 12 Dec 2007 19:16:06 +1100
Message-ID: <1197447366.3467.10.camel@Athas>
References: <475F51AE.1010305@gmail.com> <1197446739.3467.4.camel@Athas>
	 <475F98C9.6080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail12.tpgi.com.au ([203.12.160.162]:40518 "EHLO
	mail12.tpgi.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbXLLIWO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 03:22:14 -0500
In-Reply-To: <475F98C9.6080804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, yannick.dirou@axetic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>


On Wed, 2007-12-12 at 17:16 +0900, Tejun Heo wrote:
Will Trives wrote:
> > Hello guys,
> > 
> > Yannick does it work ok for you when you try to blank a dvd+rw disc ?
> > Mine no longer jams up the drive now but it does say that the media or
> > drive does not support blanking. I'm thinking its either because these
> > discs just do multisession so this is what was meant to happen all along
> > or there's still something going on. 
> 
> Does the kernel complain about anything?
> 
Nope.

> This drive or media does not support the 'BLANK media' command
> > wodim: Cannot blank disk, aborting.
> > wodim: Some drives do not support all blank types.
> > wodim: Try again with wodim blank=all.
> 
> wodim suggests "blank=all", does it work?
> 
Nope same thing happens.

"dvd+rw-format /dev/sr0 -force"  Works ok though.

This is the media info after the format

dvd+rw-mediainfo /dev/sr0

INQUIRY:                [BENQ    ][DVD DD DW1640   ][BSRB]
GET [CURRENT] CONFIGURATION:
 Mounted Media:         1Ah, DVD+RW
 Current Write Speed:   4.0x1385=5540KB/s
 Write Speed #0:        4.0x1385=5540KB/s
 Write Speed #1:        2.4x1385=3324KB/s
GET [CURRENT] PERFORMANCE:
 Write Performance:     4.0x1385=5540KB/s@[0 -> 264671]
 Speed Descriptor#0:    00/264671 R@5.2x1385=7181KB/s W@4.0x1385=5540KB/s
 Speed Descriptor#1:    00/264671 R@5.2x1385=7181KB/s W@2.4x1385=3324KB/s
READ DVD STRUCTURE[#0h]:
 Media Book Type:       00h, DVD-ROM book [revision 0]
 Media ID:              MKM/A02
 Legacy lead-out at:    264672*2KB=542048256
READ DISC INFORMATION:
 Disc status:           complete
 Number of Sessions:    1
 State of Last Session: complete
 Number of Tracks:      1
 BG Format Status:      suspended
READ FORMAT CAPACITIES:
 formatted:             264672*2048=542048256
 26h(0):                2295104*2048=4700372992
READ TRACK INFORMATION[#1]:
 Track State:           complete
 Track Start Address:   0*2KB
 Free Blocks:           0*2KB
 Track Size:            2295104*2KB
FABRICATED TOC:
 Track#1  :             14@0
 Track#AA :             17@2295104
 Multi-session Info:    #1@0
READ CAPACITY:          2295104*2048=4700372992


