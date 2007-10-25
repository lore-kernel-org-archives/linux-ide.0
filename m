From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] ata: ahci: Enable enclosure management via LED (resend)
Date: Thu, 25 Oct 2007 14:50:47 -0700
Message-ID: <20071025145047.1c5e96f3.kristen.c.accardi@intel.com>
References: <20071024155845.5129d6a4.kristen.c.accardi@intel.com>
	<200710252335.12975.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:61216 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbXJYVvH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 17:51:07 -0400
In-Reply-To: <200710252335.12975.ioe-lkml@rameria.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@openedhand.com>

On Thu, 25 Oct 2007 23:35:11 +0200
Ingo Oeser <ioe-lkml@rameria.de> wrote:

> Hi Kristen,
> 
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
> 
> 
> Best Regards
> 
> Ingo Oeser
> 

I did look into using the LED class for this, but it didn't appropriate
as I wanted the leds to be associated with a particular disk, and not
with the platform as a whole.  It seemed to me that the led_class was 
a bit of overkill for what we needed to do here, since we just need 
on/off and nothing else.
