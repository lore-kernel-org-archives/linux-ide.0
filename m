From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH alt4 v2] libata resume fixes
Date: Sat, 27 May 2006 16:32:03 -0400
Message-ID: <4478B743.2050006@garzik.org>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527201024.GA29015@havoc.gtf.org> <4478B312.5040901@garzik.org> <4478B611.2030201@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35216 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964929AbWE0UcJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:32:09 -0400
In-Reply-To: <4478B611.2030201@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, torvalds@osdl.org
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Jeff Garzik wrote:
>>> This fixes a bug in alt4 v1, by eliminating the second ata_set_mode()
>>> call, found in ata_device_resume().
>>
>> This seems to make my x86-64 box happier...
>>
>>     Jeff
> 
> With alt4_v2 applied, resume still fails,
> but slightly differently from before.
> 
> This time, there's the initial blank-screen for 31 seconds,
> then the backlight turns on and I can see the syslog scrolling
> in the window where I left it, as before.
> 
> New, is that the disk activity LED is stuck-on,
> and the error-recovery code is doing something
> every 30 seconds or so (see attached screen shot).

Yay!  I'm familiar with the 0xD0 status on ata_piix, so this is really 
good progress.


> Other than that, it's still dead -- disk I/O not working.
> 
> Can this patch be combined with Linus's one-liner
> and still work on your machine?

Does alt4v2 plus Linus's patch work on your machine?  (I'm guessing "no")

	Jeff


