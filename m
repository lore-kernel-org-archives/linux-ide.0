From: Tejun Heo <tj@kernel.org>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Mon, 23 Mar 2009 01:41:08 +0900
Message-ID: <49C66A24.5000804@kernel.org>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org> <49C63457.8040203@gmail.com> <49C6547E.5050005@kernel.org> <49C6623D.7080305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59850 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbZCVQkk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Mar 2009 12:40:40 -0400
In-Reply-To: <49C6623D.7080305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?= <vladimir.dashevsky@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

=F7=CC=C1=C4=C9=CD=C9=D2 =E4=C1=DB=C5=D7=D3=CB=C9=CA wrote:
>> Not all EMIs are one-shot events.  Some can span seconds.  Links don=
't
>> always come up right after failures.  Sometimes they require more th=
an
>> one hardresets to get back to working order.  Link status report is
>> not reliable.  Sometimes they report offline for a while after certa=
in
>> events.  If you know how to work around the above problems under a
>> second, I'm all ears but I doubt it unless it involves an additional
>> mechanical switch.
>>  =20
> Well, for example, USB devices have a pull-up resistor on their D+ li=
ne.
> DC bias can be used for detection of device presence without mechanic=
al
> switch.

SATA is not USB and onlineness detection isn't that simple.  Also,
have you tried to run a system on a USB device over flaky connection?

>> The echo to delete node is synchronous.  It will return after the
>> device is completely removed but please note that "removing" in this
>> sense only covers the device itself.  It will flush the request queu=
e
>> and spin the drive down but won't do anything about filesystems.  Yo=
u
>> need to unmount first.  hal and desktop stuff already do the right
>> thing for devices marked removable.
>>  =20
> Ok, but two more questions:
> 1. Is there any generic mechanism of notifiing processes which had
> previously opened device being deleted of this event? What will happe=
n
> to such processes? Is it possible to check who are those who uses the
> drive at the moment?

-EIO will happen, fuser, but if you want something intelligent, hal +
dbus.

> 2. If the drive was deleted is it possible to start it back without
> physical re-connection? Can I simulate status change og that port to
> force the driver to auto-detect block device?

I don't really follow what you're trying to achieve but if you want
some fancy snapshotting + remapping trick, the best place would be dm.

> PS: as for this:
>> I'll be happy to improve EH behavior but you need to come up with
>> better reasons.
>>  =20
> I can tell that for me enclosure management support is quite a good
> reason.

How is that in any way exclusive against longer detach delay?

> Unfortunately, there is no this support in official kernel. I have
> seen only limited support of activity LED in kernel 2.6.28.
> However, I am using Debian where the latest kernel is only
> 2.6.26. As a result I had to write a simple ahci_em module which
> register simple proc interface to send LED states to all ICH9
> ports. However, final goal is to integrate this module with mdadm to
> have proper indication of RAID state.

The biggest obstacle is that there aren't too many enclosure devices
floating around.  What kind of device are you using?

--=20
tejun
