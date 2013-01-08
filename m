From: bl0 <bl0-052@playker.info>
Subject: Re: sata_sil data corruption, possible workarounds
Date: Tue, 08 Jan 2013 13:25:30 +0100
Message-ID: <kch37o$77s$1@ger.gmane.org>
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com> <kakea2$dh1$1@ger.gmane.org> <50CEB13B.9010100@gmail.com> <kaq1n6$hqa$1@ger.gmane.org> <50D13831.9040105@gmail.com> <kaujmk$op$1@ger.gmane.org> <50EA4AEE.1050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42818 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755981Ab3AHMZs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Jan 2013 07:25:48 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1TsYFj-0002LP-32
	for linux-ide@vger.kernel.org; Tue, 08 Jan 2013 13:25:59 +0100
Received: from 91.150.147.9.internetia.net.pl ([91.150.147.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2013 13:25:59 +0100
Received: from bl0-052 by 91.150.147.9.internetia.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2013 13:25:59 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-pci@vger.kernel.org

On Monday 07 January 2013 05:11, Robert Hancock wrote:

> On 12/20/2012 02:54 AM, bl0 wrote:
>> On Wednesday 19 December 2012 04:44, Robert Hancock wrote:
>>
>>> On 12/18/2012 09:23 AM, bl0 wrote:
>>>> Do you think something should be done about it in the linux sata_sil
>>>> driver? For a lack of a better solution, here is my suggestion. There
>>>> is already one option 'slow_down' for problematic disks. Another
>>>> option, for example 'cache_line_workaround', could be added for
>>>> problematic motherboards. If enabled, the most straightforward way is
>>>> to set cache line size to 0 and not worry about the fifo_cfg register.
>>>> If someone else confirms that it solves the problem for them, this
>>>> option could be enabled automatically if certain motherboard chipset is
>>>> detected.
>>>
>>> We'd have to somehow narrow down which chipsets were involved, which
>>> might be a hard task. Do you have an idea of how much the performance is
>>> hurt by these workarounds? If it's not a lot, it might make sense to do
>>> it by default.
>>
>> After setting cache line size to 0, write speed as shown by 'dd
>> if=/tmpfs/testfile of=/dev/sdc9 bs=1M count=256' goes down from about
>> 45 MB/s to 17 MB/s. Personally I don't care about performance,
>> reliability and data safety are more important to me.
> 
> Yeah, cutting performance by 2/3rds is fairly bad though.

Yes, it's probably not a good thing to do by default for everyone.

>> The other workaround is to increase cache line size to 64 bytes, if
>> necessary, and set fifo_cfg to 0. No difference in performance measured.
>> This workaround is more of a hit or miss. It seems to contradict that
>> code commit made back in 2005, which was also about data corruption. In
>> the worst case, what solves data corruption problem on some motherboards
>> might introduce this problem on some other motherboards.
> 
> That's possible, which is why I suspect that someone from Silicon Image
> would have to confirm a possible fix - might be hard to get their
> attention about this old chipset..

I still recommend, for a start, a kernel module option, along with a message
in dmesg. (If you haven't seen it yet, the code diff in my last message
shows a possible way to do this.)


