From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PATA driver for ide-pmac?
Date: Thu, 09 Nov 2006 08:42:45 +1100
Message-ID: <1163022165.28571.743.camel@localhost.localdomain>
References: <20061108133735.GI16523@curie-int.orbis-terrarum.net>
	 <45521A2E.1090503@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54740 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1754301AbWKHVnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 16:43:53 -0500
In-Reply-To: <45521A2E.1090503@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Robin H. Johnson" <robbat2@orbis-terrarum.net>, linux-ide@vger.kernel.org

On Wed, 2006-11-08 at 12:55 -0500, Jeff Garzik wrote:
> Robin H. Johnson wrote:
> > Just looking around, I don't see one, but maybe I'm not looking in the
> > right places.
> > 
> > Has anybody started on a libata-based replacement for the ide-pmac
> > (BLK_DEV_IDEDMA_PMAC) at all?
> 
> Not AFAIK.  It's probably pretty low on benh's priority list, since 
> there's a working driver now.  But a libata driver is nonetheless 
> welcomed :)

It's as you guessed. On my list, but pretty low at the moment since I'm
totally swamped with Cell related stuffs at the moment.

Cheers,
Ben.


