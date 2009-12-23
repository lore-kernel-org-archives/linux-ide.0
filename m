From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: Long delays while hibernating
Date: Wed, 23 Dec 2009 13:50:25 +0000
Message-ID: <74fd948d0912230550i639f7c05m9a6e5c9996479c01@mail.gmail.com>
References: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>
	 <4B31CAF9.8070104@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:49659 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbZLWNu0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Dec 2009 08:50:26 -0500
Received: by ewy19 with SMTP id 19so6337194ewy.21
        for <linux-ide@vger.kernel.org>; Wed, 23 Dec 2009 05:50:25 -0800 (PST)
In-Reply-To: <4B31CAF9.8070104@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Wed, Dec 23, 2009 at 7:47 AM, Tejun Heo <tj@kernel.org> wrote:
> On 12/23/2009 12:50 PM, Pedro Ribeiro wrote:
>> Hi,
>>
>> I have a 2.6.32.2 kernel with the TuxOnIce and KDB patches. When I
>> hibernate, the penultimate phase is the "Atomic copy/restore". On
>> normal conditions, this takes 1 second or less.
>>
>> I have a Thinkpad T400 with an ultrabay, which is a hot-swappable
>> drive enclosure, which can take in an optical drive (my case), hard
>> disk or extra battery.
>> To save some battery, I use the script here
>> http://www.thinkwiki.org/wiki/How_to_hotswap_UltraBay_devices#Script_for_Ultrabay_eject
>> to power off the ultrabay.
>>
>> Then when I hibernate with the ultrabay powered off, the "Atomic
>> copy/restore" phase takes 30 seconds and sometimes even a hard lockup
>> occurs.
>> Just at the start of "Atomic copy/restore", the drive gets polled (the
>> light flashes for a second and makes some loading noise) and then
>> takes the CPU to 100% (I can hear the fan roar) for 30 seconds.
>>
>> I'm sure this is related to the fact that the ultrabay is powered off.
>> There nothing else that triggers this.
>>
>> I tried using KDB to interrupt during this phase but that doesn't
>> work. Only after the operation is complete KDB jumps in, so there is
>> no way to interrupt whatever is happening.
>>
>> I reported this issue to the TuxOnIce developer, and he asked me to
>> report it to you.
>
> Can you please attach the output of dmidecode?
>
> Thanks.
>
> --
> tejun
>

Thanks for the quick reply, here is what you requested.
http://pastebin.com/m72748645


Pedro
