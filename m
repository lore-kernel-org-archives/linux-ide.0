From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: Highpoint IDE types
Date: Fri, 11 Nov 2005 22:51:15 +0300
Message-ID: <4374F633.6020006@ru.mvista.com>
References: <1131471483.25192.76.camel@localhost.localdomain> <pan.2005.11.08.19.02.09.190896@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:13479 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751118AbVKKTta
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Nov 2005 14:49:30 -0500
In-Reply-To: <pan.2005.11.08.19.02.09.190896@sci.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Ville Syrj=E4l=E4 wrote:
> On Tue, 08 Nov 2005 17:38:02 +0000, Alan Cox wrote:

>>Ok thanks to Sergei I can now post what I think is the complete table=
 of
>>HPT chip versions:

    Another correction coming in... :-)

>>        Chip                    PCI ID          Rev
>> *      HPT366                  4 (HPT366)      0
>> *      HPT366                  4 (HPT366)      1   =20
>> *      HPT368                  4 (HPT366)      2     =20
>> *      HPT370                  4 (HPT366)      3     =20
>> *      HPT370A                 4 (HPT366)      4     =20
>> *      HPT372                  4 (HPT366)      5    =20
>> *      HPT372N                 4 (HPT366)      6    =20
>> *      HPT372                  5 (HPT372)      0
>=20
>           ^^^^^^
>=20
> This one is called HPT372A by Highpoint's BIOS/Win drivers.

    According to Highpoint's driver code 372A has rev. ID 1...

> Also I'm not sure if it's relevant but PCI ID 5 chips use a different
> BIOS image than PCI ID 4 chips.
>       =20
>=20
>> *      HPT372N                 5 (HPT372)      > 0    =20

    And 372N has rev. ID 2...

WBR, Sergei
