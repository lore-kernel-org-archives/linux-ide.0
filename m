From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Date: Fri, 17 Aug 2007 22:51:23 +0200 (MEST)
Message-ID: <200708172051.l7HKpNtq009682@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:34649 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbXHQUwF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Aug 2007 16:52:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk, jeff@garzik.org
Cc: albertl@mail.com, bahadir.balban@gmail.com, dwm@enoyolf.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, mikpe@it.uu.se, sshtylyov@ru.mvista.com

On Thu, 16 Aug 2007 21:19:40 +0100, Alan Cox wrote:
> > > Unfortunately this breaks pata_pdc2027x on my PowerMac G3:
> > 
> > Did this ever get resolved?
> 
> All went quiet so I assume its gone away ?

-ENOTIME

The regression is still there in 2.6.23-rc3 (I just checked),
but I haven't had time to debug it yet. I'll try to do something
about it this weekend.
