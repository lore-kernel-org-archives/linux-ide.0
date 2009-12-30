From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Re: the biggest regression at all
Date: Wed, 30 Dec 2009 13:19:18 -0600
Message-ID: <4B3BA7B6.3050405@mail.usask.ca>
References: <LptzGUUXbTK.A.MSF.ymhOLB@chimera> <200912292153.32853.rjw@sisk.pl> <web-125862914@zbackend1.aha.ru> <200912292335.10178.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:60718 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbZL3TAS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Dec 2009 14:00:18 -0500
Received: by gxk3 with SMTP id 3so76611gxk.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Dec 2009 11:00:17 -0800 (PST)
In-Reply-To: <200912292335.10178.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: werner <w.landgraf@ru.ru>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ide <linux-ide@vger.kernel.org>

On 01/-10/-28163 01:59 PM, Rafael J. Wysocki wrote:
> Hi,
>
> First of all, I'm not the right person to report these problems to.
>
> On Tuesday 29 December 2009, werner wrote:
>> It's very important your work to collect regressions.
>> Because in the last months accumulate more and more
>> regressions, which gave on more and more computers
>> (especially, laptops) problems.
>>
>> There continues two problems which I reported earlier, and
>> which are big problems, making impossible the instalation
>> of new Linux kernels on a good part of laptops, but which
>> were ignored or even negated, anyway not resolved.
>>
>> / The earlier hda=scsi command line parameter don't work
>> more correctly or perhaps was substituted (I dont know
>> exactly, because the kernel command line parameter list is
>> obsolete, too).   Anyway, there are laptops, whose IDE
>> devices during booting is reclamed as ocupied, without
>> end.  After some minutes the boot process cancel this and
>> continues, however without assign the device as detected.
>> Then booting fails because the disk and the system isn't
>> found.
>>
>> The only manner how I found to get detected the IDE device
>> is with pci=off (I tried plenty other things).  But then
>> other things like sound, grafics etc are not detected (and
>> lspci don't give output) and the system works only in text
>> mode.
>>
>> For my opinion, the best solution is to introduce an
>> option pci=noide, so that only the IDE devices will be
>> excluded and then detected or taken over by the BIOS. All
>> other things should be detected normally.
>
> The issue above should better be reported to the people on
> linux-ide@vger.kernel.org , as no one else really can take care of it.
>
> Still, I think there's a known way to solve this problem, since I've never
> seen it myself and I happen to install Linux quite often on notebooks.
>
> What distribution do you use?

I can't really make any sense out of this report. We need more 
information: what type of machine was being used, what kernel version, 
which IDE drivers (IDE or libata), for starters. The only thing I can 
suspect may be an issue is that if you're using the old IDE drivers then 
you don't have a proper hardware-specific driver for your machine 
enabled in your kernel configuration. At some point I believe the 
generic IDE driver was changed to not attach to as many devices as it 
did previously as it would end up being used in cases where it shouldn't be.
