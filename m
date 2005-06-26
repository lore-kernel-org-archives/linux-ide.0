From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: SATA speed. Should be 150 or 133?
Date: Sun, 26 Jun 2005 16:14:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0506261612420.9277@bizon.gios.gov.pl>
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl>
 <42BB794B.6080109@rtr.ca> <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl>
 <42BC284E.7050202@rtr.ca> <Pine.LNX.4.62.0506242032290.1394@bizon.gios.gov.pl>
 <42BE0B7D.4050307@rtr.ca> <Pine.LNX.4.62.0506261229430.2421@bizon.gios.gov.pl>
 <42BEB4B0.8090405@pobox.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1687244656-1119795297=:9277"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bizon.gios.gov.pl ([212.244.124.8]:28560 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S261294AbVFZOPJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 10:15:09 -0400
In-Reply-To: <42BEB4B0.8090405@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1687244656-1119795297=:9277
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Sun, 26 Jun 2005, Jeff Garzik wrote:

> Krzysztof Oledzki wrote:
>>=20
>>=20
>> On Sat, 25 Jun 2005, Mark Lord wrote:
>>=20
>>> Krzysztof Oledzki wrote:
>>>=20
>>>>=20
>>>> # hdparm -I /dev/sda
>>>>=20
>>>> /dev/sda:
>>>> (...)
>>>>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *ud=
ma6
>>>> (...)
>>>>=20
>>>> This one? udma6?
>>>=20
>>>=20
>>> Yup.  udma6 =3D=3D UDMA/133
>>=20
>>=20
>> So, how this line would look like for SATA150?
>
> Unchanged.  SATA150 only goes to udma6.

So, excuse me for asking this question again: how to check true=20
(current) speed? I still don't know if this disk uses UDMA/133 or SATA150.

Best regards,

 =09=09=09Krzysztof Ol=EAdzki
---187430788-1687244656-1119795297=:9277--
