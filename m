From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [git patches] libata hibernation fixes
Date: Wed, 05 Nov 2008 10:31:08 +0100
Message-ID: <874p2mecyr.fsf@denkblock.local>
References: <fa.Ast7pgG6P20u1PcyOsfgzoaX5YA@ifi.uio.no>
	<fa.1+JQHm7yjIiZJxAzR0eBPn39a9M@ifi.uio.no>
	<fa.+bfipgmFkcLlZMtnFL0Ks2zyN8Q@ifi.uio.no>
	<fa.Iek0GbTZLinM2sOi6+b7bsCgnfs@ifi.uio.no> <4910E240.4000801@shaw.ca>
	<87abcfdmpp.fsf@denkblock.local> <4911053E.9070103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:60158 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585AbYKEJb2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2008 04:31:28 -0500
In-Reply-To: <4911053E.9070103@kernel.org> (Tejun Heo's message of "Wed, 05
	Nov 2008 11:30:22 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Mark Lord <liml@rtr.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Tejun Heo <tj@kernel.org> wrote:
> Elias Oltmanns wrote:
>>> On these systems, not spinning the disk down is fine because the BIOS
>
>>> does it. However this would cause problems on systems where the BIOS
>>> doesn't do so as it will cause an emergency unload on power-down.
>> 
>> Ah, but do BIOSes just cut power without spinning disks down first?
>> Pressing the power button on my laptop either at the prompt for the HD
>> password or in GRUB's menu spins the disk down properly. Isn't that the
>> BIOS doing its job?
>
> Drives don't like emergency unloads but they are designed to take
> some.

In the situations I mentioned above, the drive definitely is not
performing an emergency unload. On the other hand, the BIOS hasn't
handed over control to the OS at this stage, so it would make sense if
the BIOS behaved differently once the OS has taken over. BTW, what
exactly will happen if I install an ancient OS like DOS on my
(reasonably) modern laptop? I've never tried that but I don't see how
the OS would even have a chance to spin the disk down befor power off
since there is no way for the user to initiate power off in the OS. Is
that anything to do with ACPI support?

Regards,

Elias
