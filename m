From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: some minor issues with 2.6.25-rc6-git7-default
Date: Wed, 26 Mar 2008 14:04:10 -0700
Message-ID: <47EABA4A.6030705@oracle.com>
References: <213384793@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:49259 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbYCZVHK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2008 17:07:10 -0400
In-Reply-To: <213384793@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: devzero@web.de
Cc: Andrew Morton <akpm@linux-foundation.org>, alan@lxorguk.ukuu.org.uk, david-b@pacbell.net, greg@kroah.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>

devzero@web.de wrote:
>> Can you post the full kernel log up to this BUG?
>> It should show that causes the Taint.
> 
> oh - yes:
> 
> Mar 23 09:12:20 opensuse103 kernel: ac97_codec: module license 'unspecified' taints kernel.
> 
> modinfo ac97_codec
> filename:       /lib/modules/2.6.25-rc6-git7-default/kernel/sound/oss/ac97_codec.ko
> srcversion:     8665939D5E471F7E331BB3E
> depends:
> vermagic:       2.6.25-rc6-git7-default SMP mod_unload 586
> 
> 
> seems MODULE_LICENSE is missing in ./sound/oss/ac97_codec.c !?

It was recently removed for some reason.

I get the impression that you (we) should be using ALSA drivers/codecs
instead of the OSS ones that in the process of being removed.


>>>>> CCing Dave Brownell.
>>>>>
>>>>>> Mar 23 09:14:23 opensuse103 kernel: Generic RTC Driver v1.07
>>>>>> Mar 23 09:14:23 opensuse103 kernel: proc_dir_entry 'rtc' already registered
>>>>>> Mar 23 09:14:23 opensuse103 kernel: Pid: 3994, comm: modprobe Tainted: P         2.6.25-rc6-git7-default #1
>>>>>> Mar 23 09:14:23 opensuse103 kernel:  [<c019a602>] proc_register+0xf3/0x11f
>>>>>> Mar 23 09:14:23 opensuse103 kernel:  [<c019a719>] create_proc_entry+0x69/0x7b
>>>>>> Mar 23 09:14:23 opensuse103 kernel:  [<e0c5f02d>] rtc_generic_init+0x2d/0x54 [genrtc]
>>>>>> Mar 23 09:14:23 opensuse103 kernel:  [<c013c1de>] sys_init_module+0x16b6/0x17c9
>>>>>> Mar 23 09:14:23 opensuse103 kernel:  [<c0108a6a>] sys_mmap2+0x62/0x77
>>>>>> Mar 23 09:14:23 opensuse103 kernel:  [<c01059c4>] sysenter_past_esp+0x6d/0xa9
>>>>>> Mar 23 09:14:23 opensuse103 kernel:  =======================
>>>> uh, "known problem": multiple rtc drivers are being run.
>>>>
>>>> I don't really understand why we haven't been able to fix this - there have
>>>> been numerous reports..
>>> i will take a closer look to determine how/when this happens.
>> I thought that David B. sent a (Kconfig ?) patch for this...
>>
>> ---
>> ~Randy
> 
> do you mean this one ?
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=55ff1aba940ff46d4f6d4fd790ea3e1a47aaa84f
> 
> ok, it may be sort of "dumb" to blindly load one module after the other but i would expect a more meaningful message.

No, I meant something else, but I can't find it just now.

-- 
~Randy
