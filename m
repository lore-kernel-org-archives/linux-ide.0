From: Harri Olin <harri.olin@gmail.com>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Fri, 09 Oct 2009 00:51:14 +0300
Message-ID: <4ACE5ED2.2040106@gmail.com>
References: <1254546642.1438.135.camel@giskard> <4ACA6904.1060509@rtr.ca>	 <4ACB3741.2030101@gmail.com>  <1254852272.1471.172.camel@giskard> <1255019160.30440.666.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:50233 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908AbZJHVvv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Oct 2009 17:51:51 -0400
In-Reply-To: <1255019160.30440.666.camel@giskard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bernie Innocenti <bernie@codewiz.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>

Bernie Innocenti kirjoitti:
> El Tue, 06-10-2009 a las 14:04 -0400, Bernie Innocenti escribi=F3:
>>> I have heard same thing happened with same kind of configuration, u=
sing=20
>>> Supermicro H8DME-2 motherboard, Opteron 2378 CPU.
>>>
>>> Even the controllers were on same slots.
>> Close.  Mine is a Supermicro H8DM8-2 with 2x Opteron 2374 HE CPU.
>=20
> I was wrong (the BIOS DMI block is wrong).  The motherboard is labele=
d
> as H8DME-2.
>=20

H8DME-2 is the same board as H8DM8-2, just without scsi controller.

There is 2 3-pin jumpers somewhere between pci-x slots, one for each=20
bus. With these you can force the bus to 66MHz PCI or 66MHz PCI-X.=20
Without jumper means autodetect. Note that this information is only fro=
m=20
manual, haven't been able to confirm what it really does :)

Oh and on the other identical case, I heard that moving other controlle=
r=20
to different bus (1st controller in top slot and 2nd controller in 2nd=20
slot from bottom) resolved the issue, or at least it has not error'd ye=
t.

--=20
Harri.
