From: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Highpoint IDE types
Date: Sat, 12 Nov 2005 04:15:02 +0200
Message-ID: <pan.2005.11.12.02.15.00.646462@sci.fi>
References: <1131471483.25192.76.camel@localhost.localdomain> <pan.2005.11.08.19.02.09.190896@sci.fi> <4374F633.6020006@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:30680 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750978AbVKLCRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2005 21:17:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EakwD-00025s-TA
	for linux-ide@vger.kernel.org; Sat, 12 Nov 2005 03:16:17 +0100
Received: from cs181093116.pp.htv.fi ([82.181.93.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 12 Nov 2005 03:16:17 +0100
Received: from syrjala by cs181093116.pp.htv.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 12 Nov 2005 03:16:17 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005 22:51:15 +0300, Sergei Shtylylov wrote:

> Hello.
>=20
> Ville Syrj=E4l=E4 wrote:
>> On Tue, 08 Nov 2005 17:38:02 +0000, Alan Cox wrote:
>=20
>>>Ok thanks to Sergei I can now post what I think is the complete tabl=
e of
>>>HPT chip versions:
>=20
>     Another correction coming in... :-)
>=20
>>>        Chip                    PCI ID          Rev
>>> *      HPT366                  4 (HPT366)      0
>>> *      HPT366                  4 (HPT366)      1   =20
>>> *      HPT368                  4 (HPT366)      2     =20
>>> *      HPT370                  4 (HPT366)      3     =20
>>> *      HPT370A                 4 (HPT366)      4     =20
>>> *      HPT372                  4 (HPT366)      5    =20
>>> *      HPT372N                 4 (HPT366)      6    =20
>>> *      HPT372                  5 (HPT372)      0
>>=20
>>           ^^^^^^
>>=20
>> This one is called HPT372A by Highpoint's BIOS/Win drivers.
>=20
>     According to Highpoint's driver code 372A has rev. ID 1...
>=20
>> Also I'm not sure if it's relevant but PCI ID 5 chips use a differen=
t
>> BIOS image than PCI ID 4 chips.
>>       =20
>>=20
>>> *      HPT372N                 5 (HPT372)      > 0    =20
>=20
>     And 372N has rev. ID 2...

Right you are. Their opensource driver doesn't list any PCI ID 5,6 or 7
chips with revision 0. All rev 1 chips are apparently non-N models and =
all
rev 2 chips are N models.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


