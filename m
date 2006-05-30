From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fwd: [patch 1/1] sgiioc4: use mmio ops instead of port io
Date: Mon, 29 May 2006 20:18:36 -0700
Message-ID: <20060529201836.dd504453.akpm@osdl.org>
References: <20060530013219.GA604159@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:29143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751164AbWE3DOS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 May 2006 23:14:18 -0400
In-Reply-To: <20060530013219.GA604159@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org

On Mon, 29 May 2006 18:32:19 -0700
Jeremy Higdon <jeremy@sgi.com> wrote:

> I sent this a couple of weeks ago to linux-ide, but I didn't see
> any response.

It's not exactly a hive of activity lately.

>  This patch fixes a bug in sgiioc4 where it was using
> the default IDE port I/O operations instead of MMIO.  I don't know
> who's maintaining linux-ide these days, so I'm forwarding directly
> to Linux and Andrew.
> 
> The IDE part of the IOC4 chip uses MMIO to map the chip registers.
> Unfortunately, the sgiioc4 driver uses the default port IO operations,
> which happens to have worked for the past few years.  That's about
> to change, however, thus this change from inX/outX to readX/writeX.

The typecasts in there are getting out of control.  But this patch is a
victim, not a perpetrator ;)

I'll queue it for the next Linus batch, thanks.
