From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Sat, 24 Mar 2007 02:59:29 -0700 (PDT)
Message-ID: <20070324095929.10553.qmail@web802.biz.mail.mud.yahoo.com>
References: <4604D564.9010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web802.biz.mail.mud.yahoo.com ([209.191.90.75]:38056 "HELO
	web802.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753412AbXCXJ7a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Mar 2007 05:59:30 -0400
In-Reply-To: <4604D564.9010806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org


--- Tejun Heo <htejun@gmail.com> wrote:

> Bob Stewart wrote:
> > I wonder if this card of mine is what's bad.  I loaded Sarge 2.4 and the

> My bet is on broken driver.  sunix driver doesn't seem like it was 
> written carefully.  Anyways, thanks for testing.  It seems we'll either 
> have to implement adma mode.  I'll mark the driver broken for 2.6.21. 
> Thanks.
> -- 
> tejun

Well, I'll probably mess with trying to convert one of the adma drivers over
to work with this hardware.  But, I've never done this before, so it probably
won't come to much.

Bob
