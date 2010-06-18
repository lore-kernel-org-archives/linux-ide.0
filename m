From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Fri, 18 Jun 2010 17:02:27 +0200
Message-ID: <20100618150227.GA7922@liondog.tnic>
References: <20100617080726.GA13713@liondog.tnic>
 <20100617150008.16a5e653@cpc>
 <20100618074510.GD32368@liondog.tnic>
 <20100618150800.4a3b1d68@cpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42294 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933582Ab0FRPCc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jun 2010 11:02:32 -0400
Content-Disposition: inline
In-Reply-To: <20100618150800.4a3b1d68@cpc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans Mueller <hans42mueller@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

From: Hans Mueller <hans42mueller@googlemail.com>
Date: Fri, Jun 18, 2010 at 03:08:00PM +0200

> > [...] and do catch the _complete_ output again.

> Can you tell me how to do this? Can I make the kernel to wait until I
> connect with firescope? As far as I know, I can only connect if the
> kernel already loaded / initialized the firewire drivers, when using
> firescope. Therefore I cannot 'connect' before the kernel started
> booting, can I?

I haven't tried the firewire thing yet so I can't help you there. But
basically what I'm saying is simply try catching as much output as you
can and send me the whole thing you've caught - maybe that'll suffice.

Thanks.

-- 
Regards/Gruss,
    Boris.
