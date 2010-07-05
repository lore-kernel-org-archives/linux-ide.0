From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Drives missing at boot
Date: Mon, 5 Jul 2010 09:56:12 -0700
Message-ID: <AANLkTilupyieml9yaWO9BUNPmQQ0g2w1HLWj6R9MwDZf@mail.gmail.com>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>
	<4C2F5ECB.1040505@kernel.org>
	<AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>
	<4C2F61AB.9030806@kernel.org>
	<AANLkTilYOT45q8OUJ-_V61_fnYy9HIk6GAv5ZPiomCaT@mail.gmail.com>
	<4C317C04.20500@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54649 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab0GEQ4O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 12:56:14 -0400
In-Reply-To: <4C317C04.20500@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Jul 4, 2010 at 11:30 PM, Tejun Heo <tj@kernel.org> wrote:
> On 07/03/2010 06:42 PM, Mark Knecht wrote:
>> On Sat, Jul 3, 2010 at 9:13 AM, Tejun Heo <tj@kernel.org> wrote:
>>> Hello,
>>>
>>> On 07/03/2010 06:06 PM, Mark Knecht wrote:
>>>>> Can you please *attach* full logs of a successful boot and several
>>>>> failing boots?
>>>>
>>>> Certainly? Which logs? dmesg or something else?
>>>
>>> dmesg output preferably with printk timestamp enabled.
>
> Can you please apply the attached patch, reproduce the problem and
> post the kernel log?
>
> Thanks.
>
> --
> tejun
>

I'm sorry. What am I patching? I'm not a kernel developer - not even a
programmer - so I'll need some help with this. What's the command I
should use?

c2stable src # ls -la /usr/src/
total 32
drwxr-xr-x  8 root root 4096 Jul  2 09:56 .
drwxr-xr-x 14 root root 4096 Apr 15 07:46 ..
-rw-r--r--  1 root root    0 Mar 24 18:37 .keep
lrwxrwxrwx  1 root root   22 Jul  2 09:56 linux ->
linux-2.6.34-gentoo-r1
drwxr-xr-x 23 root root 4096 Jun 16 07:23 linux-2.6.32-gentoo-r7
drwxr-xr-x 24 root root 4096 Jun 16 08:42 linux-2.6.34-gentoo
drwxr-xr-x 24 root root 4096 Jul  3 15:30 linux-2.6.34-gentoo-r1
drwxr-xr-x 21 root root 4096 Jun 27 13:12 linux-2.6.34-rc3
drwxr-xr-x 20 root root 4096 Jun 15 08:05 linux-2.6.34-rc5
drwxr-xr-x 20 root root 4096 Jun 27 13:13 linux-2.6.35-rc3
c2stable src #

Thanks,
Mark
