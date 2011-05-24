From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] Start of removal of legacy parallel interfaces for 3.0
Date: Tue, 24 May 2011 21:39:17 +0200
Message-ID: <BANLkTi=xZmaMyzjcKv5_YiTavAvVRTPYiw@mail.gmail.com>
References: <4DDBF40E.7020003@fusionio.com>
	<BANLkTi=sYVpvEwShbhC65qfaA0Jt3rEjsQ@mail.gmail.com>
	<4DDBFC30.6030201@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60821 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1EXTjT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 May 2011 15:39:19 -0400
In-Reply-To: <4DDBFC30.6030201@fusionio.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, David Miller <davem@davemloft.net>, Chris Mason <chris.mason@oracle.com>

On Tue, May 24, 2011 at 20:42, Jens Axboe <jaxboe@fusionio.com> wrote:
> On 2011-05-24 20:37, Linus Torvalds wrote:
>> On Tue, May 24, 2011 at 11:08 AM, Jens Axboe <jaxboe@fusionio.com> w=
rote:
>>> With the 3.0 kernel approaching, now is a great time to get rid of =
some
>>> legacy bagage. And what better part to start with than the old IDE =
code.
>>> Parallel interfaces are so 1990's, we can't be seen with those on a
>>> fancy new kernel version.

NAK.

>> No.
>>
>> Guys. Really.
>>
>> Any version numbering change is *not* an excuse to drop any old stuf=
f,
>> or do anything new and exciting.
>
> Boy, you guys sure are humorless. I would've thought the reference to
> killing SCSI next would be a good clue.
>
> So we can't kill x86 32-bit either?

I wouldn't object to that one. Finally a good reason to kick admins
who still run
32-bit distros on 64-bit machines ;-)

Serious... Rumor says there's even a new 32-bit ABI for x86...

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
