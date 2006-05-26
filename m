From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
 c pl atform
Date: Fri, 26 May 2006 07:41:24 -0400
Message-ID: <4476E964.90509@rtr.ca>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net> <1147935734.17679.93.camel@localhost.localdomain> <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca> <20060526083931.GA23938@powerlinux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:27024 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932331AbWEZLl0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 07:41:26 -0400
In-Reply-To: <20060526083931.GA23938@powerlinux.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>

Sven Luther wrote:
> I'm trying to use a Marvell 88SX5081 based card here in my pegasos machine,
> and i never got it working with the libata driver, even with the patches Zang
> provided (and 2.6.16 though, maybe i should update to a newer version). The
> marvell provided driver worked though at some time.
> 
> Would it be possible to have access to your work, in order to not duplicate
> effort or something ? 

All of the relevant bits of "my work" are now in Jeff's upstream libata tree,
from the recently posted sata_mv patches.

After struggling with bad SDRAM earlier this week, I now have Ubuntu installed
and running reliably on my G3 box here.  Next step is to upgrade the kernel
to something modern, and add in the latest sata_mv.

After that, I'll try my own 6081 Marvell card in it, and hopefully see the 
same failures as you.. hopefully!

Cheers
