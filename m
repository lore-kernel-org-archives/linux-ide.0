From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
Date: Sat, 26 Feb 2005 15:19:42 -0500
Message-ID: <4220D9DE.10904@pobox.com>
References: <20050224015859.55191.qmail@web40910.mail.yahoo.com> <421D3D33.9060707@pobox.com> <20050226193255.GA6256@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36302 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261272AbVBZUUC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Feb 2005 15:20:02 -0500
In-Reply-To: <20050226193255.GA6256@ime.usp.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Cc: Brian Kuschak <bkuschak@yahoo.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Rog=E9rio Brito wrote:
> On Feb 23 2005, Jeff Garzik wrote:
>=20
>>Does this patch do anything useful?
>>	Jeff
>=20
> (...)
>=20
> The patch you posted seems to only affect people using SATA, right?
>=20
> BTW, just for clarity I'm seeing the message in a PATA environment (o=
n
> i386) and Brian is seeing his problem with a SATA device on ppc.

"irq XX: nobody cared" is a screaming interrupt situation, which could=20
have 1001 causes.

Normally it's something that "pci=3Dbiosirq" or "acpi=3Doff" will fix, =
but=20
on occasion the driver itself is what needs fixing.

	Jeff



