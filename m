From: Tejun Heo <tj@kernel.org>
Subject: Re: [git patches] libata hibernation fixes
Date: Wed, 05 Nov 2008 11:30:22 +0900
Message-ID: <4911053E.9070103@kernel.org>
References: <fa.Ast7pgG6P20u1PcyOsfgzoaX5YA@ifi.uio.no>	<fa.1+JQHm7yjIiZJxAzR0eBPn39a9M@ifi.uio.no>	<fa.+bfipgmFkcLlZMtnFL0Ks2zyN8Q@ifi.uio.no>	<fa.Iek0GbTZLinM2sOi6+b7bsCgnfs@ifi.uio.no> <4910E240.4000801@shaw.ca> <87abcfdmpp.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35371 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbYKECa5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 21:30:57 -0500
In-Reply-To: <87abcfdmpp.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Robert Hancock <hancockr@shaw.ca>, Mark Lord <liml@rtr.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Elias Oltmanns wrote:
>> On these systems, not spinning the disk down is fine because the BIOS
>> does it. However this would cause problems on systems where the BIOS
>> doesn't do so as it will cause an emergency unload on power-down.
> 
> Ah, but do BIOSes just cut power without spinning disks down first?
> Pressing the power button on my laptop either at the prompt for the HD
> password or in GRUB's menu spins the disk down properly. Isn't that the
> BIOS doing its job?

Drives don't like emergency unloads but they are designed to take
some.  BIOS diddling with the storage controller behind OS's back
causes a lot of trouble.  On certain machines, the BIOS expects the
storage controller to be in certain state on suspend and tries to
issue commands assuming that particular state triggering a minute long
CPU burn before finally entering suspend.  It just isn't worth it and
if BIOS wants to do it, it should be smart and don't do it if the
system is powering off in orderly manner (that is, driven by OS).

The double spindown happens due to combination of weirdities in the
BIOS and drive firmware.  Some drives like to spin up on FLUSH while
spun down even when the buffer is empty.  Others like to spin up on
STANDBY_IMMEDIATE recevied while spun down and then spin back down.

My guess is HP added BIOS spin down feature to BIOS and tested with
certain flavors of drives and then later found out that other drives
suffer from the new BIOS behavior and patched up their preloaded
windows driver.  It's a messy case requiring a messy workaround.

Thanks.

-- 
tejun
