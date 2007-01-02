From: Mark Lord <lkml@rtr.ca>
Subject: ATA_12 support for libata/ATAPI devices
Date: Tue, 02 Jan 2007 16:50:40 -0500
Message-ID: <459AD3B0.70202@rtr.ca>
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <4599992D.8000607@rtr.ca> <20070102083414.GQ2483@kernel.dk> <459A73CB.8010901@rtr.ca> <459A8E17.80601@gmail.com> <459A97EC.8090903@rtr.ca> <459A9C30.20204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2951 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964972AbXABWXH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 17:23:07 -0500
In-Reply-To: <459A9C30.20204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
..
>>> Support for IDENTIFY PACKET DEVICE would be nice too.
>> It already does that, using HDIO_DRIVE_CMD to retrieve it
>> in the same way as for regular IDENTIFY DEVICE commands.
> 
> Hmmm... My hdparm doesn't seem to do that.
> 
> # hdparm -V
> hdparm v6.9
> # hdparm -I /dev/sr0
> 
> /dev/sr0:
>  HDIO_DRIVE_CMD(identify) failed: Input/output error
> 
> Am I missing something?

Okay, I've dug through the code and found bugs in SCSI and libata.
After fixing those, "hdparm -I" now works unmodified for libata ATAPI.

I'll post fixes shortly, after some more testing.

Cheers
