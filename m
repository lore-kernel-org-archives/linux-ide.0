From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB
Date: Tue, 13 Nov 2007 09:12:53 -0500
Message-ID: <4739B0E5.2010303@rtr.ca>
References: <4738DE21.8090702@shaw.ca> <47390B2F.7090105@gmail.com> <47392768.3030509@shaw.ca> <47392B3D.1020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4330 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbXKMOMz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Nov 2007 09:12:55 -0500
In-Reply-To: <47392B3D.1020101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> Robert Hancock wrote:
>> Tejun Heo wrote:
..
>> Yes, it should likely do something with these return values. Though
>> theoretically it shouldn't fail, since the DMA mask is either 32-bit,
>> which shouldn't fail, or one that was successfully set before. Also I
>> don't think the SCSI layer actually checks the slave_config return
>> value.. sigh.
> 
> Then please at least add WARN_ON() && another reason why allocating /
> deallocating resources from ->slave_config isn't such a good idea.
..

The entire point of "slave_configure" is to provide a point for the LLD
to do per-device data structure allocation/init.

And yes, SCSI does check the return code.  Whether the code around that check
is buggy or not is another question, but it's always worked for me.

>        if (sdev->host->hostt->slave_configure) {
>                 int ret = sdev->host->hostt->slave_configure(sdev);
>                 if (ret) {
>                         /*
>                          * if LLDD reports slave not present, don't clutter
>                          * console with alloc failure messages
>                          */
>                         if (ret != -ENXIO) {
>                                 sdev_printk(KERN_ERR, sdev,
>                                         "failed to configure device\n");
>                         }
>                         return SCSI_SCAN_NO_RESPONSE;
>                 }
>         }


Cheers
