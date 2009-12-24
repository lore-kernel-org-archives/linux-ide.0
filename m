From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: Long delays while hibernating
Date: Thu, 24 Dec 2009 15:59:43 +0000
Message-ID: <74fd948d0912240759n72e8c141y6b75f1ee7caadf60@mail.gmail.com>
References: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>
	 <4B31CAF9.8070104@kernel.org>
	 <74fd948d0912230550i639f7c05m9a6e5c9996479c01@mail.gmail.com>
	 <4B331C16.4080901@kernel.org>
	 <74fd948d0912240634h621de8b6l746470556da3eb7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34329 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbZLXP7p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Dec 2009 10:59:45 -0500
Received: by ewy19 with SMTP id 19so7427707ewy.21
        for <linux-ide@vger.kernel.org>; Thu, 24 Dec 2009 07:59:44 -0800 (PST)
In-Reply-To: <74fd948d0912240634h621de8b6l746470556da3eb7f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

On Thu, Dec 24, 2009 at 2:34 PM, Pedro Ribeiro <pedrib@gmail.com> wrote:
> On Thu, Dec 24, 2009 at 7:45 AM, Tejun Heo <tj@kernel.org> wrote:
>> On 12/23/2009 10:50 PM, Pedro Ribeiro wrote:
>>>> Can you please attach the output of dmidecode?
>>>
>>> Thanks for the quick reply, here is what you requested.
>>> http://pastebin.com/m72748645
>>
>> Can you please try the attached patch?
>>
>> Thanks.
>>
>> --
>> tejun
>>
>
> Hi,
>
> I tried the patch but I still have the same issue.
>
> Thanks,
> Pedro
>

Hi again,

I just noticed that this patch is for ata_piix. I don't have this
module loaded, as I have an ICH9 chip. The module used is ahci. Here
is the output of lsmod:
http://pastebin.com/m5468985b

Regards,
Pedro
