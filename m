From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: marvell sata status?
Date: Fri, 2 Jan 2009 13:03:28 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0901021302560.26159@p34.internal.lan>
References: <20090101051038.GD3386@pimb.org> <alpine.DEB.1.10.0901010444440.427@p34.internal.lan> <495CCE0F.7010002@rtr.ca> <20090101184450.GG3386@pimb.org> <alpine.DEB.1.10.0901011411140.20575@p34.internal.lan> <20090101194302.GH3386@pimb.org>
 <495E3C92.2070304@rtr.ca>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-1662053244-1230919408=:26159"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:48171 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757471AbZABSDb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jan 2009 13:03:31 -0500
In-Reply-To: <495E3C92.2070304@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jody Belka <lists-lkml@pimb.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-1662053244-1230919408=:26159
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Fri, 2 Jan 2009, Mark Lord wrote:

> Jody Belka wrote:
>> On Thu, Jan 01, 2009 at 02:11:37PM -0500, Justin Piszcz wrote:
>>> On Thu, 1 Jan 2009, Jody Belka wrote:
>>>> Cool, I think I'll go for that card then (Adaptec 1430SA). They're
>>>> x4, so good bandwidth, and i'll use the x16 slots on my board for
>>>> them. Only need one for now, but two eventually. And they're a good
>>>> price, at only =C2=A377 each.
>>> Does the card 'recognize' disks as SATA or do you have to export them a=
s=20
>>> JBOD? The star tech card allows you to see the sata drives directly.
>>=20
>> Well, it's just fake-raid, so surely you can always see the individual=
=20
>> drives?
>> Are there actually cards out there that don't? *boggle*
>>=20
>> Hmm.... ok, checking the Adaptec knowledgebase:
>>=20
>> Q: Can drives be used on an Adaptec RAID controller but not be used as
>>    part of a RAID array?
>>=20
>> A: Hard drives attached to an Adaptec RAID controller do not have to be
>>    configured as an array member to work properly. The RAID controller
>>    will recognize and access single disks. Please refer to your controll=
er
>>    documentation for instructions on accessing drives that are not a mem=
ber
>>    of any RAID array.=20
> ..
>
> I suppose, of all of the vendors, Adaptec probably has the best chance
> of getting that part right, and probably without randomly writing metadat=
a
> somewhere on the drive simply for JBOD.
>
> Anyone know for sure ?
>
> Cheers
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

The Star Tech seems to work right, you plug in the disks and they're=20
recognized as regular sata disks, as if on your on-board controller.  No=20
special modifications required.
---1463747160-1662053244-1230919408=:26159--
