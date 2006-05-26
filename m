From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp c pl atform
Date: Fri, 26 May 2006 10:39:31 +0200
Message-ID: <20060526083931.GA23938@powerlinux.fr>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net> <1147935734.17679.93.camel@localhost.localdomain> <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.wanadoo.fr ([193.252.22.30]:38666 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751027AbWEZIoe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 04:44:34 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0101.wanadoo.fr (SMTP Server) with ESMTP id DE8E71C0024E
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 10:44:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <446CDE26.8090504@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>

On Thu, May 18, 2006 at 04:50:46PM -0400, Mark Lord wrote:
> Jeff Garzik wrote:
> > Benjamin Herrenschmidt wrote:
> >> On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
> ..
> >>> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
> >>>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem
> >> *mmio)
> >>>  {
> >>>       u32 tmp;
> >>> -
> >>> +#ifndef CONFIG_PPC
> >>>       writel(0, mmio + MV_GPIO_PORT_CTL);
> >>> +#endif
> >>
> >> You'll have to do better here too... I don't wee why when compiled on
> >> PPC, this driver should "magically" not clear those bits... At the very
> >> least, you should test the machine type if you want to do something
> >> specific to your platform, but first, you'll have to convince Jeff why
> >> this change has to be done in the first place and if there is a better
> >> way to handle it.
> > 
> > Correct...  it does seem some bugs were found, but #ifdef powerpc is 
> > certainly out of the question.  We want the driver to work without 
> > ifdefs on all platforms.
> 
> Yup.  I have a powerpc platform here with PCI-X, and a PCI-X Marvell card
> to try in it.  So I'll pick up these changes and try to integrate them a
> little more nicely in my internal updated driver, and then pass it on to Jeff.

Hi, ...

I am trying to use a Marvell 88SX5081 based card here in my pegasos machine,
and i never got it working with the libata driver, even with the patches Zang
provided (and 2.6.16 though, maybe i should update to a newer version). The
marvell provided driver worked though at some time.

Would it be possible to have access to your work, in order to not duplicate
effort or something ? 

Friendly,

Sven Luther

