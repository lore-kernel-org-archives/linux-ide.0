From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 20/73] pata_efar: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 18:10:31 -0400
Message-ID: <49BC2B57.9030206@garzik.org>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net> <alpine.BSF.1.00.0903142014190.59456@anduin.net> <20090314194522.2e8bbaa1@lxorguk.ukuu.org.uk> <alpine.BSF.1.00.0903142045250.61753@anduin.net> <49BC1643.9020201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53504 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132AbZCNWKu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Mar 2009 18:10:50 -0400
In-Reply-To: <49BC1643.9020201@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: =?UTF-8?B?RXJpayBJbmdlIEJvbHPDuA==?= <knan-lkml@anduin.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
>=20
> Erik Inge Bols=C3=B8 wrote:
>=20
>>>> No functional changes in this patch.
>>>> (Looks like it could use one, though.)
>>>>      =20
>>> Yep - wrong comment. The EFAR is a sort of clone of the PIIX and I=20
>>> copied
>>> the comment while EFAR don't appear to have copied the limitation
>>>    =20
>>
>> Most suspicious thing I noted here was 0x0F =3D UDMA3, though. You=20
>> probably meant UDMA4?
>>
>> Will send bugfix patches after I redo the pure conversion in two=20
>> patches, like Jeff says.
>>  =20
>=20
>   It makes more sense to put the fixes *before* the cleanups.

Quite true...

	Jeff




