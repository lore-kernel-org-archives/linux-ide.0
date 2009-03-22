From: Tejun Heo <tj@kernel.org>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Mon, 23 Mar 2009 00:08:46 +0900
Message-ID: <49C6547E.5050005@kernel.org>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org> <49C63457.8040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38381 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbZCVPIX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Mar 2009 11:08:23 -0400
In-Reply-To: <49C63457.8040203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?= <vladimir.dashevsky@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

=F7=CC=C1=C4=C9=CD=C9=D2 =E4=C1=DB=C5=D7=D3=CB=C9=CA wrote:
> I think you are not right here. If we are talking about EMI problems =
I
> can say that the strategy of many retries is worse than one read of p=
ort
> present status. EMI noise occurs at the time while software tries to
> re-establish connection with empty link because there is no link
> terminatiion. It's just like a car engine that has lost its muffler. =
It
> produces lots of noise. It is better to turn the link off as soon as =
we
> know there is no device on the port. That's why retries should last o=
nly
> until that state is reported by hardware. And I think hardware report=
s
> that state much faster than in 15 or even 5 seconds. In ICH9 it repor=
ts
> this just immediately.

Not all EMIs are one-shot events.  Some can span seconds.  Links don't
always come up right after failures.  Sometimes they require more than
one hardresets to get back to working order.  Link status report is
not reliable.  Sometimes they report offline for a while after certain
events.  If you know how to work around the above problems under a
second, I'm all ears but I doubt it unless it involves an additional
mechanical switch.

I don't know of a practical downside to lingering for limited amount
of time.  If you know one, please let me know.

>> If you hot unplug, how do you notify SCSI driver first?
>>  =20
> Well, there are some strange comments in FAQs that older ICH chips (5=
 to
> 8) do not fully support hot plug, while the newer ones have better
> support for this. Then there is an explanation of what is proper hotp=
lug
> support. That explanation says of surprise-removal support. However, =
I
> do not mind of notifying system before a actually remove the drive. J=
ust
> because it may take a long time to shut down drive activity and it wi=
ll
> be better to indicate this explicitly to user.

If you sync and spin down the drive before hot unplugging, there's no
practical difference.  If you do a surprise hot-unplug, whatever was
on the buffer will be lost and the drive will have to do an emergency
unload.

>> The goal is being robust.  With numerous hardware combinations, that=
's
>> about the only way to keep things manageable.  Things don't always
>> work as described in the spec.  Again, the only down side is one or
>> more failed attempts and log about those.  Why do you care?
>>  =20
> It's just because one of my jobs is writing high performance embedded
> real-time software were logs are almost the only way to know what
> happens in hardware. After  several years of  such practice there is =
a
> habit of suspecting side effects of each stralge log line. That's wha=
y I
> do care :-)
> I just want to understand that this softreset failure is a normal
> behavior for that particular case.

Yes, they're expected.  If you really don't like those messages, feel
free to comment them out in your tree but please stop obsessing over
the messages.  I'll be happy to improve EH behavior but you need to
come up with better reasons.

>> ahci doesn't use PCS to detect dummy ports.  It uses PORT_IMPL ahci
>> register.  If PORT_IMPL changes according to which ports are occupie=
d
>> that's a BIOS bug.  Can you post the output of "dmidecode"?
>>  =20
> Yes, you were right, it was a BIOS bug. I have downloaded latest BIOS
> from the vendor's web site and now PI register allways reports all si=
x
> ports implemented.

Great.  :-)

> Ok. So, one more question. How can I know exactly when device deletio=
n
> has completed after sending this command? For example, consider that
> there some data in cache that needs 3 seconds to be sync-ed to disk. =
How
> can I know that I must wait for 3 seconds before a can actually remov=
e
> the drive? Should I check the presence of some other filename in
> /sys/block/sdX/ or do something else?

The echo to delete node is synchronous.  It will return after the
device is completely removed but please note that "removing" in this
sense only covers the device itself.  It will flush the request queue
and spin the drive down but won't do anything about filesystems.  You
need to unmount first.  hal and desktop stuff already do the right
thing for devices marked removable.

Thanks.

--=20
tejun
