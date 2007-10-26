From: Tejun Heo <htejun@gmail.com>
Subject: Re: marvell 88SX6081 and linux 2.6.23.1
Date: Fri, 26 Oct 2007 12:23:21 +0900
Message-ID: <47215DA9.7070403@gmail.com>
References: <S1756649AbXJMTC2/20071013190228Z+1695@xvger.kernel.org> <47214B40.5020408@gmail.com> <20071026030440.PKWW29317.mta9.adelphia.net@dual-xeon.jeffunit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:57188 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbXJZDX3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 23:23:29 -0400
Received: by rv-out-0910.google.com with SMTP id k20so664066rvb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 20:23:28 -0700 (PDT)
In-Reply-To: <20071026030440.PKWW29317.mta9.adelphia.net@dual-xeon.jeffunit.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeffunit <jeff@jeffunit.com>
Cc: linux-ide@vger.kernel.org

jeffunit wrote:
> 
>> jeffunit wrote:
>> > I built a kernel, 2.6.23.1 today.
>> > My motherboard is an intel stl2, dual pentium 933 motherboard, with
>> > about 3gb of ram.
>> > I also have a promise tx100 controller with an ata hard drive for the
>> > os, and a sony dvdrw drive.
>> > There is an intel gigabit ethernet card, and an ati pci video card.
>> >
>> > I have an 8 port supermicro sata II controller with the marvell
>> > 888SX6081 chipset.
>> > I have four 500gb sata II maxtor hard drives attached to it.
>> >
>> > All except /dev/sda1 seem to work fine.
>> > When I copy/modify files on /dev/sda1, I get the following dmesg
>> errors:
>> >
>> > The machine is designed to be a fileserver, but I am happy to help
>> debug
>> > this issue to the best
>> > of my abilities.
>> >
>> > When I boot windows xp, xp sees all 4 of the sata drives, and they work
>> > without any problems.
>> >
>> > Please advise,
>> > jeff
>> >
>> > ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> > ata1.00: edma_err 0x00000084, EDMA self-disable
>> > ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data
>> 4096 in
>> >          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media
>> error)
>>
>> Media errors which is usually localized to certain area of disk.
>> Replace disk.
> 
> The disk works fine under windows xp. I never got any errors with it and
> xp.

And you were accessing the same region of the drive?

> I can swap the first and second hard drive.
> With the old kernel, the errors stayed with whatever drive was hooked up to
> the first port of the controller. I will report the results.

Hmmm... Yes please.  Also, please report the result of "smartctl -a
/dev/sda".

-- 
tejun
