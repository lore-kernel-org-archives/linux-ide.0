From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Wed, 30 Nov 2016 14:06:58 +0100
Message-ID: <2368047.lDgGYdnaMc@amdc3058>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <CGME20161129204609epcas1p1cad95d01c97dd23df8006389419628e4@epcas1p1.samsung.com>
 <20161129204602.GD4959@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57282 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbcK3NHC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 08:07:02 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHG02J9ZHRO9D20@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 30 Nov 2016 22:07:00 +0900 (KST)
In-reply-to: <20161129204602.GD4959@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: whiteheadm@acm.org, linux-ide@vger.kernel.org


Hi,

On Tuesday, November 29, 2016 03:46:02 PM Tejun Heo wrote:
> Hello,
> 
> On Tue, Nov 29, 2016 at 03:12:31PM -0500, tedheadster wrote:
> > > Can you please give a concrete example of a machine and situation
> > > where this would be useful?
> > >
> > 
> > 
> > Sure, my regression testing i486 system has this problem. It only has
> > an EISA bus, no PCI. I had to apply the patch to be able to put even
> > 2-3 cards in it. It had run out of IRQs.
> > 
> > This testing helped uncover a long time kernel bug that now has a patch.
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=fc0e81b2bea0ebceb71889b61d2240856141c9ee
> > 
> > Please check the linux-kernel mailing list thread "What exactly do
> > 32-bit x86 exceptions push on the stack in the CS slot?" for more
> > details.
> > 
> > https://lkml.org/lkml/2016/11/19/308
> 
> I see.  Yeah, I don't have any objections to the change although I do
> wish it were easier / automatic.  That said, given how niche it is, it
> most likely won't matter.  Bartlomiej, what do you think?

I would also prefer to have such systems detected automatically
(i.e. by using DMI, please check dmidecode output on this board).
If this is not possible I'm fine with the change, though I have some
review comments to the patch itself (please see the other mail).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

