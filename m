From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Disk shock protection interferes with standby timers, please advise
Date: Fri, 09 May 2014 09:07:18 +0200
Message-ID: <87oaz74ehl.fsf@denkblock.local>
References: <876214glvz.fsf@denkblock.local> <20140503212115.GA29213@nomi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.nebensachen.de ([5.45.99.250]:57002 "EHLO
	mail.nebensachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaEIHPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 May 2014 03:15:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-15?Q?Tom=E1=A8_Janou=A8ek?= <tomi@nomi.cz>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Aaron Lu <aaron.lu@intel.com>, linux-ide@vger.kernel.org

On 03 May 2014, Tom=C3=A1=C5=A1 Janou=C5=A1ek wrote:
> Hi,
> On Thu, Mar 07, 2013 at 12:16:00AM +0100, Elias Oltmanns wrote:
>> On the other hand,
>>=20
>> # hdparm -I /dev/sda
>>=20
>> also reenables the standby timer yet leaves the heads alone. So my
>> question is this: Can anyone give some advice as to what command wha=
t be
>> suitable to be issued instead of Idle Immediate when the shock
>> protection timeout has elapsed? Basically, it should be cheap, cause=
 no
>> =E2=80=9Cmechanical action=E2=80=9D, and be anything *but* Check Pow=
er Mode.
>=20
> Well, it does not reenable the standby timer on my ST9500420AS drive,=
 so that
> isn't a universal solution either.  And since so few people care abou=
t this
> problem, this doesn't seem to be worth a quirk database or something =
like
> that.  I'll just keep applying the patch, then.  :-)

It might be an idea to raise this issue with Peter FP Zhang from Lenovo
who is actively participating in discussions on the linux thinkpad
mailing list. May be, he can ask the right people what command sequence
is used by the Windows driver on those newer machines, but then, may be
not. Unfortunately, I haven't got the resources to follow up on this
right now.

Regards,

Elias
