From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix, laptop cdrom, ICH7: EH, limiting speed to PIO
Date: Mon, 17 Sep 2007 13:37:14 +0200
Message-ID: <46EE66EA.3090902@gmail.com>
References: <20070911212030.GA2817@slk.laptop>	 <6bffcb0e0709120933p6d58127fv3c85076fe41daaca@mail.gmail.com>	 <20070912200706.GA2620@slk.laptop> <46E849B7.9040402@googlemail.com>	 <20070912212025.GB2620@slk.laptop> <46E8663E.3080205@googlemail.com>	 <46ED19F0.8060205@gmail.com> <ac0be4d70709170257o62e856f4re049c968ab5590a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:32377 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbXIQLjJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 07:39:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2002637wah
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 04:39:09 -0700 (PDT)
In-Reply-To: <ac0be4d70709170257o62e856f4re049c968ab5590a7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Dolgov <dolgovs@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Sergey Dolgov wrote:
> On 9/16/07, Tejun Heo <htejun@gmail.com> wrote:
>> Michal Piotrowski wrote:
>>> Sergey Dolgov pisze:
>>>> On Wed, Sep 12, 2007 at 10:19:03PM +0200, Michal Piotrowski wrote:
>>>>> Sergey Dolgov pisze:
>>>>>> Hi Michal,
>>>>>>
>>>>>> On Wed, Sep 12, 2007 at 06:33:20PM +0200, Michal Piotrowski wrote:
>>>>>>> Hi Sergey,
>>>>>>>
>>>>>>> On 11/09/2007, Sergey Dolgov <dolgovs@gmail.com> wrote:
>>>>>>>> Hi!
>>>>>>>>
>>>>>>>> On my hp nx7300 laptop, 2 following scenarios can happen during bootup
>>>>>>>> (see attachments for the full logs): the "good" one [1] and the one
>>>>>>>> where multiple EHs lead to limiting the speed [2].
>>>>>>>>
>>>>>>>> [1] one is more rare, but it seems to be persistent over reboots: once
>>>>>>>> it happened, just rebooting the machine always results in behaviour
>>>>>>>> like [1].
>>>>>>>>
>>>>>>>> [1] results in a working cdrom from the start. An attempt to use cdrom
>>>>>>>> after [2] happened results in even more EHs, resulting in "configured
>>>>>>>> for PIO4", after which the cdrom is finaly working.
>>>>>>>>
>>>>>>>> The version I'm using is 2.6.23-rc6, but the same used to happen with
>>>>>>>> the previous rc's, and probably with 2.6.22 too (I can check).
>>>>>>> It would be great if you could check it.
>>>>>> I've just built 2.6.22.6 with basically the same configuration, and
>>>>>> the behaviour is just the same, i.e. both [1] and [2] still can
>>>>>> happen.
>>>>> Ok, thanks.
>>>>>
>>>>> BTW please check cables and PCU.
>>>> What's a PCU?
>>> s/PCU/PSU - power supply unit
>>>
>>>> BTW, this only happens when using libata of course. The
>>>> old CONFIG_IDE stuff works fine every time.
>>> This maybe one of libata weirdness (I really don't get it why some hardware
>>> works perfectly fine with an old IDE and don't work well with libata).
>> Hmmm... Is MWDMA2 mode used with ide driver too?
>>
> 
> What's the best way to tell whether it does or not? (the log says
> "selected mode 0x22", see below)

Yes, that's MWDMA2.  Hmm... We're seeing many cases where MWDMA doesn't
work with libata while it works fine with IDE but have no idea what's
going on yet.  :-(

-- 
tejun
