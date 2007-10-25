From: Richard Purdie <rpurdie@openedhand.com>
Subject: Re: [PATCH] ata: ahci: Enable enclosure management via LED (resend)
Date: Thu, 25 Oct 2007 22:47:25 +0100
Message-ID: <1193348845.5697.25.camel@localhost.localdomain>
References: <20071024155845.5129d6a4.kristen.c.accardi@intel.com>
	 <200710252335.12975.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:46537 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbXJYWHI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 18:07:08 -0400
In-Reply-To: <200710252335.12975.ioe-lkml@rameria.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2007-10-25 at 23:35 +0200, Ingo Oeser wrote:
> On Thursday 25 October 2007, Kristen Carlson Accardi wrote:
> > Enable enclosure management via LED
> > 
> > As described in the AHCI spec, some AHCI controllers may support 
> > Enclosure management via a variety of protocols.  This patch
> > adds support for the LED message type that is specified in 
> > AHCI 1.1 and higher.
> 
> Linux has a LED subsystem for that. May I suggest, that you just register
> these leds and let userspace handle them via that via the LED API?
> 
> The LED userspace API is described in Documentation/leds-class.txt
> and the headers for registering LEDs is linux/leds.h under include/
> 
> Since you explicitly WANT user space to control these, that should
> be the right API. 
> 
> Richard, what do YOU think?

If you're exporting LEDs to userspace, the LED API was designed to do
just that...

Cheers,

Richard



