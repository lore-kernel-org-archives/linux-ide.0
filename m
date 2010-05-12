From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [BUG] bug when enabling VM DEBUG
Date: Wed, 12 May 2010 17:22:35 -0600
Message-ID: <AANLkTilhIvv-knAVyivbo3o9LphUO4-j8-iVunlF2qcS@mail.gmail.com>
References: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com>
	 <AANLkTikoNc6oAY5JthYX1jWx1w2KeJ1fGab72Z-OvIVG@mail.gmail.com>
	 <4BEA1559.9000107@gmail.com>
	 <1273662639.23818.67.camel@e102109-lin.cambridge.arm.com>
	 <20100512115340.GA11261@Chamillionaire.breakpoint.cc>
	 <1273667099.23818.86.camel@e102109-lin.cambridge.arm.com>
	 <20100512130638.GB19314@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48305 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab0ELXWg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 May 2010 19:22:36 -0400
In-Reply-To: <20100512130638.GB19314@shareable.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Jeff Garzik <jeff@garzik.org>, lkml <linux-kernel@vger.kernel.org>, DE/ATA development list <linux-ide@vger.kernel.org>, saeed bishara <saeed.bishara@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, May 12, 2010 at 7:06 AM, Jamie Lokier <jamie@shareable.org> wro=
te:
> Catalin Marinas wrote:
>> On Wed, 2010-05-12 at 12:53 +0100, Sebastian Andrzej Siewior wrote:
>> > * Catalin Marinas | 2010-05-12 12:10:39 [+0100]:
>> >
>> > >> > --- a/drivers/ata/libata-sff.c
>> > >> > +++ b/drivers/ata/libata-sff.c
>> > >> > @@ -894,7 +894,7 @@ static void ata_pio_sector(struct ata_que=
ued_cmd *qc)
>> > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 do_write);
>> > >> > =A0 =A0 =A0 =A0 =A0}
>> > >> >
>> > >> > - =A0 =A0 =A0 if (!do_write)
>> > >> > + =A0 =A0 =A0 if (!do_write&& =A0!PageSlab(page))
>> > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flush_dcache_page(page);
>> > >>
>> > >> I would think that check belongs inside flush_dcache_page itsel=
f, rather
>> > >> than forcing every driver to include it..
>> > >
>> > >Sebastian (cc'ed) reported this as well for MIPS.
>> > Thx. The patch above looks what I've sent a while ago. Jeff was go=
ing to
>> > merge it afaik.
>> >
>> > >I think it makes sense for this check to be done in the
>> > >flush_dcache_page() function.
>> >
>> > Why should flush_dcache_page() not flush pages you tell it?
>> > From Documentation/cachetlb.txt:
>> > | =A0 NOTE: This routine need only be called for page cache pages
>> > | =A0 =A0 =A0 =A0 =A0which can potentially ever be mapped into the=
 address
>> > | =A0 =A0 =A0 =A0 =A0space of a user process. =A0So for example, V=
=46S layer code
>> > | =A0 =A0 =A0 =A0 =A0handling vfs symlinks in the page cache need =
not call
>> > | =A0 =A0 =A0 =A0 =A0this interface at all.
>> >
>> > A page from slab or stack is not going to see the sky of user land=
 and
>> > therefore it should not be fed into flush_dcache_page().
>>
>> You are right :), so fixing the driver is the best approach.
>
> It worries me that a driver has any knowledge of the PageSlab() flag,
> though. =A0Especially uncommented knowledge. =A0That flag seems VM
> internal, and it's conceptually iffy: Kernel code using
> get_free_pages() and using that for I/O also does not see the sky of
> user land.
>
> If all the PIO drivers have to be changed, I'd be happier with:
>
> =A0 =A0flush_dcache_page_for_pio()
>
> which wraps the check, explains it, and provides a single place to
> change if needed.

Indeed.. It's obscure enough for drivers to need to worry about these
details of cache flushing/invalidation at all, let alone for them to
have to worry about even more obscure details..
