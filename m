From: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?=
	<vladimir.dashevsky@gmail.com>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Sun, 22 Mar 2009 21:26:21 +0300
Message-ID: <49C682CD.9010007@gmail.com>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org> <49C63457.8040203@gmail.com> <49C6547E.5050005@kernel.org> <49C6623D.7080305@gmail.com> <49C66A24.5000804@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:4557 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbZCVS2O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Mar 2009 14:28:14 -0400
Received: by ey-out-2122.google.com with SMTP id 4so434078eyf.37
        for <linux-ide@vger.kernel.org>; Sun, 22 Mar 2009 11:28:11 -0700 (PDT)
In-Reply-To: <49C66A24.5000804@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun!
> =F7=CC=C1=C4=C9=CD=C9=D2 =E4=C1=DB=C5=D7=D3=CB=C9=CA wrote:
>  =20
>>> Not all EMIs are one-shot events.  Some can span seconds.  Links do=
n't
>>> always come up right after failures.  Sometimes they require more t=
han
>>> one hardresets to get back to working order.  Link status report is
>>> not reliable.  Sometimes they report offline for a while after cert=
ain
>>> events.  If you know how to work around the above problems under a
>>> second, I'm all ears but I doubt it unless it involves an additiona=
l
>>> mechanical switch.
>>>  =20
>>>      =20
>> Well, for example, USB devices have a pull-up resistor on their D+ l=
ine.
>> DC bias can be used for detection of device presence without mechani=
cal
>> switch.
>>    =20
>
> SATA is not USB and onlineness detection isn't that simple.  Also,
> have you tried to run a system on a USB device over flaky connection?
>  =20
Well, I cannot argue with you here. All that I wanted to say is that I=20
would prefer more optimistic software behavior if the hardware really=20
supports device connection status.
>>> The echo to delete node is synchronous.  It will return after the
>>> device is completely removed but please note that "removing" in thi=
s
>>> sense only covers the device itself.  It will flush the request que=
ue
>>> and spin the drive down but won't do anything about filesystems.  Y=
ou
>>> need to unmount first.  hal and desktop stuff already do the right
>>> thing for devices marked removable.
>>>  =20
>>>      =20
>> Ok, but two more questions:
>> 1. Is there any generic mechanism of notifiing processes which had
>> previously opened device being deleted of this event? What will happ=
en
>> to such processes? Is it possible to check who are those who uses th=
e
>> drive at the moment?
>>    =20
>
> -EIO will happen, fuser, but if you want something intelligent, hal +
> dbus.
>  =20
Sorry, I missed the sense of this sentence. I tried this deletion with=20
fdisk and see that fdisk does not even comply for device failure. It=20
just starts to print empty partition table and so on. So the question i=
s=20
how to properly close any activity concerned with device being deleted=20
if I do not know exactly what is that activity? Are the most typical=20
programs which are allowed to use raw block devices aware of unexpected=
=20
block device loss?

>> 2. If the drive was deleted is it possible to start it back without
>> physical re-connection? Can I simulate status change og that port to
>> force the driver to auto-detect block device?
>>    =20
>
> I don't really follow what you're trying to achieve but if you want
> some fancy snapshotting + remapping trick, the best place would be dm=
=2E
>  =20
Well, I didn't think of any tricks. I just deleted the drive as you=20
taught me and tried to get it back without moving myself in front of th=
e=20
server. :-)
However, I think that some call to rescan scsi devices will be useful.
>  =20
>> PS: as for this:
>>    =20
>>> I'll be happy to improve EH behavior but you need to come up with
>>> better reasons. =20
>>>      =20
>> I can tell that for me enclosure management support is quite a good
>> reason.
>>    =20
>
> How is that in any way exclusive against longer detach delay?
>  =20
I just answered with better reasons to make you happy, not with another=
=20
advice of detach delay.
>  =20
>> Unfortunately, there is no this support in official kernel. I have
>> seen only limited support of activity LED in kernel 2.6.28.
>> However, I am using Debian where the latest kernel is only
>> 2.6.26. As a result I had to write a simple ahci_em module which
>> register simple proc interface to send LED states to all ICH9
>> ports. However, final goal is to integrate this module with mdadm to
>> have proper indication of RAID state.
>>    =20
>
> The biggest obstacle is that there aren't too many enclosure devices
> floating around.  What kind of device are you using?
>  =20
I don't know exactly what device are you talking about. I was talking=20
about LED message types that are supported in ICH9.
As for my server, ICH9 provides SGPIO interface that is routed to=20
4-drive hot-swap backplane based on AMI MG9071 chip. However, this=20
information isn't needed to program ICH9 since the LED message mechanis=
m=20
is supported in it. Other message types are not supported. And it is=20
very strange that linux ahci still does not support this functionality=20
since it was first introduced in ICH8 (datasheet first release in June=20
of 2006).

PS: My code has about 11Kb of text and supports all useful RAID states:=
=20
NORMAL, LOCATE, REBUILD, FAILURE, HOTSPARE, PREDICTED FAILURE SOON. I=20
have tested in on my server and it works. I think it can be useful for=20
other implementations of soft RAID systems with hat swap support.

Best regards, Vladimir Dashevsky

