From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] libata: blacklist NCQ on OCZ CORE 2 SSD
Date: Tue, 16 Dec 2008 19:04:29 -0600
Message-ID: <4948501D.50000@shaw.ca>
References: <4946C96B.2030603@dsrg.mff.cuni.cz> <4946F81B.7020408@shaw.ca> <49476EC7.5080201@dsrg.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:52055 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbYLQBEc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 20:04:32 -0500
In-Reply-To: <49476EC7.5080201@dsrg.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?THVib23DrXIgQnVsZWo=?= <lubomir.bulej@dsrg.mff.cuni.cz>
Cc: jgarzik@pobox.com, ide <linux-ide@vger.kernel.org>

Lubom=C3=ADr Bulej wrote:
> Hello,
>=20
> thanks for the insight - I can only (somewhat) parse the simplest of =
ATA=20
> errors related to bad sectors :-)
>=20
>> The "applying bridge limits" part is interesting, that would imply t=
he=20
>> device's identify data doesn't properly indicate it's actually a SAT=
A=20
>> device so the kernel assumes it's a PATA device behind a SATA bridge=
=2E=20
>> I don't think it's related to the problem but it does suggest that=20
>> whoever designed the SATA interface on that thing probably didn't do=
 a=20
>> ton of validation on it..
>=20
> It well may be, who knows - there is basically no detailed info on th=
e=20
> product. Is there a way to find out, apart from taking it apart and=20
> taking a peek at the chips? :-)

Likely not, but it seems pretty much impossible that it is, if it=20
reports NCQ support..

>=20
> BTW, can the kernel assumption of "pata-behind-sata-bridge" cause any=
=20
> problems?

It looks like all that does is limit the transfer rate to UDMA5 (which=20
doesn't actually make any difference if it's really SATA) and limits=20
maximum sectors per transfer to 200.

>=20
> Anyway, I guess that's what we get when memory manufacturers (let's s=
ay=20
> assemblers) start delving into persistent storage. I was a bit dazed =
by=20
> the "oh so distinguishing" model name/number...
>=20
>=20
> Best regards,
> Lubomir
>=20
>=20
