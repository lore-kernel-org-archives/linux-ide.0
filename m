From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Correctly prevent IDE timer expiry function to run if
 request was already handled
Date: Fri, 06 Apr 2007 23:22:02 +0400
Message-ID: <46169DDA.6020008@ru.mvista.com>
References: <20070406173603.GA82722@freefall.freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751857AbXDFT1p@vger.kernel.org>
In-Reply-To: <20070406173603.GA82722@freefall.freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Suleiman Souhlal wrote:

> It is possible for the timer expiry function to run even though the
> request has already been handled: ide_timer_expiry() only checks that
> the handler is not NULL, but it is possible that we have handled a
> request (thus clearing the handler) and then started a new request
> (thus starting the timer again, and setting a handler). 

> A simple way to exhibit this is to set the DMA timeout to 1 jiffy and
> run dd: The kernel will panic after a few minutes because
> ide_timer_expiry() tries to add a timer when it's already active.

> To fix this, we simply add a request generation count that gets
> incremented at every interrupt, and check in ide_timer_expiry() that
> we have not already handled a new interrupt before running the expiry
> function.

    Couldn't this be addressed by simply changing add_timer() to mod_timer()?

MBR, Sergei
