From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata bugfix: HDIO_DRIVE_TASK
Date: Tue, 20 Feb 2007 10:49:05 -0500
Message-ID: <45DB1871.7050607@garzik.org>
References: <45CA00EC.7070507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43999 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965172AbXBTPtI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 10:49:08 -0500
In-Reply-To: <45CA00EC.7070507@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> I was trying to use HDIO_DRIVE_TASK for something today,
> and discovered that the libata implementation does not copy
> over the upper four LBA bits from args[6].
> 
> This is serious, as any tools using this ioctl would have their
> commands applied to the wrong sectors on the drive, possibly resulting
> in disk corruption.
> 
> Ideally, newer apps should use SG_IO/ATA_16 directly,
> avoiding this bug.  But with libata poised to displace drivers/ide,
> better compatibility here is a must.
> 
> This patch fixes libata to use the upper four LBA bits passed
> in from the ioctl.
> 
> The original drivers/ide implementation copies over all bits
> except for the master/slave select bit.  With this patch,
> libata will copy only the four high-order LBA bits,
> just in case there are assumptions elsewhere in libata (?).
> 
> Signed-Off-By:  Mark Lord <mlord@pobox.com>

applied


