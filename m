From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Promise SATA 300 TX2plus: disk stops responding
Date: Wed, 9 Jul 2008 14:39:24 +0200
Message-ID: <18548.45436.262423.693474@harpo.it.uu.se>
References: <200807021136.m62BaPvx026056@harpo.it.uu.se>
	<501db8660807041150r5f800839m4815275d6542760@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:51151 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbYGIMjb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jul 2008 08:39:31 -0400
In-Reply-To: <501db8660807041150r5f800839m4815275d6542760@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aneurin Price <aneurin.price@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

On Fri, 4 Jul 2008 19:50:17 +0100, Aneurin Price wrote:
>>>[1382260.429883] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
>>>0x2 frozen
>>>[1382260.429931] ata1.00: cmd 25/00:50:27:6e:cd/00:00:15:00:00/e0 tag
>>>0 dma 40960 in
>>>[1382260.429933]          res 40/00:00:00:00:00/00:00:00:00:00/00
>>>Emask 0x4 (timeout)
>>>[1382260.429956] ata1.00: status: { DRDY }
>>>[1382265.796276] ata1: port is slow to respond, please be patient (Status
>>>0xff)
>>>[1382270.473163] ata1: device not ready (errno=-16), forcing hardreset
>>>[1382270.473179] ata1: hard resetting link
>>>[1382276.679024] ata1: port is slow to respond, please be patient (Status
>>>0xff)
>>>[1382280.476592] ata1: COMRESET failed (errno=-16)
>>>[1382280.476626] ata1: hard resetting link
>>>[1382286.692400] ata1: port is slow to respond, please be patient (Status
>>>0xff)
>>>[1382290.529795] ata1: COMRESET failed (errno=-16)
>>>[1382290.529829] ata1: hard resetting link
>>>[1382296.745702] ata1: port is slow to respond, please be patient (Status
>>>0xff)
>>>[1382325.566448] ata1: COMRESET failed (errno=-16)
>>>[1382325.566484] ata1: limiting SATA link speed to 1.5 Gbps
>>>[1382325.566487] ata1: hard resetting link
>>>[1382330.573112] ata1: COMRESET failed (errno=-16)
>>>[1382330.573146] ata1: reset failed, giving up
>>>[1382330.573162] ata1.00: disabled
>>>[1382330.573188] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002
>>>action 0xa frozen t4
>>>[1382330.573212] ata1: hotplug_status 0x10
>>>[1382330.573226] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
>> ...
>>>[1382571.052939] ata1: EH pending after 5 tries, giving up
>>
>> These are signs of the disk going offline, or the communication between
>> the controller and the disk being corrupted. That's a hardware issue,
>> not unlike what we see with bad PSUs.
>>
>> The 2.6.24 kernel lacks two post-2.6.24 sata_promise bug fixes.
>> The first fixes a problem where error recovery may trigger unexpected
>> hotplug events (we see those in your log), the second fixes a potential
>> problem in interrupt status clearing operations.
>>
>
>Does this mean that it could potentially be possible to recover from this error,
>even without nailing the cause?

In your log the stray hotplug events occur only after several failed
COMRESET attempts. I don't know if fixing the stray hotplug events has
any effect on the COMRESETs. Try the patch, it won't do any harm.

> Are random hardware problems of this sort quite
>common, and papered over by good drivers as a matter of course?

I wouldn't say "common". It seems to vary a lot from machine to
machine. As for papering over, that's what the error recovery
handling in libata and the driver are supposed to handle, although
it's clearly not always effective.

/Mikael
