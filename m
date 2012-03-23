From: "ANEZAKI, Akira" <fireblade1230@yahoo.co.jp>
Subject: Re: Fwd: libata-pmp patch for 3.2.x and later for eSATA Port Multiplier
 Sil3726
Date: Fri, 23 Mar 2012 15:40:37 +0900
Message-ID: <4F6C1AE5.5060405@yahoo.co.jp>
References: <4F5ECD06.3000608@yahoo.co.jp> <4F5F7C4C.7080800@teksavvy.com> <4F662AFB.9050106@yahoo.co.jp> <CAMHSBOWg+rxxrVjf05r1tYDpW1S75XzdrLQ+U8TrjC9okRYtuA@mail.gmail.com> <4F6AAC37.7040907@yahoo.co.jp> <4F6B30D9.2070805@yahoo.co.jp> <CAMHSBOVD4wAtwAravVkDjyWV+Nwtuybt=yae=26PcGxxirw=Lg@mail.gmail.com> <4F6B679C.60004@yahoo.co.jp> <CAMHSBOWDYyLRREZNGqhBtvF_gSrvB-b=PVx3qULCqpc7yeJCcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta103.odn.ne.jp ([143.90.14.143]:59446 "EHLO cmta103.odn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667Ab2CWGkk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Mar 2012 02:40:40 -0400
Received: from smta103.odn.ne.jp by cmta103.odn.ne.jp with ESMTP
          id <20120323064038651.OBEX.1690.cmta103.odn.ne.jp@mta103.odn.ne.jp>
          for <linux-ide@vger.kernel.org>; Fri, 23 Mar 2012 15:40:38 +0900
In-Reply-To: <CAMHSBOWDYyLRREZNGqhBtvF_gSrvB-b=PVx3qULCqpc7yeJCcQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: "ANEZAKI, Akira" <fireblade1230@yahoo.co.jp>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello Gwendal,

(2012/03/23 14:14), Gwendal Grignou wrote:
> On Fri, Mar 23, 2012 at 1:55 AM, ANEZAKI, Akira
> <fireblade1230@yahoo.co.jp> wrote:
>> Hello Gwendal,
>>
>> Thank you for your information.
>> I think ata8 might different from other 3 PMPs. I'll try to update all
>> firmware but it is running resync on broken RAID now. So I can't do it soon.
>> By the way, both of ata8 and ata9 loses some HDDs also. Are those
>> affected by PMPs on ata7 and ata10? Why 3.1.x driver can work?
>>
>> Best Regards,
>> Akira
>>
>>> Now I see your problem. Indeed on ata7, ata10, we have a problem.
> I should have said ata7-ata10. The PMP on these 4 enclosures do not
> like SRST at all.
> It works with 3.1.x because it does not send SRST with this PMP; but
> as I said before, that is not a good behavior [no staggered spin-up,
> problem with drives slow to spin-up]

You pointd out about power consumption, but I think most of SiI3726 are
used in HDD boxes. If no staggered sign-up causes some voltage drop, it
will affect only in HDD box, perhaps it is 12V power line drop. SiI3726
will use 5V power line with regulator (IO = 3.3V, core=1.8V) so
influence will be small.
Whether send SRST or not, no HDDs are linked up at that time and it must
wait for a while with repeating hard reset. Current behavior is "try 3
times and ignore". If the behavior is changed to "try 4 times and
ignore", the behavior of most HDD box wont be changed because all HDDs
are linked up before 4th try. For users who has slow spin-up HDDs, they
get more some seconds. I think it is convenient for most users and
easier than trace/fix my problem. Of course the solution that solves my
problem with SRST is best!

> Gwendal.
>>> I notice however some messages I did not see before:
>>>>> [    4.856382] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
>>>>> [    4.858742] ata7.00: hard resetting link
>>>>> [   14.843039] ata7.00: softreset failed (timeout)
>>>>> [   17.836402] ata7.15: qc timeout (cmd 0xe4)
>>> The later indicates that the PMP is stuck and the host can not read
>>> its internal register.
>>> Is it possible that the PMP in these 4 enclosures you are using have a
>>> different firmware than the other ones?
>>> Firmware 1.0114 is available at:
>>> http://www.siliconimage.com/support/searchresults.aspx?pid=26&cat=23
>>>
>>> From the release notes:
>>> """- Fix SRST and initial two RegFIS Problem."""

I'm still fixing broken RAID. Sorry for my slow response.

Best Regards,
Akira
