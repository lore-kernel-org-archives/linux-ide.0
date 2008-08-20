From: Tejun Heo <htejun@gmail.com>
Subject: Re: Flush drive cache before issuing ATA_16 from userspace?
Date: Wed, 20 Aug 2008 13:08:38 +0900
Message-ID: <48AB98C6.3040805@gmail.com>
References: <48AACDA1.7070206@rtr.ca> <48AB43A9.3000003@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:58206 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbYHTEJR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Aug 2008 00:09:17 -0400
Received: by ti-out-0910.google.com with SMTP id b6so142719tic.23
        for <linux-ide@vger.kernel.org>; Tue, 19 Aug 2008 21:09:15 -0700 (PDT)
In-Reply-To: <48AB43A9.3000003@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>> That's an IDENTIFY (0xEC) command timing out.
>> The hddtemp program does it's work by issuing IDENTIFY and SMART
>> commands to the target drive, /dev/sdb in this case.
>>
>>     ioctl(3, 0x30d, 0xbfd2c418)
>>     ioctl(3, 0x31f, 0xbfd2c60c)
>>     ioctl(3, 0x31f, 0xbfd2c614)
>>     ioctl(3, 0x31f, 0xbfd2c408)
>>
>> So that 0xEC most likely came from the hddtemp program,
>> since libata doesn't normally issue them after probing.
>>
>> So why is it timing out?  Well, these drives have 32MB onboard caches,
>> and I'm guessing that something (firmware, whatever) tries to empty that
>> cache before processing the issued IDENTIFY command.  And we time out
>> before the drive has a chance to actually process the IDENTIFY.
> ..
> 
> Another possibility could be some kind of bug in libata or ahci.c.
> It seems unlikely -- .qc_defer ought to prevent issues -- but I haven't
> really poked around in there.  And this is a "production" machine :)
> so we don't like to use it (much) for debugging kernels if we can help it.

Can you please hack up a program to issue IDENTIFY with different
timeouts and see when the condition triggers?

Thanks.

-- 
tejun
