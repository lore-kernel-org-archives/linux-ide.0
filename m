From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Thu, 26 Jul 2007 22:13:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0707262156250.6614@poirot.grange>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
 <Pine.LNX.4.60.0707252130090.6234@poirot.grange> <20070725213925.2f25906c@the-village.bc.nu>
 <Pine.LNX.4.60.0707262136530.6614@poirot.grange> <46A8FB86.2010907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:55696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934693AbXGZUN7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 16:13:59 -0400
In-Reply-To: <46A8FB86.2010907@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thu, 26 Jul 2007, Sergei Shtylyov wrote:

> Guennadi Liakhovetski wrote:
> 
> > Ok, thanks for the explanation Alan. So, there's no technical argument, 
> > just "being nice to the users", and add a new driver, which we know we'll 
> > have to remove soon, thus having to persuade its users, who by that time 
> 
>     Define "soon". :-)

"Soon" in this case means, we NOW have a replacement driver and we aim at 
deprecating the IDE driver in its favour.

> > will get used to it and will not want to invest money into switching to 
> > another one...
> 
>     Invest into what if the drivers are functionally identical?

For example, into porting user space (replace hdx with sdx). And even 
switching to a "functionally identical" driver requires a new complete 
testing cycle... No, I won't be in that situation, so, it's not my money 
I'm worrying about. But I know there are companies for whom releasing a 
new version of /etc/fstab is a considerable expense... Not that I cared 
about them anyway.

Thanks
Guennadi
---
Guennadi Liakhovetski
