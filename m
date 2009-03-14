From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 20/73] pata_efar: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 23:40:35 +0300
Message-ID: <49BC1643.9020201@ru.mvista.com>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net> <alpine.BSF.1.00.0903142014190.59456@anduin.net> <20090314194522.2e8bbaa1@lxorguk.ukuu.org.uk> <alpine.BSF.1.00.0903142045250.61753@anduin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3366 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751749AbZCNUko (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Mar 2009 16:40:44 -0400
In-Reply-To: <alpine.BSF.1.00.0903142045250.61753@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RXJpayBJbmdlIEJvbHPDuA==?= <knan-lkml@anduin.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Erik Inge Bols=C3=B8 wrote:

>>> No functional changes in this patch.
>>> (Looks like it could use one, though.)
>>>      =20
>> Yep - wrong comment. The EFAR is a sort of clone of the PIIX and I c=
opied
>> the comment while EFAR don't appear to have copied the limitation
>>    =20
>
> Most suspicious thing I noted here was 0x0F =3D UDMA3, though. You pr=
obably=20
> meant UDMA4?
>
> Will send bugfix patches after I redo the pure conversion in two patc=
hes,=20
> like Jeff says.
>  =20

   It makes more sense to put the fixes *before* the cleanups.

MBR, Sergei


