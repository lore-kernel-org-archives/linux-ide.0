From: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Highpoint IDE types
Date: Tue, 08 Nov 2005 21:02:09 +0200
Message-ID: <pan.2005.11.08.19.02.09.190896@sci.fi>
References: <1131471483.25192.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965277AbVKHTNr@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 08 Nov 2005 17:38:02 +0000, Alan Cox wrote:

> Ok thanks to Sergei I can now post what I think is the complete table=
 of
> HPT chip versions:
>=20
>         Chip                    PCI ID          Rev
>  *      HPT366                  4 (HPT366)      0
>  *      HPT366                  4 (HPT366)      1   =20
>  *      HPT368                  4 (HPT366)      2     =20
>  *      HPT370                  4 (HPT366)      3     =20
>  *      HPT370A                 4 (HPT366)      4     =20
>  *      HPT372                  4 (HPT366)      5    =20
>  *      HPT372N                 4 (HPT366)      6    =20
>  *      HPT372                  5 (HPT372)      0
          ^^^^^^

This one is called HPT372A by Highpoint's BIOS/Win drivers.

Also I'm not sure if it's relevant but PCI ID 5 chips use a different
BIOS image than PCI ID 4 chips.
      =20
>  *      HPT372N                 5 (HPT372)      > 0    =20
>  *      HPT302                  6 (HPT302)      *      =20
>  *      HPT302N                 6 (HPT302)      > 1   =20
>  *      HPT371                  7 (HPT371)      *     =20
>  *      HPT371N                 7 (HPT371)      > 1    =20
>  *      HPT374                  8 (HPT374)      *    =20
>  *      HPT372N                 9 (HPT372N)     *    =20

This last one is not listed in the Win drivers at all. Strange.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
