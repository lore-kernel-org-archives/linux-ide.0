From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Thu, 19 Apr 2012 09:31:15 +0800
Message-ID: <CAF1ivSaKp0yvPKop+z-PbE7UYGuwBFQ+0ohXmn5j+BwgGYusMQ@mail.gmail.com>
References: <4F8DD4DC.4050503@teksavvy.com>
	<4F8DD708.8050502@teksavvy.com>
	<4F8DD834.5070000@teksavvy.com>
	<4F8DDA53.206@teksavvy.com>
	<CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com>
	<4F8EF57E.4070603@fold.natur.cuni.cz>
	<4F8EF9F7.5040202@pobox.com>
	<4F8EFD89.2080603@fold.natur.cuni.cz>
	<4F8F08D7.6050809@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:50681 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab2DSBbR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 21:31:17 -0400
Received: by qafi31 with SMTP id i31so1327735qaf.1
        for <linux-ide@vger.kernel.org>; Wed, 18 Apr 2012 18:31:16 -0700 (PDT)
In-Reply-To: <4F8F08D7.6050809@fold.natur.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Apr 19, 2012 at 2:32 AM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Martin Mokrejs wrote:
>>
>>
>> Jeff Garzik wrote:
>>> On 04/18/2012 01:10 PM, Martin Mokrejs wrote:
>>>> Fix: I got my 3TB disk detected by this single command:
>>>>
>>>> # echo on> =A0 /sys/devices/pci0000:00/0000:00:1f.2/ata6/power/con=
trol
>>>> #
>>>>
>>>> This is a Dell Vostro 3550 with A09 BIOS. Same happend with 3.4-rc=
3 kernel.
>>>>
>>>> I can do some more testing if you want me to.
>>>> Best,
>>>> Martin
>>>
>>>
>>> Can you test this one-line patch from Lin Ming? =A0Hopefully there =
is zero sysfs twiddling required with this one...
>>>
>>> --- a/drivers/ata/libata-transport.c
>>> +++ b/drivers/ata/libata-transport.c
>>> @@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
>>> =A0 =A0 =A0device_enable_async_suspend(dev);
>>> =A0 =A0 =A0pm_runtime_set_active(dev);
>>> =A0 =A0 =A0pm_runtime_enable(dev);
>>> + =A0 =A0pm_runtime_forbid(dev);
>>>
>>> =A0 =A0 =A0transport_add_device(dev);
>>> =A0 =A0 =A0transport_configure_device(dev);
>
>
> There is one more minor issue. I cannot get my disk re-dectected at 3=
Gbps. Here is when I plugged it in
> for the very first time after bootup (plain 3.4-rc3 with the above on=
e-line fix):

Hi Martin,

I'm looking at this issue now.

Thanks for test and report.

Lin Ming
