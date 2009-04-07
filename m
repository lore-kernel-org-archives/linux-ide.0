From: =?UTF-8?B?0JTQsNC90LjQu9CwINCW0YPQutC+0YbQutC40Lk=?=
	<optimusgd@gmail.com>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Tue, 7 Apr 2009 10:05:25 +0500
Message-ID: <db2b43030904062205q283f64fal395e61f985a8108b@mail.gmail.com>
References: <bug-13001-10286@http.bugzilla.kernel.org/>
	 <20090404114559.ce20eb9c.akpm@linux-foundation.org>
	 <20090406234816.05242d4e@lxorguk.ukuu.org.uk>
	 <20090407104905Q.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59015 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZDGFF2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 01:05:28 -0400
Received: by fxm2 with SMTP id 2so2156996fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 06 Apr 2009 22:05:26 -0700 (PDT)
In-Reply-To: <20090407104905Q.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, x86@kernel.org

I can't turn on CONFIG_IOMMU_LEAK and CONFIG_IOMMU_DEBUG because
2.6.26.1 not have such options in .config. Maybe git kernel have this
options? Bug triggered when i try mount sata drive on sata_nv and usb
hdd on echi_hcd. In all other cases i have no problem.

Also i have mysterious problem similar to
http://lkml.org/lkml/2009/1/11/302 . It prevent me return to normally
working before 2.6.28 kernel. Once boot 2.6.29 and found DMA bug i'm
reboot to old working 2.6.28 and seen that my eth0 and eth1 forcedetch
died with "no link during initialization". Restart interfaces, remove
insert module don't help.
I'm not change configs, i'm not rebuild old kernel. I'm not touch it
at all. Reboot to 2.6.29 and network work. Cold restart won't help,
and i not won't reset BIOS. I looked to dmesg 2.6.28 and seen that
irqs for forcedetch look different from other 2.6.28 kernel dmesgs.
So 2.6.29 do strange things with my machine, and that things live cold
restart. I don't know what happens, i can't understand and can't open
case and hardreset bios all time when i want return to old working
kernel. Can you explain me what wrong?

2009/4/7 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>:
> On Mon, 6 Apr 2009 23:48:16 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
>> > > Mar 31 20:59:01 rngmhpamd end_request: I/O error, dev sdc, sector 1137
>> > > Mar 31 20:59:01 rngmhpamd __ratelimit: 246 callbacks suppressed
>> >
>> > Do we have any debugging option for dumping the current PCI DMA
>> > allocations, find out where it has all gone?
>>
>> Turn on CONFIG_IOMMU_LEAK and CONFIG_IOMMU_DEBUG for a test run.
>
> These options don't tell who leaks dma mappings so possibly it isn't
> very helpful.
>
> There is no interesting changes in GART IOMMU between 2.6.28 and
> 2.6.29 so probably this is a driver bug. It's necessary to find out
> which driver leaks dma mappings.
>
