From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH alt2] libata resume fixes
Date: Sat, 27 May 2006 15:29:28 -0400
Message-ID: <4478A898.6050005@garzik.org>
References: <20060527191323.GA26671@havoc.gtf.org> <4478A6C5.2040201@rtr.ca> <4478A74F.8070008@garzik.org> <4478A855.2070104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54158 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964948AbWE0T3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:29:32 -0400
In-Reply-To: <4478A855.2070104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, axboe@suse.de

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>> Okay, back again after two reboots.  Same failure mode as all of the 
>>> others.
>>> System freezes for a 30-second timeout with no LCD-backlight on,
>>> then comes up without functioning hard drive access.  An immediate 
>>> reboot
>>> is necessary to do anything.
>>
>> Thanks for testing.
>>
>> On the working patch, can you verify that ata_pci_device_resume() is 
>> called before ata_scsi_device_resume() ?
> 
> You mean on Linus's one-liner patch?

Yes.


> That one didn't change the ordering from current 2.6.17-rc* libata.

I know.


> I can instrument that, though, and report back if you need.
> 
> ??

Please do...

Thanks,

	Jeff


