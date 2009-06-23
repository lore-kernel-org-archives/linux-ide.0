From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] IDE: Silent compiler warning in ide_pio_bytes()
Date: Tue, 23 Jun 2009 11:52:07 +0200
Message-ID: <20090623115207.58c4ff59@hyperion.delvare>
References: <20090622211052.45b3cfc5@hyperion.delvare>
	<20090622.161059.69648151.davem@davemloft.net>
	<20090623085324.03b25bb9@hyperion.delvare>
	<20090623.023211.06996077.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:22606 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbZFWJwR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 05:52:17 -0400
In-Reply-To: <20090623.023211.06996077.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, petkovbb@googlemail.com

On Tue, 23 Jun 2009 02:32:11 -0700 (PDT), David Miller wrote:
> From: Jean Delvare <khali@linux-fr.org>
> Date: Tue, 23 Jun 2009 08:53:24 +0200
> 
> > I fear somebody else will have to do that. I personally think
> > uninitialized_var() should not have been invented, I don't want to have
> > my name associated with any of its uses for it will inevitably lead to
> > bugs in the future.
> > 
> > I'll resubmit a patch not fixing the warning (because the rest is still
> > useful I think) but that's about all I can offer.
> 
> The alternative will be that someone will ask "when does the '0' case
> get used" and have to sort through that and potentially ask people
> here on the lists.

The comment I added, /* Silent compiler warning */, should have
answered this question pretty clearly, methinks.

> But you posted and update patch which solves the problem in an
> even nicer way :-)

Is it enough to silent the warning for you? I wasn't for me (gcc
4.3.2), although I expected it to... gcc should be able to see there is
no code path leading to the variable being used uninitialized.

-- 
Jean Delvare
