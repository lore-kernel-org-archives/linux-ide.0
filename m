From: Mark Lord <liml@rtr.ca>
Subject: Re: marvell sata status?
Date: Fri, 02 Jan 2009 11:10:58 -0500
Message-ID: <495E3C92.2070304@rtr.ca>
References: <20090101051038.GD3386@pimb.org> <alpine.DEB.1.10.0901010444440.427@p34.internal.lan> <495CCE0F.7010002@rtr.ca> <20090101184450.GG3386@pimb.org> <alpine.DEB.1.10.0901011411140.20575@p34.internal.lan> <20090101194302.GH3386@pimb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:48959 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbZABQJ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jan 2009 11:09:27 -0500
In-Reply-To: <20090101194302.GH3386@pimb.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jody Belka <lists-lkml@pimb.org>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Jody Belka wrote:
> On Thu, Jan 01, 2009 at 02:11:37PM -0500, Justin Piszcz wrote:
>> On Thu, 1 Jan 2009, Jody Belka wrote:
>>> Cool, I think I'll go for that card then (Adaptec 1430SA). They're
>>> x4, so good bandwidth, and i'll use the x16 slots on my board for
>>> them. Only need one for now, but two eventually. And they're a good
>>> price, at only =C2=A377 each.
>> Does the card 'recognize' disks as SATA or do you have to export the=
m as=20
>> JBOD? The star tech card allows you to see the sata drives directly.
>=20
> Well, it's just fake-raid, so surely you can always see the individua=
l drives?
> Are there actually cards out there that don't? *boggle*
>=20
> Hmm.... ok, checking the Adaptec knowledgebase:
>=20
> Q: Can drives be used on an Adaptec RAID controller but not be used a=
s
>    part of a RAID array?
>=20
> A: Hard drives attached to an Adaptec RAID controller do not have to =
be
>    configured as an array member to work properly. The RAID controlle=
r
>    will recognize and access single disks. Please refer to your contr=
oller
>    documentation for instructions on accessing drives that are not a =
member
>    of any RAID array.=20
=2E.

I suppose, of all of the vendors, Adaptec probably has the best chance
of getting that part right, and probably without randomly writing metad=
ata
somewhere on the drive simply for JBOD.

Anyone know for sure ?

Cheers
