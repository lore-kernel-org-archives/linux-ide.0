From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH] ata: ahci: Enable enclosure management via LED (resend)
Date: Thu, 25 Oct 2007 23:35:11 +0200
Message-ID: <200710252335.12975.ioe-lkml@rameria.de>
References: <20071024155845.5129d6a4.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757705AbXJYVdB@vger.kernel.org>
In-Reply-To: <20071024155845.5129d6a4.kristen.c.accardi@intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@openedhand.com>
List-Id: linux-ide@vger.kernel.org

Hi Kristen,

On Thursday 25 October 2007, Kristen Carlson Accardi wrote:
> Enable enclosure management via LED
> 
> As described in the AHCI spec, some AHCI controllers may support 
> Enclosure management via a variety of protocols.  This patch
> adds support for the LED message type that is specified in 
> AHCI 1.1 and higher.

Linux has a LED subsystem for that. May I suggest, that you just register
these leds and let userspace handle them via that via the LED API?

The LED userspace API is described in Documentation/leds-class.txt
and the headers for registering LEDs is linux/leds.h under include/

Since you explicitly WANT user space to control these, that should
be the right API. 

Richard, what do YOU think?


Best Regards

Ingo Oeser
