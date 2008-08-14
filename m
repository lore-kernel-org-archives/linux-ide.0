From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] LBA28/LBA48 off-by-one bug in ata.h
Date: Thu, 14 Aug 2008 23:58:08 +0100
Message-ID: <20080814235808.1114130e@lxorguk.ukuu.org.uk>
References: <481C224F.10301@rakugaki.org>
	<87f94c370808141404w570104e7re258da1958e6689b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37488 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751424AbYHNXPq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Aug 2008 19:15:46 -0400
In-Reply-To: <87f94c370808141404w570104e7re258da1958e6689b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Taisuke Yamada <tai@rakugaki.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

> >  "28-bit LBA command is being used to access LBAs 29-bits in length"
> > http://www.hitachigst.com/hddt/knowtree.nsf/cffe836ed7c12018862565b000530c74/b531b8bce8745fb78825740f00580e23
> >
> > Also, *BSDs seems to have similar fix included sometime around ~2004,
> > through I have not checked out exact portion of the code.

By a very strict pessimal reading of the spec I would agree with you

> >
> > I do not subscribe to the list, so Cc: me if further discussion is
> > needed.
> >
> > Best Regards,
> > --
> > Taisuke Yamada
> >
> > --- linux-2.6.24/include/linux/ata.h.orig       2008-05-03 16:08:13.224811900 +0900
> > +++ linux-2.6.24/include/linux/ata.h    2008-04-01 20:33:44.460619700 +0900
> > @@ -599,7 +599,7 @@ static inline int ata_ok(u8 status)
> >  static inline int lba_28_ok(u64 block, u32 n_block)
> >  {
> >        /* check the ending block number */
> > -       return ((block + n_block - 1) < ((u64)1 << 28)) && (n_block <= 256);
> > +       return ((block + n_block) < ((u64)1 << 28)) && (n_block <= 256);
> >  }

(needs a signed off from the original author)

but

Acked-by: Alan Cox <alan@redhat.com>

I'm happy with this Jeff and I think it should go in promptly (didn't
realise it hadn't done so before). Whether the -1 is right could be
argued in debate about fine points of the spec but it has no real impact
to do this and if drives actually care about this in some cases we
clearly should.
