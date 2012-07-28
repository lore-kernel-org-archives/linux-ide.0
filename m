From: Stirling Westrup <swestrup@gmail.com>
Subject: Re: IRQ issues with multiple SiI3114's on Kernel 3.2
Date: Fri, 27 Jul 2012 22:20:52 -0400
Message-ID: <CAJt7KB8JJE9m1WKxkZ+Svbtazr2RW1v4jWAm9zcqxbbqBFWusw@mail.gmail.com>
References: <CAJt7KB8-yPm7RX8doKw1WjYwxfvVQ8Af7GNmu=QVsM_sAtYKiQ@mail.gmail.com>
	<5012CEE4.8040306@hardwarefreak.com>
	<CAJt7KB9=cr3cTB_oyO1AJEfHtQp+hR39ZDNpX5f0M1+YAyiGkQ@mail.gmail.com>
Reply-To: swestrup@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61936 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab2G1CUx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2012 22:20:53 -0400
Received: by obbuo13 with SMTP id uo13so5167882obb.19
        for <linux-ide@vger.kernel.org>; Fri, 27 Jul 2012 19:20:52 -0700 (PDT)
In-Reply-To: <CAJt7KB9=cr3cTB_oyO1AJEfHtQp+hR39ZDNpX5f0M1+YAyiGkQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stan@hardwarefreak.com
Cc: linux-ide@vger.kernel.org

On Fri, Jul 27, 2012 at 6:14 PM, Stirling Westrup <swestrup@gmail.com> wrote:
> On Fri, Jul 27, 2012 at 1:24 PM, Stan Hoeppner <stan@hardwarefreak.com> wrote:
>> On 7/27/2012 11:40 AM, Stirling Westrup wrote:
>>
>>> I recently purchased a large system for use as a backup server for a
>>> pair of small businesses. It contains a boot drive plus 10 more
>>> storage drives. Despite having three onboard SATA controllers, the
>>> motherboard didn't have enough SATA connectors for all the drives, so
>>> I installed a pair of identical SiI3114 raid cards to handle the extra
>>> connections. It has a Sandy Bridge chipset, so I installed a 3.2
>>> kernel.
>>>
>>> # uname -a
>>> Linux ttt 3.2.0-0.bpo.2-amd64 #1 SMP Fri Jun 29 20:42:29 UTC 2012
>>> x86_64 GNU/Linux
>> ...
>>> Okay, enough background. Here's the issue: I had no trouble building
>>> and sync'ing the first array, but when I try to sync the second array,
>>> I always get the following dmesg an hour or so into the process:
>>>
>>> irq 19: nobody cared (try booting with the "irqpoll" option)
>>> [  346.120572] Pid: 1100, comm: md1_resync Not tainted
>> 3.2.0-0.bpo.2-amd64 #1
>>> [  346.120573] Call Trace:
>>> ...
>>> [  346.120697] handlers:
>>> [  346.120699] [<ffffffffa00479e0>] ahci_interrupt
>>> [  346.120702] [<ffffffffa02f17ec>] sil_interrupt
>>> [  346.120703] Disabling IRQ #19
>>> [  346.122145] sched: RT throttling activated
>> ...
>>> From this point onward syncing drops to a tiny fraction of its
>>> previous speed. I've tried booting with 'irqpoll' as the error message
>>> suggests, but it has had no effect. I'm really not sure if there is a
>>> conflict between my two SiI3114's or between the SiI's and the Marvell
>>> controller (although I've never had an issue with Marvell in the
>>> past), nor how to go about diagnosing or fixing this.  I'll include a
>>> full dmesg dump below, as well as my currently loaded modules. If
>>> anyone wants any further info, just ask.
>>
>> Have you tried irqbalance to spread the interrupts across cores/cache
>> domains? https://irqbalance.org/documentation.html
>>
>
> Thanks for the tip! I installed irqbalance and rebooted the system,
> and everything has been running smoothly for the last two hours. I'll
> let everyone know tomorrow if it actually finished the full 20-hour
> resync without incidence.
>
>
> --
> Stirling Westrup
> Programmer, Entrepreneur.
> https://www.linkedin.com/e/fpf/77228
> http://www.linkedin.com/in/swestrup
> http://technaut.livejournal.com
> http://sourceforge.net/users/stirlingwestrup

Alas, all it did was delay the IRQ error by a few hours. Does anyone
else have any ideas about how I could tackle this?

-- 
Stirling Westrup
Programmer, Entrepreneur.
https://www.linkedin.com/e/fpf/77228
http://www.linkedin.com/in/swestrup
http://technaut.livejournal.com
http://sourceforge.net/users/stirlingwestrup
