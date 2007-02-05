From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Mon, 5 Feb 2007 13:55:10 -0800 (PST)
Message-ID: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>
References: <45C7696E.3000907@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web803.biz.mail.mud.yahoo.com ([209.191.90.76]:39582 "HELO
	web803.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964778AbXBEV4Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 16:56:25 -0500
In-Reply-To: <45C7696E.3000907@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

--- Mark Lord <liml@rtr.ca> wrote:
> Bob Stewart wrote:
> > By the way, 
> > the drive I'm using to play with this now is only an 80GB drive.
> 
> Most newer drives are still capable of LBA48, even when they are
> small enough to not require it for sector addressing.
> 
> If a large enough I/O (more than 256 sectors) is generated,
> then libata may use LBA48 to complete a request on such drives.

Is there an easy way to tell whether the command was sent as 
LBA48, say, in the driver's bmdma_start function or even in the 
hardreset function after the fact?  One of my tests was using a 64 
sector limit, with pretty much the same results.  I always test against 
the same file, and the results, including the number of timeouts, are 
different from test to test.
