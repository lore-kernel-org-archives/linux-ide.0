From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: Freeze after disabling write cache with hdparm -W0 /dev/sda
Date: Tue, 17 Jul 2007 09:57:21 +0100
Message-ID: <469C8471.80104@onelan.co.uk>
References: <46935C4D.40003@onelan.co.uk> <4694669E.7060600@gmail.com> <46949555.9060208@onelan.co.uk> <469496A4.7070902@gmail.com> <46949AB1.80705@onelan.co.uk> <46949B97.8090703@gmail.com> <4694CC42.3060808@onelan.co.uk> <46972DAE.5050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay4.mail.uk.clara.net ([80.168.70.184]:56352 "EHLO
	relay4.mail.uk.clara.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbXGQI5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jul 2007 04:57:25 -0400
In-Reply-To: <46972DAE.5050503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Simon Farnsworth wrote:
>> Tejun Heo wrote:
>>> Simon Farnsworth wrote:
>>>> Tejun Heo wrote:
>>>>> Simon Farnsworth wrote:
>>>>>> Just a thought; is it possible to trigger libata EH from userspace? If
>>>>>> so, we could write a small utility to disable write cache, then force EH
>>>>>> to detect the change.
>>>>> That's automatically done.  libata snoops cache on/off and triggers
>>>>> revalidation but you can request manual rescan by echoing "- - -" to
>>>>> /sys/class/scsi_host/hostX/scan.
>>>>>
>>>> Would it be worth changing our code to do "hdparm -W1 /dev/sda && hdparm
>>>> -W0 /dev/sda", or would this not show anything. The lack of revalidation
>>>> on some drives is what's worrying me a little here.
>>> Revalidation happens after cache property is changed successfully.  What
>>> happens if you request manual rescan while the drive is not repsponding?
>>>
>> The 30 second freeze happens when we request manual rescan. We do
>> revalidate once the freeze is over, though; dmesg follows:
> 
> Can you post dmesg with printk timestamps turned on?
> 
Sorry for the delay in responding;

Turning on printk timestamps is enough to fix the problem, and stop the
stall from happening.

We'll be rebasing to the newest Fedora 7 kernel soon (next 3 months),
and I've changed our kernel build process to turn on printk timestamps.
If it still happens then, I'll get you a dmesg with timestamps.
-- 
Simon Farnsworth

