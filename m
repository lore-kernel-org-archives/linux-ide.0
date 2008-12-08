From: Kai Krakow <kai@kaishome.de>
Subject: Re: [PATCH] pata_sis: Remove bogus cable match
Date: Mon, 8 Dec 2008 12:13:56 +0100
Message-ID: <200812081213.56499.kai@kaishome.de>
References: <20081205194117.17036.74479.stgit@localhost.localdomain> <49398FAC.2060301@garzik.org> <20081206002705.46052575@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from weser.netactive.de ([193.138.164.58]:37257 "EHLO
	weser.netactive.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbYLHLQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 06:16:22 -0500
In-Reply-To: <20081206002705.46052575@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Am Samstag, 06. Dezember 2008 schrieb Alan Cox:

> On Fri, 05 Dec 2008 15:31:40 -0500
>
> Jeff Garzik <jeff@garzik.org> wrote:
> > Alan Cox wrote:
> > > From: Alan Cox <alan@redhat.com>
> > >
> > > Some systems report SIS 5513 as both vendor/id and subvendor/id string.
> > > In that case we can't distinguish the system by the id svid/sdid and in
> > > fact the entry here breaks some boxes. At some point we need to find
> > > another way to detect the Targa Visionary 1000, until then this a hang
> > > for some users with lower performance for others.
> > >
> > > Closes: #12092
> > >
> > > Signed-off-by: Alan Cox <alan@redhat.com>
> >
> > Should that last sentence be "this SOLVES a hang"?
> >
> > As it is currently worded, it is unclear what we are trading off with
> > this patch...
>
> I missed out the word "trades" ...

Is there away to bypass this bogus-detection and force the driver into using 
high-speed mode on the short 40-wire cable? Maybe by introducing a 
kernel/module parameter? Or is it there? I found nothing in the docs.

Can I provide any information you need to properly detect the Targa Visionary 
1000?

Thanks,
Kai
