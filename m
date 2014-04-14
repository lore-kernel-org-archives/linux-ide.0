From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
Date: Mon, 14 Apr 2014 18:13:07 +0200
Message-ID: <10589751.qhi630WAFs@amdc1032>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <16639486.i0jTGsaDYr@amdc1032> <20140414180142.0dd63a1f@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49296 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbaDNQNT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 12:13:19 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N4100HCI3Q6PP00@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 15 Apr 2014 01:13:18 +0900 (KST)
In-reply-to: <20140414180142.0dd63a1f@skate>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday, April 14, 2014 06:01:42 PM Thomas Petazzoni wrote:
> Dear Bartlomiej Zolnierkiewicz,
> 
> On Mon, 14 Apr 2014 17:53:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > >  * Fixed the module alias name. Suggested by Bartlomiej
> > >    Zolnierkiewicz.
> > 
> > Well, you could have also added a comment explaining the lack of
> > the Power Management support..
> 
> True, sorry for this. Should I resend a new version of the patch series
> with an indication about this in the commit log? Or is this OK as it is?

Please include the comment in the next revision if this is not too much
trouble (I assume that you would like to do another re-spin just to add
Acked-by/Reviewed-by tags anyway).

> Note that working on power management support is part of our mid-term
> TODO list for this platform, so it will not remain unimplemented
> forever.

OK, good to hear that.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

