From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Thu, 28 Aug 2008 20:11:36 +0200
Message-ID: <20080828181136.GC24539@xi.wantstofly.org>
References: <200808261045.33241.elendil@planet.nl> <200808281125.14012.elendil@planet.nl> <c70ff3ad0808280353n18967a9frf414091ae768030c@mail.gmail.com> <200808281911.28484.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([83.160.184.112]:34353 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbYH1SLi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 14:11:38 -0400
Content-Disposition: inline
In-Reply-To: <200808281911.28484.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: saeed bishara <saeed.bishara@gmail.com>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>

On Thu, Aug 28, 2008 at 07:11:27PM +0200, Frans Pop wrote:

> > can you try setting bit 0 of the 0xf108002c then run some io?
> 
> Tried that using Grant's suggestion (thanks!), but setting the bit does 
> not seem to take:
> 
> $ sudo mmio_rd f108002c 1
> 0x0000000000000000
> $ sudo mmio_wr f108002c 1
> 0000000000000000 -> 0000000000000001
> $ sudo mmio_rd f108002c 1
> 0x0000000000000000
> 
> Am I doing something wrong here?

Can you try devmem2?  (That should be in Debian, I think.)
