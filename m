From: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?=
	<vladimir.dashevsky@gmail.com>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Sun, 22 Mar 2009 19:07:25 +0300
Message-ID: <49C6623D.7080305@gmail.com>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org> <49C63457.8040203@gmail.com> <49C6547E.5050005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:48760 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbZCVQJR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Mar 2009 12:09:17 -0400
Received: by ey-out-2122.google.com with SMTP id 4so423262eyf.37
        for <linux-ide@vger.kernel.org>; Sun, 22 Mar 2009 09:09:14 -0700 (PDT)
In-Reply-To: <49C6547E.5050005@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun!

Tejun Heo =D0=C9=DB=C5=D4:
>> I think you are not right here. If we are talking about EMI problems=
 I
>> can say that the strategy of many retries is worse than one read of =
port
>> present status. EMI noise occurs at the time while software tries to
>> re-establish connection with empty link because there is no link
>> terminatiion. It's just like a car engine that has lost its muffler.=
 It
>> produces lots of noise. It is better to turn the link off as soon as=
 we
>> know there is no device on the port. That's why retries should last =
only
>> until that state is reported by hardware. And I think hardware repor=
ts
>> that state much faster than in 15 or even 5 seconds. In ICH9 it repo=
rts
>> this just immediately.
>>    =20
>
> Not all EMIs are one-shot events.  Some can span seconds.  Links don'=
t
> always come up right after failures.  Sometimes they require more tha=
n
> one hardresets to get back to working order.  Link status report is
> not reliable.  Sometimes they report offline for a while after certai=
n
> events.  If you know how to work around the above problems under a
> second, I'm all ears but I doubt it unless it involves an additional
> mechanical switch.
>  =20
Well, for example, USB devices have a pull-up resistor on their D+ line=
=2E=20
DC bias can be used for detection of device presence without mechanical=
=20
switch.

> I don't know of a practical downside to lingering for limited amount
> of time.  If you know one, please let me know.
>
>  =20
Ok.

>> Ok. So, one more question. How can I know exactly when device deleti=
on
>> has completed after sending this command? For example, consider that
>> there some data in cache that needs 3 seconds to be sync-ed to disk.=
 How
>> can I know that I must wait for 3 seconds before a can actually remo=
ve
>> the drive? Should I check the presence of some other filename in
>> /sys/block/sdX/ or do something else?
>>    =20
>
> The echo to delete node is synchronous.  It will return after the
> device is completely removed but please note that "removing" in this
> sense only covers the device itself.  It will flush the request queue
> and spin the drive down but won't do anything about filesystems.  You
> need to unmount first.  hal and desktop stuff already do the right
> thing for devices marked removable.
>
>  =20
Ok, but two more questions:
1. Is there any generic mechanism of notifiing processes which had=20
previously opened device being deleted of this event? What will happen=20
to such processes? Is it possible to check who are those who uses the=20
drive at the moment?
2. If the drive was deleted is it possible to start it back without=20
physical re-connection? Can I simulate status change og that port to=20
force the driver to auto-detect block device?


PS: as for this:
> I'll be happy to improve EH behavior but you need to come up with bet=
ter reasons.
>  =20
I can tell that for me enclosure management support is quite a good=20
reason. Unfortunately, there is no this support in official kernel. I=20
have seen only limited support of activity LED in kernel 2.6.28.=20
However, I am using Debian where the latest kernel is only 2.6.26. As a=
=20
result I had to write a simple ahci_em module which register simple pro=
c=20
interface to send LED states to all ICH9 ports. However, final goal is=20
to integrate this module with mdadm to have proper indication of RAID s=
tate.

Best regards, Vladimir Dashevsky



