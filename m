From: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] drivers/ata/ahci.c, kernel 2.6.23.10
Date: Sat, 15 Dec 2007 12:19:58 -0500
Message-ID: <47640CBE.3030502@rtr.ca>
References: <4763F336.7050206@googlemail.com> <476404BD.5090801@rtr.ca> <47640A18.4010308@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3462 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758309AbXLORUA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Dec 2007 12:20:00 -0500
In-Reply-To: <47640A18.4010308@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Michael_K=FChn?= <breiteseite1337@googlemail.com>
Cc: linux-ide@vger.kernel.org, torvalds@linux-foundation.org

Michael K=FChn wrote:
> Hmm...
> but why we shouldn't integrate this fix in 2.6.23* branch?
> I thought 2.6.23 and 2.6.24 are indepented from each other and get th=
eir=20
> own fixes. So it's just a nice have-to-be in the next Bugfix release.
=2E.

You can forward it to GregK, who looks after the backported fixes
for those releases, and see if he's interested in it.

Cheers



> Yours sincerly
> Michael K=FChn
>=20
> Mark Lord schrieb:
>> Michael K=FChn wrote:
>>> This patch remove a unused variable in the ahci_port_intr function =
and
>>> therewith a compiler warning.
>>>
>>> Signed-off-by: Michael K=FChn <breiteseite1337@googlemail.com>
>>>
>>>
>>> --- linux-2.6.23.10/drivers/ata/ahci.c  2007-12-14 19:01:59.0000000=
00=20
>>> +0100
>>> +++ linux-2.6.23.10.new/drivers/ata/ahci.c      2007-12-15
>>> 01:03:41.000000000 +0100
>>> @@ -1430,7 +1430,6 @@
>>>  {
>>>         void __iomem *port_mmio =3D ap->ioaddr.cmd_addr;
>>>         struct ata_eh_info *ehi =3D &ap->eh_info;
>>> -       struct ahci_port_priv *pp =3D ap->private_data;
>>>         u32 status, qc_active;
>>>         int rc;
>> ..
>>
>> Mmmm.. seems to not be applicable to current 2.6.24-rc*,
>> as the "pp" variable *is* used in that function there.
>>
>> For older kernels, only serious bugs warrant an update.
>>
>> Cheers

