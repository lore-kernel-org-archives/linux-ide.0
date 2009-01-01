From: Jody Belka <lists-lkml@pimb.org>
Subject: Re: marvell sata status?
Date: Thu, 1 Jan 2009 19:43:02 +0000
Message-ID: <20090101194302.GH3386@pimb.org>
References: <20090101051038.GD3386@pimb.org> <alpine.DEB.1.10.0901010444440.427@p34.internal.lan> <495CCE0F.7010002@rtr.ca> <20090101184450.GG3386@pimb.org> <alpine.DEB.1.10.0901011411140.20575@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus.pimb.org ([80.68.88.21]:42182 "EHLO zeus.pimb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbZAATn2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jan 2009 14:43:28 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0901011411140.20575@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Thu, Jan 01, 2009 at 02:11:37PM -0500, Justin Piszcz wrote:
> On Thu, 1 Jan 2009, Jody Belka wrote:
> >Cool, I think I'll go for that card then (Adaptec 1430SA). They're
> >x4, so good bandwidth, and i'll use the x16 slots on my board for
> >them. Only need one for now, but two eventually. And they're a good
> >price, at only =A377 each.
>=20
> Does the card 'recognize' disks as SATA or do you have to export them=
 as=20
> JBOD? The star tech card allows you to see the sata drives directly.

Well, it's just fake-raid, so surely you can always see the individual =
drives?
Are there actually cards out there that don't? *boggle*

Hmm.... ok, checking the Adaptec knowledgebase:

Q: Can drives be used on an Adaptec RAID controller but not be used as
   part of a RAID array?

A: Hard drives attached to an Adaptec RAID controller do not have to be
   configured as an array member to work properly. The RAID controller
   will recognize and access single disks. Please refer to your control=
ler
   documentation for instructions on accessing drives that are not a me=
mber
   of any RAID array.=20



J
--=20
Jody Belka
knew (at) pimb (dot) org
