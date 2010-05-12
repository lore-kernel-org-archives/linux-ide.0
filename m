From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform
 driver
Date: Thu, 13 May 2010 00:13:15 +0100
Message-ID: <20100513001315.149bbb66@lxorguk.ukuu.org.uk>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com>
	<4BE6910D.9070504@ru.mvista.com>
	<4BE69C81.2070703@gmail.com>
	<4BE6BA74.10200@mvista.com>
	<4BE74EEE.5060307@gmail.com>
	<4BE7D714.9010006@ru.mvista.com>
	<20100511105531.39670354@lxorguk.ukuu.org.uk>
	<4BEB0FFD.1090701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42070 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756313Ab0ELXGm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 May 2010 19:06:42 -0400
In-Reply-To: <4BEB0FFD.1090701@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Graeme Russ <graeme.russ@gmail.com>, linux-ide@vger.kernel.org

> > I don't think ide-platform matters in this case.
> 
>    You've just supported a patch restoring feature parity between 
> pata_platform and ide-platfrom WRT IRQ flags. ;-)

Because it was trivial to do.

>    Yes, but this needs to be *done* too, preferrably by the author of 
> the original patch and simultaneously with it. We can't accept a single 
> patch that only touches pata_platform.

Sure - or support it in both. I've no problem with both supporting that
function, just with legacy code blocking progress.

>    Well, with 8250 we still don't allow for overriding things at the 
> board level, via the platform data callbacks.

Oh yes we do. Platform specific drivers can directly override the access
operators and they do some truely horrible platform specific stuff in the
overridden operators.

And the great thing - nobody else has to know what the board vendors have
been on..
