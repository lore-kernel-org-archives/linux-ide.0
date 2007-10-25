From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH] ata: ahci: Enable enclosure management via LED (resend)
Date: Fri, 26 Oct 2007 01:32:17 +0200
Message-ID: <200710260132.19049.ioe-lkml@rameria.de>
References: <20071024155845.5129d6a4.kristen.c.accardi@intel.com> <200710252335.12975.ioe-lkml@rameria.de> <20071025145047.1c5e96f3.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:56348 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbXJYX37 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 19:29:59 -0400
In-Reply-To: <20071025145047.1c5e96f3.kristen.c.accardi@intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@openedhand.com>

On Thursday 25 October 2007, Kristen Carlson Accardi wrote:
> I did look into using the LED class for this, but it didn't appropriate
> as I wanted the leds to be associated with a particular disk, and not
> with the platform as a whole.  It seemed to me that the led_class was 
> a bit of overkill for what we needed to do here, since we just need 
> on/off and nothing else.

Maybe. But didn't you want mdadm to control it? Then it would make sense.

But you have a point in the LED API missing the ability to associate 
a LED to a specific device (e.g. where it is installed :-).

So I'm fine either way, since I see you point.


Best Regards

Ingo Oeser
