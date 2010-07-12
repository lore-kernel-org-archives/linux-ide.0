From: "Paul Check" <paul@thechecks.ca>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Mon, 12 Jul 2010 12:32:16 -0400
Message-ID: <13096cdf5e0e6704e30364a746e60467.squirrel@thechecks.ca>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
    <4B5D26EF.4030709@kernel.org> <loom.20100205T041929-66@post.gmane.org>
    <12193ff15b0deef3609ea93f54e5b485.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:2243 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756033Ab0GLRAA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jul 2010 13:00:00 -0400
In-Reply-To: <12193ff15b0deef3609ea93f54e5b485.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Check <paul@thechecks.ca>
Cc: linux-ide@vger.kernel.org

Tejun & Co:

I have finally upgraded to the 2.6.34 kernel, and I am still having
problems with some of my drives not coming up some of the time (different
drives, at different times, never more than one).

Here are some lines from /var/log/messages on the most recent boot below.
Do you have any suggestions for this? I'm getting tired of having to
reconstitute my raid 30-50% of the time, and will try anything to see if
it fixes. Note the "link up (unknown)" and "link down" lines. I don't know
what should appear, but I have 4 hard drives and one optical drive plugged
into 5 of the 6 SATA ports on the board.

Thanks, Paul

Jul 12 12:25:22 min kernel: [    1.603253] ata5: SATA link down (SStatus 0
SControl 300)
Jul 12 12:25:22 min kernel: [    1.613838] ata4: SATA link down (SStatus 0
SControl 300)
Jul 12 12:25:22 min kernel: [    1.758918] ata3: SATA link up 1.5 Gbps
(SStatus 113 SControl 300)
Jul 12 12:25:22 min kernel: [    1.766998] ata3.00: ATAPI: SONY    BDRW
BWU-300S, 1.0c, max UDMA/66
Jul 12 12:25:22 min kernel: [    1.782982] ata3.00: configured for UDMA/66
Jul 12 12:25:22 min kernel: [    1.794844] usb 1-5: new high speed USB
device using ehci_hcd and address 4
Jul 12 12:25:22 min kernel: [    1.850794] firewire_core: created device
fw0: GUID 001e8c0000b9c49a, S400
Jul 12 12:25:22 min kernel: [    1.926983] usb 1-5: New USB device found,
idVendor=0409, idProduct=005a
Jul 12 12:25:22 min kernel: [    1.926986] usb 1-5: New USB device
strings: Mfr=0, Product=0, SerialNumber=0
Jul 12 12:25:22 min kernel: [    1.927185] hub 1-5:1.0: USB hub found
Jul 12 12:25:22 min kernel: [    1.927228] hub 1-5:1.0: 4 ports detected
Jul 12 12:25:22 min kernel: [    2.078469] ata2.00: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Jul 12 12:25:22 min kernel: [    2.078485] ata1.00: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Jul 12 12:25:22 min kernel: [    2.078489] ata2.01: SATA link up <unknown>
(SStatus 300 SControl 123)
Jul 12 12:25:22 min kernel: [    2.078505] ata1.01: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Jul 12 12:25:22 min kernel: [    2.086811] ata2.00: ATA-8: ST31000528AS,
CC37, max UDMA/133
Jul 12 12:25:22 min kernel: [    2.086814] ata2.00: 1953525168 sectors,
multi 16: LBA48 NCQ (depth 0/32)
Jul 12 12:25:22 min kernel: [    2.094723] ata1.00: ATA-8: ST31000528AS,
CC37, max UDMA/133
Jul 12 12:25:22 min kernel: [    2.094726] ata1.00: 1953525168 sectors,
multi 16: LBA48 NCQ (depth 0/32)
Jul 12 12:25:22 min kernel: [    2.094969] ata1.01: ATA-8: ST31000528AS,
CC37, max UDMA/133
Jul 12 12:25:22 min kernel: [    2.094972] ata1.01: 1953525168 sectors,
multi 16: LBA48 NCQ (depth 0/32)
Jul 12 12:25:22 min kernel: [    2.102726] ata2.00: configured for UDMA/133
Jul 12 12:25:22 min kernel: [    2.110706] ata1.00: configured for UDMA/133
Jul 12 12:25:22 min kernel: [    2.126670] ata1.01: configured for UDMA/133

> FYI I haven't tried the commit / fix but I am still having the problems,
> so uninstalling PATA did not help, just as many said it likely wouldn't.
>
> Once I try the rc5 and test for many reboots I will report back.  P
>
>> Tejun Heo <tj <at> kernel.org> writes:
>>
>>>
>>> On 01/22/2010 12:57 AM, Paul Check wrote:
>>> > I am having an intermittent problem:
>>> >
>>> > ata1.01: SATA link down (SStatus 0 SControl 301)
>>> >
>>> > which is causing one of my four hard drives to not get recognized.
>>>
>>> Most likely fixed by commit 5040ab67a2c6d5710ba497dc52a8f7035729d7b0.
>>> Can you please try 2.6.33-rc5?
>>>
>>> Thanks.
>>>
>>
>> I've been having intermittent SATA troubles as well recently (Ubuntu
>> 9.10,
>> kernel 2.6.31-17). So here I am after a quick search on Google and it
>> looks like
>> you've already fixed the problem.  I'm no expert on SATA protocol or
>> anything,
>> but reading the diff of that commit looks like it sure does address my
>> problem.
>>  I'm really just here to extend a sincere THANK YOU, to Tejun and all
>> the
>> people
>> that work on this stuff.
>>
>> I'm not sure if it matters or not, but for whatever reason on my box,
>> the
>> problem happens pretty reliably after a long power off cycle (its been
>> off
>> >18
>> hours when I turn it on). I've never seen it fail on a subsequent
>> reboot,
>> even
>> with a short power cycle.  I may have to try compiling the kernel for
>> myself to
>> see if it truly fixes it. I haven't built a kernel in a long time, but
>> maybe
>> I'll give a whirl again.
>>
>> Again thanks!
>>
>> - Tim
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>


