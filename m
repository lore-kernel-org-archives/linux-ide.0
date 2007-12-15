From: =?ISO-8859-1?Q?Michael_K=FChn?= <breiteseite1337@googlemail.com>
Subject: Re: [PATCH] drivers/ata/ahci.c, kernel 2.6.23.10
Date: Sat, 15 Dec 2007 18:08:40 +0100
Message-ID: <47640A18.4010308@googlemail.com>
References: <4763F336.7050206@googlemail.com> <476404BD.5090801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:36568 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbXLORIv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 12:08:51 -0500
Received: by mu-out-0910.google.com with SMTP id i10so2122304mue.5
        for <linux-ide@vger.kernel.org>; Sat, 15 Dec 2007 09:08:49 -0800 (PST)
In-Reply-To: <476404BD.5090801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: linux-ide@vger.kernel.org, torvalds@linux-foundation.org

Hmm...
but why we shouldn't integrate this fix in 2.6.23* branch?
I thought 2.6.23 and 2.6.24 are indepented from each other and get thei=
r=20
own fixes. So it's just a nice have-to-be in the next Bugfix release.

Yours sincerly
Michael K=FChn

Mark Lord schrieb:
> Michael K=FChn wrote:
>> This patch remove a unused variable in the ahci_port_intr function a=
nd
>> therewith a compiler warning.
>>
>> Signed-off-by: Michael K=FChn <breiteseite1337@googlemail.com>
>>
>>
>> --- linux-2.6.23.10/drivers/ata/ahci.c  2007-12-14 19:01:59.00000000=
0=20
>> +0100
>> +++ linux-2.6.23.10.new/drivers/ata/ahci.c      2007-12-15
>> 01:03:41.000000000 +0100
>> @@ -1430,7 +1430,6 @@
>>  {
>>         void __iomem *port_mmio =3D ap->ioaddr.cmd_addr;
>>         struct ata_eh_info *ehi =3D &ap->eh_info;
>> -       struct ahci_port_priv *pp =3D ap->private_data;
>>         u32 status, qc_active;
>>         int rc;
> ..
>=20
> Mmmm.. seems to not be applicable to current 2.6.24-rc*,
> as the "pp" variable *is* used in that function there.
>=20
> For older kernels, only serious bugs warrant an update.
>=20
> Cheers
