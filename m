From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Date: Sun, 14 Oct 2007 20:33:09 +0200 (MEST)
Message-ID: <200710141833.l9EIX9fZ021807@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:40343 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbXJNSzM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Oct 2007 14:55:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mikpe@it.uu.se
Cc: alan@lxorguk.ukuu.org.uk, albertl@mail.com, bahadir.balban@gmail.com, dwm@enoyolf.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, sshtylyov@ru.mvista.com

On Sun, 14 Oct 2007 13:31:34 -0400, Jeff Garzik wrote:
> Mikael Pettersson wrote:
> > On Thu, 16 Aug 2007 21:19:40 +0100, Alan Cox wrote:
> >>>> Unfortunately this breaks pata_pdc2027x on my PowerMac G3:
> >>> Did this ever get resolved?
> >> All went quiet so I assume its gone away ?
> > 
> > -ENOTIME
> > 
> > The regression is still there in 2.6.23-rc3 (I just checked),
> > but I haven't had time to debug it yet. I'll try to do something
> > about it this weekend.
> 
> Still broken?

No, my fix was included in 2.6.23-rc4.
