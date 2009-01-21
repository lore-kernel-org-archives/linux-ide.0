From: Jody Belka <lists-lkml@pimb.org>
Subject: Re: marvell sata status?
Date: Wed, 21 Jan 2009 01:33:35 +0000
Message-ID: <20090121013335.GL8281@pimb.org>
References: <20090101051038.GD3386@pimb.org> <alpine.DEB.1.10.0901010444440.427@p34.internal.lan> <495CCE0F.7010002@rtr.ca> <20090101184450.GG3386@pimb.org> <alpine.DEB.1.10.0901011411140.20575@p34.internal.lan> <20090101194302.GH3386@pimb.org> <495E3C92.2070304@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus.pimb.org ([80.68.88.21]:43455 "EHLO zeus.pimb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbZAUBds (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 20:33:48 -0500
Content-Disposition: inline
In-Reply-To: <495E3C92.2070304@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Fri, Jan 02, 2009 at 11:10:58AM -0500, Mark Lord wrote:
> Jody Belka wrote:
> >On Thu, Jan 01, 2009 at 02:11:37PM -0500, Justin Piszcz wrote:
> >>On Thu, 1 Jan 2009, Jody Belka wrote:
> >>>Cool, I think I'll go for that card then (Adaptec 1430SA). They're
> >>>x4, so good bandwidth, and i'll use the x16 slots on my board for
> >>>them. Only need one for now, but two eventually. And they're a goo=
d
> >>>price, at only =A377 each.
> >>Does the card 'recognize' disks as SATA or do you have to export th=
em as=20
> >>JBOD? The star tech card allows you to see the sata drives directly=
=2E
> >
> >Well, it's just fake-raid, so surely you can always see the individu=
al=20
> >drives?
> >Are there actually cards out there that don't? *boggle*
> >
> >Hmm.... ok, checking the Adaptec knowledgebase:
> >
> >Q: Can drives be used on an Adaptec RAID controller but not be used =
as
> >   part of a RAID array?
> >
> >A: Hard drives attached to an Adaptec RAID controller do not have to=
 be
> >   configured as an array member to work properly. The RAID controll=
er
> >   will recognize and access single disks. Please refer to your cont=
roller
> >   documentation for instructions on accessing drives that are not a=
 member
> >   of any RAID array.=20
> ..
>=20
> I suppose, of all of the vendors, Adaptec probably has the best chanc=
e
> of getting that part right, and probably without randomly writing met=
adata
> somewhere on the drive simply for JBOD.
>=20
> Anyone know for sure ?

To follow up on this, I've now picked up one of these cards, and just d=
id
a quick test. Plugged a drive into an on-board socket, booted, made a c=
opy
of about the first 2MB. Blanked that 2MB out, swapped onto the new card=
,
booted, made a new copy, swapped back to on-board, booted, and made ano=
ther
copy. Both copies, and a blank 2MB file, md5sum'ed identically, so it l=
ooks
like it's safe.
