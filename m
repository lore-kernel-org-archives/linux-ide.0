From: =?utf-8?b?VMO2csO2aw==?= Edwin <edwintorok@gmail.com>
Subject: Re: Enabling AHCI on ICH7 without BIOS support
Date: Sun, 19 Aug 2007 06:56:57 +0000 (UTC)
Message-ID: <loom.20070819T084305-257@post.gmane.org>
References: <46C1A999.5070109@dastyle.net>	<46C441CB.8020805@gmail.com>	<46C44A05.9040302@dastyle.net> <20070819014412.1378C5ED6F3@master.hanzubon.jp> <46C7D666.8020700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51582 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbXHSHFM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Aug 2007 03:05:12 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IMeqM-0006MP-Bw
	for linux-ide@vger.kernel.org; Sun, 19 Aug 2007 09:05:02 +0200
Received: from 86-125-52-171.rdstm.ro ([86-125-52-171.rdstm.ro])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 19 Aug 2007 09:05:02 +0200
Received: from edwintorok by 86-125-52-171.rdstm.ro with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 19 Aug 2007 09:05:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <htejun <at> gmail.com> writes:

> ISHIKAWA Mutsumi wrote:
> >  Do you know Edvin's patch?
> > 
> > http://www.bughost.org/pipermail/power/2007-June/000538.html
> > 
> >  I've tested it and works fine on my note
> > (Sony VAIO type S VGN-SZ92PS, ICH7-M)

Thanks for testing.

> 
> Yeah, I've seen it but I'm not sure whether it would worth the risk.
> For one, there are BIOSen which won't assign IO memory region to ABAR at
> all.  There also is a patch to reallocate IO memory regions and make
> room for ABAR but that can break things.
> 

It works fine on 2.6.22 (except that you loose the CD-ROM, and I found no way to
reliably reactivate it), however since 2.6.23-rc it breaks.
I get misrouted IRQs: IRQ 12 (keyboard) is being fired instead of IRQ 18 (ahci),
the kernel disables IRQ 18 because of spurious IRQs, and then IRQ 0 gets fired
instead of IRQ 18. It is an edge-triggered interrupt, and I get the feeling  the
interrupt status isn't cleared after handling it, since I continously get
messages about misrouted IRQs even if the system idle.
It works with irqpoll, but I don't have to tell you how slow that is.

When I'll be back from holiday I will try to compare lspci -xxx outputs, and
then maybe try a git-bisect.

Bottom line is that force-enabling AHCI like this can stop working at any time
with a new kernel version.
If there is a document describing _exactly_ what steps I need to follow to
properly enable the device, I'd be happy to read it, but I guess such
documentation is only available to BIOS developers.

--Edwin

