From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] PATA host controller driver for ep93xx
Date: Tue, 3 Apr 2012 07:41:15 +0000
Message-ID: <201204030741.16596.arnd@arndb.de>
References: <4F7418E7.4060500@metasoft.pl> <4F795AD1.4070101@metasoft.pl> <4F7A5781.3000507@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56482 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab2DCIUR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Apr 2012 04:20:17 -0400
In-Reply-To: <4F7A5781.3000507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Mallon <rmallon@gmail.com>
Cc: Rafal Prylowski <prylowski@metasoft.pl>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, hsweeten@visionengravers.com, Sergei Shtylyov <sshtylyov@mvista.com>, joao.ramos@inov.pt

On Tuesday 03 April 2012, Ryan Mallon wrote:
> On 02/04/12 17:52, Rafal Prylowski wrote:
>
> > Yes, I already prepared a version of the driver in which IDE register
> > addresses are coded as enums instead of using ata_port->ioaddr structure. 
> > I will post updated version, when I get feedback from Ryan if enums
> > or defines are preferred.
> 
> I would prefer defines, simply because it looks odd having an enum which
> has multiple names defined to the same value, and most drivers tend to
> use defines rather than enums for registers. It's not a big deal though,
> and certainly not a show stopper.

I tend to prefer enums, but I agree that it's a minor issue and I generally
don't even mention it in reviews.

	Arnd

