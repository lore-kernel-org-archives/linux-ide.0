From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Date: Sat, 1 Dec 2007 21:57:55 -0600
Message-ID: <20071202035755.GA3116@lixom.net>
References: <20071127153708.GA12490@localhost.localdomain> <4751E639.8090308@garzik.org> <20071201235810.GA2635@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:41607 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986AbXLBDyR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 22:54:17 -0500
Content-Disposition: inline
In-Reply-To: <20071201235810.GA2635@zarina>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbou@mail.ru>
Cc: Jeff Garzik <jeff@garzik.org>, Paul Mundt <lethal@linux-sh.org>, linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org

On Sun, Dec 02, 2007 at 02:58:10AM +0300, Anton Vorontsov wrote:
> On Sat, Dec 01, 2007 at 05:54:49PM -0500, Jeff Garzik wrote:
> while (1) {
> 	send_patches();
> 
> 	if (ack_collected(PaulM) && ack_collected(PowerPC_people))
> 		break;
> 
> 	sleep(wait_for_comments_timeout); <-- currently here.

I still haven't seen you address the compatible comments (that
pata-platform is suboptimal). Or did I miss some respin of the patches?


-Olof
