From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH alt4 v3] libata resume fixes
Date: Sat, 27 May 2006 17:25:48 -0400
Message-ID: <4478C3DC.1040907@garzik.org>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527205213.GA30686@havoc.gtf.org> <4478BD18.6010908@rtr.ca> <4478C08B.60308@garzik.org> <4478C15E.5030500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:13970 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964997AbWE0VZx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:25:53 -0400
In-Reply-To: <4478C15E.5030500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, randy_dunlap <rdunlap@xenotime.net>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>
>>> The ACPI patches have indeed been working here for over a year now,
>>> on all kernels up to 2.6.15 --> not needed for 2.6.16.
>>
>> Long term they are definitely needed, if only for the case where a 
>> drive password has been set in BIOS.  Otherwise when you resume, you 
>> won't be able to talk to your disk.  Additionally the preferences 
>> (such drive acoustic settings) aren't reprogrammed, but that is of 
>> lesser importance.
>>
>> On laptops, the ACPI tables sometimes also hold special 
>> vendor-specific taskfiles to work around device-specific or 
>> drive-firmware-specific problems.
> 
> Agreed, 100%.
> 
> So why aren't they in yet?  ;)

Hey, I'm ready for them...

Now that Tejun's EH work is done, the floodgates are open...

	Jeff


