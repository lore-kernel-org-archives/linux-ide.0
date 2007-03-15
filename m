From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Fri, 16 Mar 2007 02:40:46 +0900
Message-ID: <45F9851E.8000709@gmail.com>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:14829 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbXCORkw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 13:40:52 -0400
Received: by wr-out-0506.google.com with SMTP id 41so220595wry
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 10:40:52 -0700 (PDT)
In-Reply-To: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Hello,

Bob Stewart wrote:
> Is there an easy way to tell whether the command was sent as 
> LBA48, say, in the driver's bmdma_start function or even in the 
> hardreset function after the fact?  One of my tests was using a 64 
> sector limit, with pretty much the same results.  I always test against 
> the same file, and the results, including the number of timeouts, are 
> different from test to test.

The driver is seriously broken regarding LBA48 support.  The timeout
goes away if max_sectors is decreased to ATA_MAX_SECTORS - 1, doh.  But
both the reading and writing are seriously broken.  I can't tell whether
they end up in the wrong sectors or garbage is transferred to/from the
right sectors.

I'm really close to marking this device broken or we'll need to
implement a mechanism to veto LBA48 device from LLD (may be negative
return from ->dev_config).

Reading the sunix driver, I can't find any relevant workaround.  It
never seems to initialize ctl address.  I'm curious whether the sunix
driver can do LBA48.  Bob, are you interested in testing this?

Thanks.

-- 
tejun
