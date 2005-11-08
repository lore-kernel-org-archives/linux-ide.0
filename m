From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Highpoint IDE types
Date: Tue, 08 Nov 2005 17:35:28 -0500
Message-ID: <43712830.90805@tmr.com>
References: <1131471483.25192.76.camel@localhost.localdomain>	 <pan.2005.11.08.19.02.09.190896@sci.fi> <1131480140.25192.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030337AbVKHWdo@vger.kernel.org>
In-Reply-To: <1131480140.25192.98.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Maw, 2005-11-08 at 21:02 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
>=20
>>> *      HPT372                  4 (HPT366)      5    =20
>>> *      HPT372N                 4 (HPT366)      6    =20
>>> *      HPT372                  5 (HPT372)      0
>>
>>          ^^^^^^
>>
>>This one is called HPT372A by Highpoint's BIOS/Win drivers.
>>
>>Also I'm not sure if it's relevant but PCI ID 5 chips use a different
>>BIOS image than PCI ID 4 chips.
>=20
>=20
> I suspect it is relevant because the "372A" appears to have a differe=
nt
> base clock to the HPT372.
>=20
> Added to the list.
>=20
May we assume that this information was gathered in the interest of=20
something beyond pedantic curiousity? Will this simplify the driver=20
code, improve performance or reliability, etc?

--=20
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
