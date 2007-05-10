From: Mark Lord <lkml@rtr.ca>
Subject: Re: HDIO_DRIVE_CMD and hdparm
Date: Thu, 10 May 2007 09:13:54 -0400
Message-ID: <46431A92.8010501@rtr.ca>
References: <Pine.LNX.4.62.0705101327170.759@pademelon.sonytel.be> <20070510135153.5f6d62f8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1588 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755629AbXEJNN4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 May 2007 09:13:56 -0400
In-Reply-To: <20070510135153.5f6d62f8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>>   - SCSI doesn't handle HDIO_DRIVE_CMD(null), and returns EINVAL
>>     => fine for hdparm
>>   - If a block device doesn't support the ioctl, blkdev_driver_ioctl() returns
>>     ENOTTY
>>     => hdparm error message
> 
> Those are both correct
> 	-ENOTTY 		I don't know this ioctl
> 	-EINVAL			I know this ioctl, usage wrong

Exactly.
I'll have hdparm-7.4 not complain on ENOTTY as well.

-ml
