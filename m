From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [git patches] ide update
Date: Thu, 18 Aug 2005 15:19:39 -0700
Message-ID: <29495f1d050818151959d2bfa7@mail.gmail.com>
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
	 <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:20713 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932496AbVHRWTl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 18:19:41 -0400
Received: by zproxy.gmail.com with SMTP id r28so358621nza
        for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 15:19:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 8/18/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Thu, 18 Aug 2005, Bartlomiej Zolnierkiewicz wrote:
> >
> > 3 obvious fixes + support for 2 new controllers
> > (just new PCI IDs).
> 
> Btw, things like this:
> 
>         +#define IDEFLOPPY_TICKS_DELAY  HZ/20   /* default delay for ZIP 100 (50ms) */
> 
> are just bugs waiting to happen.

<snip>

Shouldn't this be msecs_to_jiffies(50) to avoid the rounding issues I
mentioned on LKML a bit ago?

Thanks,
Nish
