From: Nick Warne <nick@ukfsn.org>
Subject: Re: Peculiar out-of-sync boot log lines
Date: Sun, 2 Dec 2007 17:31:30 +0000
Message-ID: <20071202173130.1c645dbc@linuxamd.linicks.net>
References: <20071129193728.2f1c237e@linuxamd.linicks.net>
	<474F1D24.4070009@rtr.ca>
	<200712012259.35152.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:45492 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906AbXLBRbj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 12:31:39 -0500
In-Reply-To: <200712012259.35152.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, 1 Dec 2007 22:59:35 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

 
> Thanks for reporting/debugging it guys!
> 
> > Something in there needs to insert a '\n' before the "skipping
> > word" message. Since it doesn't do that right now, the KERN_DEBUG
> > string appears as "<7>"
> 
> This seems like a good occasion to fix ide_dma_verbose() for good
> so... :)
 
> This patch should fix the following problem with out-of-sync IDE
> messages reported by Nick Warned:
...

I was only reporting it... not warning anybody ;-)

Nick
-- 
Free Software Foundation Associate Member 5508
