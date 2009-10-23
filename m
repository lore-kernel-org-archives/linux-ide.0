From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Fri, 23 Oct 2009 20:52:47 +0200
Message-ID: <200910232052.47860.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com> <4AE1E78A.2090801@ru.mvista.com> <20091023192250.600edc9b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59953 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZJWSyW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 14:54:22 -0400
Received: by fxm18 with SMTP id 18so10591311fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 23 Oct 2009 11:54:25 -0700 (PDT)
In-Reply-To: <20091023192250.600edc9b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Mikulas Patocka <mpatocka@redhat.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, elendil@planet.nl

On Friday 23 October 2009 20:22:50 Alan Cox wrote:
> >     Yeah. The libata driver however doesn't make use of that register, 
> > unlike  cmd64x. It doesn't even touch the interrupt bits on PCI0646, only 
> > manipulation the "old" bits on PCI-64[89].
> 
> Yes I purposefully left out all the complexity because when I tested the
> cards I had it simply wasn't needed. I'm also not sure we should merge
> anything from the old to the new one until we know why the old one
> corrupts and the new one merely gets upset. Accidentally porting over a
> corruptor would be very bad indeed.

Oh, we know that.

"Old" one corrupts because somebody thought it would be a smart move to remove
serialized flag instead of debugging certain problem properly..

"New" one gets serialized at the command issue level (like all other new shiny
libata PATA stuff) and this may as well explain the difference..

> >     It seems that I need to sync up these two, pata_cmd64x.c seems to be 
> > lagging behind the changes in cmd64x.c. Well, not only this one, at least 
> > pata_hpt* drivers are lagging behind too...

Just from the memory:

pata_sis, pata_atiixp, pata_it8213, pata_cs5536, pata_amd..

So, gentlemen, when are you planning to remove IDE (not from your playground
Linux distribution but from kernel.org)?

I've heard that it will happen "soon" 4 years ago... :)

> That would be useful - although several of the differences are because
> the pata_hpt driver took from the vendor supplied reference code not the
> old IDE code. It also seems more stable for having done that.

Yeah, right..

This reminds me of that hpt366 blacklist that somebody forgot to port over
initially and which resulted in real world data corruptions..

-- 
Bartlomiej Zolnierkiewicz
