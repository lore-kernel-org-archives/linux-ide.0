From: Tejun Heo <tj@kernel.org>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Mon, 23 Mar 2009 11:04:57 +0900
Message-ID: <49C6EE49.9080307@kernel.org>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org> <49C63457.8040203@gmail.com> <49C6547E.5050005@kernel.org> <49C6623D.7080305@gmail.com> <49C66A24.5000804@kernel.org> <49C682CD.9010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34228 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbZCWCFH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Mar 2009 22:05:07 -0400
In-Reply-To: <49C682CD.9010007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?= <vladimir.dashevsky@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

=F7=CC=C1=C4=C9=CD=C9=D2 =E4=C1=DB=C5=D7=D3=CB=C9=CA wrote:
>>> Well, for example, USB devices have a pull-up resistor on their D+ =
line.
>>> DC bias can be used for detection of device presence without mechan=
ical
>>> switch.
>>
>> SATA is not USB and onlineness detection isn't that simple.  Also,
>> have you tried to run a system on a USB device over flaky connection=
?
>>  =20
> Well, I cannot argue with you here. All that I wanted to say is that =
I
> would prefer more optimistic software behavior if the hardware really
> supports device connection status.

I really don't follow your train of thoughts here.  Are you saying
that the driver should be optimistic about the reliability about
status reported by the hardware even when it is inherently imprecise
(please read the spec) and real world experiments prove that?

>>> Ok, but two more questions:
>>> 1. Is there any generic mechanism of notifiing processes which had
>>> previously opened device being deleted of this event? What will hap=
pen
>>> to such processes? Is it possible to check who are those who uses t=
he
>>> drive at the moment?
>>>    =20
>>
>> -EIO will happen, fuser, but if you want something intelligent, hal =
+
>> dbus.
>>  =20
> Sorry, I missed the sense of this sentence.

-EIO will happen to any processes trying to do IO on the removed
device.  fuser will find out who's using the block device but if you
want something more intelligent, look at hal + dbus.

> I tried this deletion with fdisk and see that fdisk does not even
> comply for device failure. It just starts to print empty partition
> table and so on. So the question is how to properly close any
> activity concerned with device being deleted if I do not know
> exactly what is that activity? Are the most typical programs which
> are allowed to use raw block devices aware of unexpected block
> device loss?

Please take a look at how desktop guys are handling the issue.  It's
not something which can be handled in kernel proper.

>> I don't really follow what you're trying to achieve but if you want
>> some fancy snapshotting + remapping trick, the best place would be d=
m.
>>  =20
> Well, I didn't think of any tricks. I just deleted the drive as you
> taught me and tried to get it back without moving myself in front of =
the
> server. :-)
> However, I think that some call to rescan scsi devices will be useful=
=2E

Ah.. in that case, you can do

 # echo - - - > /sys/class/scsi_host/hostN/scan

>>>> I'll be happy to improve EH behavior but you need to come up with
>>>> better reasons.       =20
>>> I can tell that for me enclosure management support is quite a good
>>> reason.
>>>    =20
>>
>> How is that in any way exclusive against longer detach delay?
>
> I just answered with better reasons to make you happy, not with anoth=
er
> advice of detach delay.

Well, I was asking for better reasons to change the detach delay.

>> The biggest obstacle is that there aren't too many enclosure devices
>> floating around.  What kind of device are you using?
>>  =20
> I don't know exactly what device are you talking about. I was talking
> about LED message types that are supported in ICH9.
> As for my server, ICH9 provides SGPIO interface that is routed to
> 4-drive hot-swap backplane based on AMI MG9071 chip. However, this
> information isn't needed to program ICH9 since the LED message mechan=
ism
> is supported in it. Other message types are not supported. And it is
> very strange that linux ahci still does not support this functionalit=
y
> since it was first introduced in ICH8 (datasheet first release in Jun=
e
> of 2006).

Yeah, I know it has been in the spec but without hardware to play with
it's difficult to add driver features and lack of general availability
also means lower demand.

> PS: My code has about 11Kb of text and supports all useful RAID state=
s:
> NORMAL, LOCATE, REBUILD, FAILURE, HOTSPARE, PREDICTED FAILURE SOON. I
> have tested in on my server and it works. I think it can be useful fo=
r
> other implementations of soft RAID systems with hat swap support.

I think it should be independent from RAID but having general
enclosure support will be nice.  Care to post the patches?

Thanks.

--=20
tejun
