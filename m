From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 17:16:48 -0400
Message-ID: <4F8DDDC0.2010609@teksavvy.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com> <4F8DD939.1050909@pobox.com> <4F8DDB24.9080109@teksavvy.com> <4F8DDC4F.8060103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:52575 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab2DQVQt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 17:16:49 -0400
In-Reply-To: <4F8DDC4F.8060103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 12-04-17 05:10 PM, Jeff Garzik wrote:
> On 04/17/2012 05:05 PM, Mark Lord wrote:
>> On 12-04-17 04:57 PM, Jeff Garzik wrote:
>>> On 04/17/2012 04:48 PM, Mark Lord wrote:
>>>> On 12-04-17 04:38 PM, Mark Lord wrote:
>>>>> Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
>>>>> I don't know when it stopped working, but it's a blooming pain in the sysadmin.
>>>>>
>>>>> I need to hotplug a SATA drive into an AHCI port,
>>>>> preferably without having to reboot first.
>>>>>
>>>>> Is there a patch available already for this regression?
>>>>
>>>>
>>>> Answering my own question, this patch appears to address the issue.
>>>> I'll test and report back again shortly:
>>>>
>>>>       http://patchwork.ozlabs.org/patch/146326/
>>>>
>>>> Odd that it's been sitting in various people's inboxes since 3.3-rc1
>>>> and hasn't been pushed out yet.
>>>
>>> The vast majority of "hotpluggable" ports are not necessarily covered by this patch.
>>
>>
>> And what majority of ports are currently broken by linux-3.3 ?
>> Any idea of what the offending commit may have been,
>> so I can test against that and perhaps get it reverted then?
>>
>> So far, my sample of three systems are all broken with this kernel.
>> That's definitely "regression" territory.  :)
> 
> Right -- rather than breaking a bunch and fixing a few, we might just need to revert the runtime pm
> stuff altogether.
> 
> Commits to look at include
> 
>     966f1212e1ac5fe3ddf04479d21488ddb36a2608
>     33574d68ae41ccbc6686cfabd965c685285c58a0
>     e90b1e5a6e04c8892007ff8db20ef6d4fbdb5402
>     9ee4f3933930abf5cc34f8e9d69fe0e08c18f602
>     5ef41082912bdfcb33fa53b8dba2ad17dea2ef90
>     9a6d6a2ddabbd32c07f6a38b659e5f3db319fa5a
> 

Or perhaps there's a simpler solution/patch, maybe a one-liner
to change the boot-up default to "no runtime PM until enabled" or something.

Probably less risky if the changes are as pervasive as you suggest.

