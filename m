From: Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 14:37:04 -0600
Message-ID: <45BE5AF0.3030005@cs.wisc.edu>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>  <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net> <1170051963.6454.7.camel@Homer.simpson.net> <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sabe.cs.wisc.edu ([128.105.6.20]:44646 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbXA2UtJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 15:49:09 -0500
In-Reply-To: <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>

Linus Torvalds wrote:
>>
>> [ 4362.972995] hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> [ 4362.981475] ide: failed opcode was: unknown
>> [ 4362.986183] hdd: drive not ready for command
> 

What chipsets are you guys using?

I tried 2.6.20-rc6, and forced my cdrom to be used by the ide piix
driver instead of the sata one, so the device shows up as hda instead of
a scsi one. And, if I use the ide piix driver for the cdrom then it
works fine. I see IO going through the block layer sg io code which was
modified in 2.6.20 to support larger IOs.

Strangely, if I use the sata driver, then nero uses the sg driver
(drivers/scsi/sg.c) instead of the block layer sg io code. But the sata
code spits out:

Jan 29 12:03:21 madmax kernel: ata1.00: ATAPI check failed
Jan 29 12:03:21 madmax kernel: ata1.00: exception Emask 0x0 SAct 0x0
SErr 0x0 action 0x2 frozen
Jan 29 12:03:21 madmax kernel: ata1.00: cmd
a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0xac data 808 in
Jan 29 12:03:21 madmax kernel:          res
51/51:03:00:00:20/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
Jan 29 12:03:21 madmax kernel: ata1: soft resetting port
Jan 29 12:03:21 madmax kernel: ATA: abnormal status 0xD0 on port 0x1F7
Jan 29 12:03:21 madmax kernel: ata1.00: failed to IDENTIFY (I/O error,
err_mask=0x2)
Jan 29 12:03:21 madmax kernel: ata1.00: revalidation failed (errno=-5)
Jan 29 12:03:21 madmax kernel: ata1: failed to recover some devices,
retrying in 5 secs
Jan 29 12:03:33 madmax kernel: ata1: port is slow to respond, please be
patient (Status 0xd0)
Jan 29 12:03:56 madmax kernel: ata1: port failed to respond (30 secs,
Status 0xd0)
Jan 29 12:03:56 madmax kernel: ata1: soft resetting port
Jan 29 12:03:57 madmax kernel: ata1.00: configured for PIO4
Jan 29 12:03:57 madmax kernel: ata1: EH complete

nero still works in this case, but is is sluggish. It takes a couple
minutes to start up and on almost every operation like "Choose Recorder"
spits out more error messages like above.

This may be not be related. I am going to keep digging around.
