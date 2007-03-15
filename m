From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Thu, 15 Mar 2007 11:20:05 -0700 (PDT)
Message-ID: <20070315182005.944.qmail@web812.biz.mail.mud.yahoo.com>
References: <45F9851E.8000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web812.biz.mail.mud.yahoo.com ([209.191.90.85]:41352 "HELO
	web812.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751316AbXCOS0r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 14:26:47 -0400
In-Reply-To: <45F9851E.8000709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

--- Tejun Heo <htejun@gmail.com> wrote:

> The driver is seriously broken regarding LBA48 support.  The timeout
> goes away if max_sectors is decreased to ATA_MAX_SECTORS - 1, doh.  But
> both the reading and writing are seriously broken.  I can't tell whether
> they end up in the wrong sectors or garbage is transferred to/from the
> right sectors.

I couldn't figure it out, either.  There were some times early on that I
failed it all the way down to PIO4 and it worked just fine.  But, with DMA
forget it.  

> I'm really close to marking this device broken or we'll need to
> implement a mechanism to veto LBA48 device from LLD (may be negative
> return from ->dev_config).

Are you sure it's an LBA48 issue?  I was never sure how to check
this but in my banging around, I never saw anything in the HOB fields.
 
> Reading the sunix driver, I can't find any relevant workaround.  It
> never seems to initialize ctl address.  I'm curious whether the sunix
> driver can do LBA48.  Bob, are you interested in testing this?

Sure.  I'll need to reorganize hardware again, but it'll give me something
to do till the steelhead start their spring run.  :)

Bob
