From: Randy Broman <rbroman@bayarea.net>
Subject: Re: Software RAID Problem
Date: Wed, 29 Jul 2009 13:43:40 -0700
Message-ID: <4A70B47C.8020108@bayarea.net>
References: <1248798289.4a6f26510c218@myaccount.bayarea.net> <4A6FAF54.1060902@kernel.org> <4A706D78.7000107@bayarea.net> <4A70A5A1.1030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shell4.bayarea.net ([209.128.82.1]:53332 "EHLO
	shell4.bayarea.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826AbZG2Unm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jul 2009 16:43:42 -0400
In-Reply-To: <4A70A5A1.1030600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <tj@kernel.org>

The array box is an American Media Systems Venus T4S, and the
(2) disks are Western Digital Black 750 GB. The array box is set up
as JBOD (pass-thru) in it's hardware, but ....

Both American Media Systems (via Silicon Image) and Western Digital
have management and diagnostic utilities that run on Windows, so I
attached the array box to a Windows system and ran the utilities. The
results look OK for the disks themselves, when they're attached directly
to the system board, but the test results are inconsistent for the array 
box.

Thus I'm beginning to think I have a hardware problem. I appreciate
the help, but rather than take up more of people's time on this mailing
list I'll continue with the hardware diagnostics, and then see if I can
successfully set up the array box on Windows. If that works, I'll try
it back on Linux.

Thanks ....


Robert Hancock wrote:
> On 07/29/2009 09:40 AM, Randy Broman wrote:
>> Per your instructions .... I tail -f'd /var/log/dmesg and
>> /var/l0g/messages,
>> and then executed the four mdadm commands below, for the faulty array.
>> After removing and re-adding the faulty disk partition to the array, the
>> array
>> returns to faulty state almost immediately. During the process, dmesg
>> didn't
>> show anything, but the information written to /var/log/messages is at 
>> the
>> bottom hereto.
>>
>> I suppose one answer is that there's a hardware issue with the array, or
>> one of the disks. But that would be surprising to me - both the hardware
>> array and the disks are new, and the setup (hardware/software/RAID) 
>> worked
>> fine until I tried to upgrade my kernel. Possibly RAID-related 
>> formats are
>> different between kernel 2.6.28 and 2.6.31????
>>
>> Anyway, would appreciate diagnosis/recommendations ...
>
> The output looks a bit scrambled and seems to be missing certain lines 
> (we see hardresets but not any error that triggered it). Sometimes 
> that seems to happen if disk problems are occurring (kernel logger 
> buffer overflows or something). If the kernel messages are showing up 
> in /var/log/messages then they should be showing up in dmesg and would 
> be more complete. Can you check again?
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

