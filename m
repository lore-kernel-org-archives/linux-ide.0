From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Wed, 18 Apr 2012 02:18:40 -0400
Message-ID: <4F8E5CC0.4050804@pobox.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com>  <4F8DD939.1050909@pobox.com> <4F8DDB24.9080109@teksavvy.com>  <4F8DDC4F.8060103@pobox.com> <4F8DDDC0.2010609@teksavvy.com>  <CAF1ivSbEWJ18vV1ZqTnzWuZ5AXKwj+0pPPzCWUmnT_JKwKKQ2w@mail.gmail.com> <1334712587.11188.139.camel@minggr> <4F8E1ADF.3060606@teksavvy.com> <4F8E1D0A.8000203@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:60282 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab2DRGSn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 02:18:43 -0400
Received: by qafi31 with SMTP id i31so334529qaf.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2012 23:18:42 -0700 (PDT)
In-Reply-To: <4F8E1D0A.8000203@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On 04/17/2012 09:46 PM, Mark Lord wrote:
> On 12-04-17 09:37 PM, Mark Lord wrote:
>> On 12-04-17 09:29 PM, Lin Ming wrote:
>>>
>>> I'm working on the hotplug issue fix.
>>>
>>> Before the fix is ready, here is the one-line patch.
>>> Could you give it a try?
>> ..
>>> --- a/drivers/ata/libata-transport.c
>>> +++ b/drivers/ata/libata-transport.c
>>> @@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
>>>   	device_enable_async_suspend(dev);
>>>   	pm_runtime_set_active(dev);
>>>   	pm_runtime_enable(dev);
>>> +	pm_runtime_forbid(dev);
>>>
>> ..
>>
>> I'm rebuilding the kernel right now.. should take about 5min or less to test.
>
> Yeah, that (by itself) is enough to make things work again.
> This looks like the one-liner that we really need upstream and in -stable.
>
> Jeff?
>
> I'll now use it instead of the (much larger) "v2 disable runtime pm" thing.

Yeah I like that a -whole- lot better...

Will push upstream tomorrow.



