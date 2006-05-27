From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH alt4 v3] libata resume fixes
Date: Sat, 27 May 2006 17:11:39 -0400
Message-ID: <4478C08B.60308@garzik.org>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527205213.GA30686@havoc.gtf.org> <4478BD18.6010908@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42641 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964983AbWE0VMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:12:15 -0400
In-Reply-To: <4478BD18.6010908@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org

Mark Lord wrote:
> I tried merging Linus's one-liner in front of alt4_v2,
> and the screen came back right away (instead of stalling 30seconds),
> and then the alt4_v2 code killed the interface as before.  :)
> 
> Jeff Garzik wrote:
>> Here's alt4 v3.  Having the host_stat == 0x1 was suspicious.
>> After digging through the hardware manual, it might be a good idea to
>> configure BMDMA registers properly, in case that was done by BIOS but
>> not by D3->D0 silicon reset values.
> 
> I'll try that.  But does it make sense that Linus's one-liner
> would also work, if this was really the problem?  (dunno, just asking)

<shrug>  ata_piix is probably going through its emulated-PATA sequence, 
so I was just trying different things.


>> One core problem with all of libata suspend/resume is that
>> * we boot from a configuration set up by BIOS
>> * but going D3->D0, we simply get silicon defaults
>>
>> Randy Dunlap's ACPI patches will probably help a bit.
> 
> The ACPI patches have indeed been working here for over a year now,
> on all kernels up to 2.6.15 --> not needed for 2.6.16.

Long term they are definitely needed, if only for the case where a drive 
password has been set in BIOS.  Otherwise when you resume, you won't be 
able to talk to your disk.  Additionally the preferences (such drive 
acoustic settings) aren't reprogrammed, but that is of lesser importance.

On laptops, the ACPI tables sometimes also hold special vendor-specific 
taskfiles to work around device-specific or drive-firmware-specific 
problems.

	Jeff


