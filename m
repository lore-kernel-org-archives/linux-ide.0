From: =?ISO-8859-1?Q?Guillaume_Laur=E8s?= <guillaume-laures@neuf.fr>
Subject: Re: PROBLEM: I/O scheduler problem with an 8 SATA disks raid 5 under heavy load  ?
Date: Wed, 20 Feb 2008 12:35:14 +0100
Message-ID: <DE29CFB4-18E5-4CA3-A44D-6AD46D1A122D@neuf.fr>
References: <fa.NcJePXcdrF+7E7oXv5ULIxogTYI@ifi.uio.no> <4782C3DB.1090201@shaw.ca> <2A722A49-F024-44E9-9FC8-7B714FB25626@neuf.fr> <47840EB2.2010300@shaw.ca>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:49284
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751159AbYBTLfU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 06:35:20 -0500
In-Reply-To: <47840EB2.2010300@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

Hello all,

A bit of update to this issue.

Switching the cabling of the most problematic drive with a new one =20
didn't fix the issue.
I couldn't yet switch the power supply with a more powerful one. =20
However I temporarily added a pci-e SATA host and another drive, the =20
situation was just as bad, not worse ;-) This HBA just had 2 ports, =20
so I couldn't swap it completely with the nvidia ports.

Just as a guess I added sata_nv.adma=3D0 and the problem completly =20
disappeared for 4 weeks now. Removing it from cmdline just make it =20
come back.

Unfortunately I'm running xen on this host so I don't think adma =20
patches if any may be suitable to me, at least as long as something > =20
2.6.20 doesn't come in gentoo for xen...

Regards,

GoM

Le 9 janv. 08 =E0 01:00, Robert Hancock a =E9crit :

>> So it seems to be either a cabling problem or a bug with sata_nv ? =20
>> I'm running gentoo's 2.6.20-xen, and maybe my problem looks like =20
>> the sata_nv/adma/samsung problems reports I can see on the net ?
>
> I don't think it's the same problem. In that case the controller =20
> appears to indicate that it didn't even start processing the =20
> command. In this case it's indicating that the command was sent to =20
> the drive and is still waiting for it to indicate completion.
>
> It could be a cabling problem, yes. Also, are you sure your power =20
> supply is able to handle the power draw of that many drives?

