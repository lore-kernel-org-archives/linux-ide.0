From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Correctly prevent IDE timer expiry function to run if request was already handled
Date: Fri, 6 Apr 2007 23:35:26 +0200
Message-ID: <200704062335.26560.bzolnier@gmail.com>
References: <20070406173603.GA82722@freefall.freebsd.org> <50660.65.57.245.11.1175892938.squirrel@ssl.mu.org> <4616B70B.3070501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:50924 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbXDFV0W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Apr 2007 17:26:22 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1234532uga
        for <linux-ide@vger.kernel.org>; Fri, 06 Apr 2007 14:26:20 -0700 (PDT)
In-Reply-To: <4616B70B.3070501@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Suleiman Souhlal <ssouhlal@freebsd.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Friday 06 April 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Suleiman Souhlal wrote:

> > The reason the timer could have been active at that point, before applying
> > this patch, is that we try to dispatch a new request after handling one.
> > The new request will then have its own expiry timer, along with a handler.
> > Since  before this patch ide_timer_expiry() only looked at whether or not
> > a handler was present, it would incorrectly think the request had not been
> > handled already, and incorrectly tried to restart the timer.
> 
>     Hm, I'm still not sure why this happens at all, probably need to try 
> reproducing it (unless you post a stack trace :-).

not a stack trace but should explain the issue a bit:

...
ide_timer_expiry
	-> just before taking ide_lock IRQ happens
...
ide_intr
	-> completes the command and queues the next one
...
ide_timer_expiry (resumed)
	-> takes ide_lock
	-> the bug happens ;)

should be even easier to trigger it on SMP since ide_timer_expiry
may be running at the same time as ide_intr

Bart
