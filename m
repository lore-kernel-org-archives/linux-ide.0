From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFC PATCH 00/19] ide: remove deprecated host drivers (part 1)
Date: Thu, 08 Dec 2016 18:14:33 +0100
Message-ID: <1861504.e0fxpIs7Qv@amdc3058>
References: <3280015.pSoKvQuVNQ@amdc3058>
 <CGME20161208164009epcas1p1e9bcb016a2b25d3e57e8428e4a2200ce@epcas1p1.samsung.com>
 <20161208.113957.686350007074631834.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33405 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcLHROh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2016 12:14:37 -0500
In-reply-to: <20161208.113957.686350007074631834.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org, gnomes@lxorguk.ukuu.org.uk, sergei.shtylyov@cogentembedded.com

On Thursday, December 08, 2016 11:39:57 AM David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Date: Thu, 08 Dec 2016 17:15:16 +0100
> 
> > On Thursday, December 08, 2016 10:23:08 AM David Miller wrote:
> >> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> Date: Thu, 08 Dec 2016 14:42:12 +0100
> >> 
> >> > Ping.. since there was no negative (or any other) feedback I think that
> >> > this can be put into -next for some wider exposure..
> >> 
> >> I'm not going to apply this and break things on people, sorry.
> > 
> > People building their own kernels with their own kernel config files
> > and still using IDE drivers (deprecated in 2009 BTW) will have to
> > update their setups to libata but otherwise nothing is supposed to
> > break.  So could you please explain in more detail what do you mean
> > by "break things on people"?
> 
> There is no proof that the PATA drivers work %100 reliably as well as
> the IDE driver they replace for every possible chip and architecture.

This is why only some IDE host drivers were nominated for removal.

Please see cover-letter and patch descriptions for details.

> Therefore the only safe thing is to keep the IDE drivers around
> forever.

Uh...

> They are not a maintainence burdon, I rarely get more than 1 patch
> each merge window and most of the time those are cleanups or for the
> handling of a kernel wide API change rather than bug fixes.

In the long-term perspective having two drivers for the same hardware
is not good for the whole kernel as:

- testing efforts are divided (while number of PATA systems goes down)

- bugs/missing features in the new subsystem are not getting reported
  and fixed (since it is easier to just switch back to the old stack)

- having duplicated support for the same hardware confuses users

I was hoping for incremental removal of IDE host drivers and keeping
only these that are really needed (while at the same time migrating
them slowly to libata).

I asked you about this in private mail in August 2015, you told me to
bring this on the list.  I did it (with these patches) in February
2016.  After two pings and months of waiting for a reply all I get is
is a quick NAK?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

