From: =?utf-8?B?VG9tw6HFoSBKYW5vdcWhZWs=?= <tomi@nomi.cz>
Subject: Re: Disk shock protection interferes with standby timers, please
	advise
Date: Sat, 3 May 2014 23:21:15 +0200
Message-ID: <20140503212115.GA29213@nomi.cz>
References: <876214glvz.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ackle.nomi.cz ([81.31.33.35]:42021 "EHLO ackle.nomi.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbaECVqs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 May 2014 17:46:48 -0400
Content-Disposition: inline
In-Reply-To: <876214glvz.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Aaron Lu <aaron.lu@intel.com>, linux-ide@vger.kernel.org

Hi,

On Thu, Mar 07, 2013 at 12:16:00AM +0100, Elias Oltmanns wrote:
> On the other hand,
>=20
> # hdparm -I /dev/sda
>=20
> also reenables the standby timer yet leaves the heads alone. So my
> question is this: Can anyone give some advice as to what command what=
 be
> suitable to be issued instead of Idle Immediate when the shock
> protection timeout has elapsed? Basically, it should be cheap, cause =
no
> =E2=80=9Cmechanical action=E2=80=9D, and be anything *but* Check Powe=
r Mode.

Well, it does not reenable the standby timer on my ST9500420AS drive, s=
o that
isn't a universal solution either.  And since so few people care about =
this
problem, this doesn't seem to be worth a quirk database or something li=
ke
that.  I'll just keep applying the patch, then.  :-)

Regards,
--=20
Tom=C3=A1=C5=A1 Janou=C5=A1ek, a.k.a. Liskni_si, http://work.lisk.in/
