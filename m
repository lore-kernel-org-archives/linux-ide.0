From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Marvell 6121 SATA support?
Date: Mon, 17 Mar 2008 08:31:03 -0400
Message-ID: <47DE6487.4040409@garzik.org>
References: <47D6945F.3080201@aquazul.com> <47D697B0.90009@garzik.org> <200803112310.32589.jareguero@telefonica.net> <200803132322.24308.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55923 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbYCQMbJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 08:31:09 -0400
In-Reply-To: <200803132322.24308.jareguero@telefonica.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jose Alberto Reguero <jareguero@telefonica.net>
Cc: Mourad De Clerck <mourad@aquazul.com>, linux-ide@vger.kernel.org

Jose Alberto Reguero wrote:
> El Martes, 11 de Marzo de 2008, Jose Alberto Reguero escribi=F3:
>> El Martes, 11 de Marzo de 2008, Jeff Garzik escribi=F3:
>>> Mourad De Clerck wrote:
>>>> Hello,
>>>>
>>>> I was wondering what the status was of Marvell 6121 SATA support. =
I've
>>>> seen earlier messages saying it was pretty much working with the A=
HCI
>>>> driver, and that it would be merged in mainline soon, but that was=
 in
>>>> 2.6.22 times.
>>>>
>>>> I've not seen support for it in 2.6.25-rc5's ahci, so I guess I
>>>> shouldn't expect it in 2.6.25?
>>> I would just add the PCI ID to ahci.c, it should most likely work..=
=2E
>>>
>>> 	Jeff
>>  I use this patch for kernels 2.6.25-rc
>>
>> Jose Alberto
>=20
> Attached is a patch against 2.6.25-rc5 kernel to add suport for Marve=
ll 6121=20
> SATA.
>=20
> Signed-off-by: Jose Alberto Reguero <jareguero@telefonica.net>

applied, thanks for cleaning that up


