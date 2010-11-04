From: Jeff Garzik <jeff@garzik.org>
Subject: Re: TRIM support in drivers and dm/md?
Date: Thu, 04 Nov 2010 16:23:35 -0400
Message-ID: <4CD31647.7070301@garzik.org>
References: <4CD2B2EF.4050005@att.net> <20101104134014.GB21931@parisc-linux.org> <4CD2C755.3000908@att.net> <4CD2E32D.9030303@garzik.org> <4CD2F3E1.8040700@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37727 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab0KDUXj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Nov 2010 16:23:39 -0400
In-Reply-To: <4CD2F3E1.8040700@att.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Layton <laytonjb@att.net>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-fsdevel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

On 11/04/2010 01:56 PM, Jeff Layton wrote:
>
>>>>> Do many of the SATA controllers support TRIM? (i.e. pass
>>>>> the TRIM command to the SSD). Does anyone know
>>>>> anything about dm/md supporting TRIM? (I'm thinking LVM
>>>>> and software RAID tools).
>>
>>>> As far as I know, there's nothing to be done in any SATA controller
>>>> driver to support TRIM. It's just up to the drive whether it
>>>> understands
>>>> the command.
>>
>>> That's the rub. I've heard that many drivers don't understand
>>> the command. So I'm curious what drivers do and any experience
>>> anyone might have.
>>
>> Note the distinction between "drive" and "driver"... I agree with what
>> Matthew says.
>>
>
> Oops - sorry I missed "drive" vs. "driver".
>
> I've heard from other places that drivers need to pass along
> the TRIM command to the drives but that many drivers don't
> do this. I assume that the best way to determine if this is
> accurate is to test the controller drivers or ping the maintainers.

I'd object to the words "many" and "drivers" :)

The general rule for all kernel SATA drivers is to support all ATA 
commands, including future, unknown commands not invented yet.

That's because kernel SATA drivers deal primarily with the 
sending/receiving from hardware an opaque data bundle -- the ATA 
taskfile -- rather than create a software system that requires new code 
in each driver, for each new ATA command.

That's the ideal and, if you obtained a SATA controller in the past 5 
years or so, your controller (ahci, sata_sil24, others) supports TRIM 
just fine because it is a generic ATA taskfile transport and nothing more.

Some now-uncommon controllers have problems with new ATA commands, 
either due to (a) they are complex, firmware-driven RAID-esque beasts, 
or (b) they have an internal command table.  And I imagine some early 
SATA<->PATA bridge chips probably get confused as well.  But those are 
the minority, and getting less frequent by the day.

Note in all of the above I say "controller" rather than "driver".  I 
know of no _driver_ that prevents TRIM, where the underlying controller 
hardware supports it.

For the controllers that don't support TRIM, the error behavior should 
be something predictable and consistent like a command abort.

	Jeff


