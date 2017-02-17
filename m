From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] pata: remove the at91 driver
Date: Fri, 17 Feb 2017 14:42:35 +0100
Message-ID: <20170217144235.1fd12c80@bbrezillon>
References: <CGME20170217093732epcas5p463c32b21e7c71000d01d15c54333c1f6@epcas5p4.samsung.com>
        <1487324200-17517-1-git-send-email-boris.brezillon@free-electrons.com>
        <1599704.hbkP4KrUDJ@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40550 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933545AbdBQNmu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2017 08:42:50 -0500
In-Reply-To: <1599704.hbkP4KrUDJ@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, 17 Feb 2017 13:36:08 +0100
Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:

> Hi,
> 
> On Friday, February 17, 2017 10:36:40 AM Boris Brezillon wrote:
> > This driver is orphan since commit 2e591e7b3ac2 ("ARM: at91: remove
> > at91sam9261/at91sam9g10 legacy board support"). Given that nobody cared
> > adding DT support to it, it probably means it's no longer used and is
> > thus a good candidate for removal.  
> 
> The exact commit which removed PATA support for AT91SAM9260 seems to
> be b2026f708e09 ("ARM: at91: remove at91sam9260/at91sam9g20 legacy
> board support").

Indeed. I'll fix the commit message and send a new version.

> 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>  
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks,

Boris


