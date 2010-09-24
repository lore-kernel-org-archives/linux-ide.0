From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector bug)
Date: Fri, 24 Sep 2010 18:10:02 +0300
Message-ID: <4C9CBF4A.9060302@gmail.com>
References: <4C03C608.1040600@gmail.com> <20100601135004.GP15159@redhat.com> <4C051D44.7040203@gmail.com> <20100602184459.GA15159@redhat.com> <4C0B3E94.6020506@gmail.com> <4C80B338.6020701@gmail.com> <20100903135613.GV4879@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64622 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496Ab0IXPKI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2010 11:10:08 -0400
In-Reply-To: <20100903135613.GV4879@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-ide@vger.kernel.org

On 09/03/2010 04:56 PM, Don Zickus wrote:
> On Fri, Sep 03, 2010 at 10:35:04AM +0200, Jiri Slaby wrote:
>> On 06/06/2010 08:22 AM, Jiri Slaby wrote:
>>> On 06/02/2010 08:44 PM, Don Zickus wrote:
>>>> --- a/kernel/watchdog.c
>>>> +++ b/kernel/watchdog.c
>>>> @@ -550,8 +550,7 @@ cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
>>>>  		break;
>>>>  	case CPU_ONLINE:
>>>>  	case CPU_ONLINE_FROZEN:
>>>> -		if (watchdog_enable(hotcpu))
>>>> -			return NOTIFY_BAD;
>>>> +		watchdog_enable(hotcpu)
>>>
>>> This fixes the problem indeed.
>>
>> Hi, was this fixed somehow? I still use this hunk and don't know if it
>> is needed:
> 
> I have to go re-review the problem again.  I might have forgot to bring it
> in.  Thanks for reminding me!

Reminder #2 :). Any updates?

thanks,
-- 
js
