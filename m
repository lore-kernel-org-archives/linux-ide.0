From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Correctly prevent IDE timer expiry function to run if request was already handled
Date: Fri, 6 Apr 2007 22:51:09 +0200
Message-ID: <200704062251.09350.bzolnier@gmail.com>
References: <20070406173603.GA82722@freefall.freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:35041 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953AbXDFVEe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Apr 2007 17:04:34 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1232788uga
        for <linux-ide@vger.kernel.org>; Fri, 06 Apr 2007 14:04:32 -0700 (PDT)
In-Reply-To: <20070406173603.GA82722@freefall.freebsd.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Friday 06 April 2007, Suleiman Souhlal wrote:
> It is possible for the timer expiry function to run even though the
> request has already been handled: ide_timer_expiry() only checks that
> the handler is not NULL, but it is possible that we have handled a
> request (thus clearing the handler) and then started a new request
> (thus starting the timer again, and setting a handler). 
> 
> A simple way to exhibit this is to set the DMA timeout to 1 jiffy and
> run dd: The kernel will panic after a few minutes because
> ide_timer_expiry() tries to add a timer when it's already active.
> 
> To fix this, we simply add a request generation count that gets
> incremented at every interrupt, and check in ide_timer_expiry() that
> we have not already handled a new interrupt before running the expiry
> function.
> 
> Signed-off-by:	Suleiman Souhlal <suleiman@google.com>

applied, thanks for fixing this
