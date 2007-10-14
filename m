From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Date: Sun, 14 Oct 2007 13:31:34 -0400
Message-ID: <47125276.7070703@garzik.org>
References: <200708172051.l7HKpNtq009682@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32870 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035AbXJNRbr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Oct 2007 13:31:47 -0400
In-Reply-To: <200708172051.l7HKpNtq009682@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, albertl@mail.com, bahadir.balban@gmail.com, dwm@enoyolf.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, sshtylyov@ru.mvista.com

Mikael Pettersson wrote:
> On Thu, 16 Aug 2007 21:19:40 +0100, Alan Cox wrote:
>>>> Unfortunately this breaks pata_pdc2027x on my PowerMac G3:
>>> Did this ever get resolved?
>> All went quiet so I assume its gone away ?
> 
> -ENOTIME
> 
> The regression is still there in 2.6.23-rc3 (I just checked),
> but I haven't had time to debug it yet. I'll try to do something
> about it this weekend.

Still broken?

	Jeff



