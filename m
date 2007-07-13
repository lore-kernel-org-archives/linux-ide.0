From: Tejun Heo <htejun@gmail.com>
Subject: Re: Freeze after disabling write cache with hdparm -W0 /dev/sda
Date: Fri, 13 Jul 2007 16:45:50 +0900
Message-ID: <46972DAE.5050503@gmail.com>
References: <46935C4D.40003@onelan.co.uk> <4694669E.7060600@gmail.com> <46949555.9060208@onelan.co.uk> <469496A4.7070902@gmail.com> <46949AB1.80705@onelan.co.uk> <46949B97.8090703@gmail.com> <4694CC42.3060808@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:21621 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbXGMHpz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 03:45:55 -0400
Received: by wa-out-1112.google.com with SMTP id v27so487418wah
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 00:45:54 -0700 (PDT)
In-Reply-To: <4694CC42.3060808@onelan.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: linux-ide@vger.kernel.org

Simon Farnsworth wrote:
> Tejun Heo wrote:
>> Simon Farnsworth wrote:
>>> Tejun Heo wrote:
>>>> Simon Farnsworth wrote:
>>>>> Just a thought; is it possible to trigger libata EH from userspace? If
>>>>> so, we could write a small utility to disable write cache, then force EH
>>>>> to detect the change.
>>>> That's automatically done.  libata snoops cache on/off and triggers
>>>> revalidation but you can request manual rescan by echoing "- - -" to
>>>> /sys/class/scsi_host/hostX/scan.
>>>>
>>> Would it be worth changing our code to do "hdparm -W1 /dev/sda && hdparm
>>> -W0 /dev/sda", or would this not show anything. The lack of revalidation
>>> on some drives is what's worrying me a little here.
>> Revalidation happens after cache property is changed successfully.  What
>> happens if you request manual rescan while the drive is not repsponding?
>>
> The 30 second freeze happens when we request manual rescan. We do
> revalidate once the freeze is over, though; dmesg follows:

Can you post dmesg with printk timestamps turned on?

-- 
tejun
