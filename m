From: Mark Lord <liml@rtr.ca>
Subject: Re: Flush drive cache before issuing ATA_16 from userspace?
Date: Thu, 21 Aug 2008 18:02:24 -0400
Message-ID: <48ADE5F0.3010607@rtr.ca>
References: <48AACDA1.7070206@rtr.ca> <48AB43A9.3000003@rtr.ca> <48AB98C6.3040805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:52053 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757180AbYHUWC1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Aug 2008 18:02:27 -0400
In-Reply-To: <48AB98C6.3040805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>>> That's an IDENTIFY (0xEC) command timing out.
>>> The hddtemp program does it's work by issuing IDENTIFY and SMART
>>> commands to the target drive, /dev/sdb in this case.
>>>
>>>     ioctl(3, 0x30d, 0xbfd2c418)
>>>     ioctl(3, 0x31f, 0xbfd2c60c)
>>>     ioctl(3, 0x31f, 0xbfd2c614)
>>>     ioctl(3, 0x31f, 0xbfd2c408)
>>>
>>> So that 0xEC most likely came from the hddtemp program,
>>> since libata doesn't normally issue them after probing.
>>>
>>> So why is it timing out?  Well, these drives have 32MB onboard caches,
>>> and I'm guessing that something (firmware, whatever) tries to empty that
>>> cache before processing the issued IDENTIFY command.  And we time out
>>> before the drive has a chance to actually process the IDENTIFY.
>> ..
>>
>> Another possibility could be some kind of bug in libata or ahci.c.
>> It seems unlikely -- .qc_defer ought to prevent issues -- but I haven't
>> really poked around in there.  And this is a "production" machine :)
>> so we don't like to use it (much) for debugging kernels if we can help it.
> 
> Can you please hack up a program to issue IDENTIFY with different
> timeouts and see when the condition triggers?
..

Yeah, there's a bunch of stuff like that for me to do, someday.  :)

Meanwhile, summer finally arrived here today, so..

Cheers
