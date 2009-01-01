From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: marvell sata status?
Date: Thu, 1 Jan 2009 14:11:37 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0901011411140.20575@p34.internal.lan>
References: <20090101051038.GD3386@pimb.org> <alpine.DEB.1.10.0901010444440.427@p34.internal.lan> <495CCE0F.7010002@rtr.ca> <20090101184450.GG3386@pimb.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-876192614-1230837097=:20575"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:40903 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbZAATLj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jan 2009 14:11:39 -0500
In-Reply-To: <20090101184450.GG3386@pimb.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jody Belka <lists-lkml@pimb.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-876192614-1230837097=:20575
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Thu, 1 Jan 2009, Jody Belka wrote:

> On Thu, Jan 01, 2009 at 09:07:11AM -0500, Mark Lord wrote:
>> The Marvell 7042 (PCIe) and 6042 (PCI) chips are very stable
>> and full-featured with the current sata_mv driver in Linux.
>>
>> The older 6081 and 6041 chips still have issues with Linux,
>> something I'm working on fixing early in 2009.
>
> Cool, I think I'll go for that card then (Adaptec 1430SA). They're
> x4, so good bandwidth, and i'll use the x16 slots on my board for
> them. Only need one for now, but two eventually. And they're a good
> price, at only =A377 each.
>
>
> J
> --=20
> Jody Belka
> knew (at) pimb (dot) org
>

Does the card 'recognize' disks as SATA or do you have to export them as=20
JBOD? The star tech card allows you to see the sata drives directly.

Justin.
---1463747160-876192614-1230837097=:20575--
