From: Tom Denchfield <td_denchfield@yahoo.com>
Subject: Re: CF Card Adapter White List Candidate
Date: Sat, 8 Jan 2011 14:18:12 -0800 (PST)
Message-ID: <466091.67419.qm@web112006.mail.gq1.yahoo.com>
References: <4D2840F5.10907@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm5.bullet.mail.sp2.yahoo.com ([98.139.91.75]:42537 "HELO
	nm5.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752019Ab1AHWSN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jan 2011 17:18:13 -0500
In-Reply-To: <4D2840F5.10907@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Hello,

Michael, this is one of the CF card adapters that has a jumper, JP1, th=
at has the Pin-20 power source option as you suggest below.  The factor=
y default position is external power (floppy disk power plug), and the =
alternative position is: "IDE Pin-20."  The the settings for the three =
jumpers are on the jumper's printed circuit board under the CF Card.  S=
orry I didn't look at the one-sheet instruction sheet that I cannot fin=
d right now, but Michael's email reminded me to look under the CF Card.

Tom=20

--- On Sat, 1/8/11, Michael Tokarev <mjt@tls.msk.ru> wrote:

> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: CF Card Adapter White List Candidate
> To: "Robert Hancock" <hancockrwd@gmail.com>
> Cc: "Tom Denchfield" <td_denchfield@yahoo.com>, "Tejun Heo" <htejun@g=
mail.com>, linux-ide@vger.kernel.org
> Date: Saturday, January 8, 2011, 4:48 AM
> 07.01.2011 07:22, Robert Hancock
> wrote:
> > On Wed, Jan 5, 2011 at 11:33 PM, Tom Denchfield <td_denchfield@yaho=
o.com>
> wrote:
> >> The reason that I mentioned powering my CF adapter
> with a floppy drive power plug is that the first time I
> booted after inserting the adapter, I forgot to plug the
> floppy drive power plug into the adapter.=A0 The
> adapter's power on LED did not light, and I think that
> Ubuntu did not see the CF card.
> >>
> >> The reason that I mentioned the pin that was
> intentionally left out of the motherboard IDE socket was
> that I thought that the missing pin might have had something
> to do with needing to power the adapter with the floppy
> drive power plug given my experience with forgetting to plug
> the floppy power plug into the adapter as mentioned in the
> previous paragraph.
> >>
> >> The pin that is missing from the motherboard IDE
> socket is very close to the middle of the IDE socket.=A0
> My guess is that the pin is in the in the range #18 to
> #24.=A0 It is far away from pin #34.=A0 I am going by
> memory here, but I clearly remember that the missing pin is
> in the middle.=A0 Pin #34 is going into the CF card
> adapter when I insert it.=A0 I do not know whether pin
> #34 is grounded at the mainboard.
> >=20
> > If it's pin 20, that's a key pin that's always missing
> and which has
> > the corresponding hole filled in on the cable side
> (from compliant
> > connectors, anyway), to prevent plugging in the cable
> the wrong way
> > around.
> >=20
> > Not sure where the adapter would be potentially
> drawing power from on
> > the IDE connector - as far as I know there aren't any
> pins on a
> > standard IDE connector which provide continuous power.
> The adapters
> > I've seen all use an extra power connector.
>=20
> The 20th pin is actually used on some VIA EPIA (mini-itx)
> motherboards,
> exactly for this purpose: to provide power for CF cards
> like this.
> Some IDE to CF adaptors can be set up (with a jumper) to
> ger power
> to the card from there.
>=20
> /mjt
>=20


     =20
