From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [git patches] libata hibernation fixes
Date: Wed, 05 Nov 2008 08:37:48 -0600
Message-ID: <4911AFBC.3070800@shaw.ca>
References: <fa.Ast7pgG6P20u1PcyOsfgzoaX5YA@ifi.uio.no> <fa.1+JQHm7yjIiZJxAzR0eBPn39a9M@ifi.uio.no> <fa.+bfipgmFkcLlZMtnFL0Ks2zyN8Q@ifi.uio.no> <fa.Iek0GbTZLinM2sOi6+b7bsCgnfs@ifi.uio.no> <4910E240.4000801@shaw.ca> <87abcfdmpp.fsf@denkblock.local> <4911053E.9070103@kernel.org> <874p2mecyr.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:45302 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbYKEOhx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Nov 2008 09:37:53 -0500
In-Reply-To: <874p2mecyr.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Tejun Heo <tj@kernel.org>, Mark Lord <liml@rtr.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Elias Oltmanns wrote:
> Tejun Heo <tj@kernel.org> wrote:
>> Elias Oltmanns wrote:
>>>> On these systems, not spinning the disk down is fine because the BIOS
>>>> does it. However this would cause problems on systems where the BIOS
>>>> doesn't do so as it will cause an emergency unload on power-down.
>>> Ah, but do BIOSes just cut power without spinning disks down first?
>>> Pressing the power button on my laptop either at the prompt for the HD
>>> password or in GRUB's menu spins the disk down properly. Isn't that the
>>> BIOS doing its job?
>> Drives don't like emergency unloads but they are designed to take
>> some.
> 
> In the situations I mentioned above, the drive definitely is not
> performing an emergency unload. On the other hand, the BIOS hasn't
> handed over control to the OS at this stage, so it would make sense if
> the BIOS behaved differently once the OS has taken over. BTW, what
> exactly will happen if I install an ancient OS like DOS on my
> (reasonably) modern laptop? I've never tried that but I don't see how
> the OS would even have a chance to spin the disk down befor power off
> since there is no way for the user to initiate power off in the OS. Is
> that anything to do with ACPI support?

The BIOS is in control of the power-down when the power button is 
pressed when not in ACPI mode (unless it's held down to force a power 
off), it can install some SMI handlers to trigger the spindown before it 
turns off the machine. On mine it seems like that's exactly what it does 
(i.e. if you hit power in the GRUB menu it spins down the drive first).

When an ACPI power down occurs however, it would likely be best if it 
stayed out of the way..
