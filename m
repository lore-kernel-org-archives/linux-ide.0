From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Highpoint IDE types
Date: Tue, 08 Nov 2005 20:02:20 +0000
Message-ID: <1131480140.25192.98.camel@localhost.localdomain>
References: <1131471483.25192.76.camel@localhost.localdomain>
	 <pan.2005.11.08.19.02.09.190896@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965296AbVKHTbb@vger.kernel.org>
In-Reply-To: <pan.2005.11.08.19.02.09.190896@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-11-08 at 21:02 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> >  *      HPT372                  4 (HPT366)      5    =20
> >  *      HPT372N                 4 (HPT366)      6    =20
> >  *      HPT372                  5 (HPT372)      0
>           ^^^^^^
>=20
> This one is called HPT372A by Highpoint's BIOS/Win drivers.
>=20
> Also I'm not sure if it's relevant but PCI ID 5 chips use a different
> BIOS image than PCI ID 4 chips.

I suspect it is relevant because the "372A" appears to have a different
base clock to the HPT372.

Added to the list.
