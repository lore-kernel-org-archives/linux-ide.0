From: David Miller <davem@davemloft.net>
Subject: Re: 2.6.34-rc2 breaks via82cxxx Host Protected Area
Date: Sat, 27 Mar 2010 07:57:00 -0700 (PDT)
Message-ID: <20100327.075700.226783069.davem@davemloft.net>
References: <20100326232104.GA10769@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39967
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752195Ab0C0O4h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Mar 2010 10:56:37 -0400
In-Reply-To: <20100326232104.GA10769@spacedout.fries.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: david@fries.net
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: David Fries <david@fries.net>
Date: Fri, 26 Mar 2010 18:21:04 -0500

> The kernel fails to see the entire disk with 2.6.34-rc2 with VIA
> vt82c586b chipset.  I tracked it down to commit
> f931a5d5785d7b7c44871bd7ad2762e29dfddf29 "via82cxxx: workaround h/w
> bugs" and reverting just that one solves the problem, or just
> commenting out just one outb write in that change.

I've reverted Bart's change and will push that out to Linus.

Thanks for your report.
