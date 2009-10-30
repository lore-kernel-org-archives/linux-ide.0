From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: update Kconfig text to mark as deprecated
Date: Thu, 29 Oct 2009 17:30:28 -0700 (PDT)
Message-ID: <20091029.173028.248393897.davem@davemloft.net>
References: <4AE64FCC.4030102@gmail.com>
	<20091029.031344.102288703.davem@davemloft.net>
	<51f3faa70910291719kecb5edcp3b8812981b69acb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49905
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756041AbZJ3AaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Oct 2009 20:30:05 -0400
In-Reply-To: <51f3faa70910291719kecb5edcp3b8812981b69acb1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockrwd@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Robert Hancock <hancockrwd@gmail.com>
Date: Thu, 29 Oct 2009 18:19:03 -0600

> I think people would be better off just updating their fstab and being
> done with it.. preferably switching to something like mounting by
> label or UUID so that things just work even if the devices get
> reordered when they rearrange their cables or add a new controller,
> etc. Every Fedora/Red Hat-derived OS has set things up this way by
> default for years..

You can't just make devices dissapear without providing some
kernel option or similar that keeps things working.

My very own machines will break unless that happens.

And yes I absolutely do consider it too onerous to change my fstab
because I have to (or want to be able to) go back to older kernels
which will only have the IDE stack enabled.  I refuse to have to
monkey around with my fstab every time I want to go back and forth.

And god forbid I actually want to test some -stable IDE fix on this
machine :-)

And I know I won't be the only person in this kind of situation.

So, proceeding in any other way is really a non-starter.
