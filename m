From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] IDE: Silent compiler warning in ide_pio_bytes()
Date: Tue, 23 Jun 2009 08:53:24 +0200
Message-ID: <20090623085324.03b25bb9@hyperion.delvare>
References: <20090622211052.45b3cfc5@hyperion.delvare>
	<20090622.161059.69648151.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:20032 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbZFWGxm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 02:53:42 -0400
In-Reply-To: <20090622.161059.69648151.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@googlemail.com>

Hi Dave, Borislav,

On Mon, 22 Jun 2009 16:10:59 -0700 (PDT), David Miller wrote:
> From: Jean Delvare <khali@linux-fr.org>
> Date: Mon, 22 Jun 2009 21:10:52 +0200
> 
> > PageHighMem() isn't cheap so avoid calling it several times on the
> > same page. I had the hope that this would silent the following
> > compilation warning:
> > 
> > drivers/ide/ide-taskfile.c: In function 'ide_pio_bytes':
> > drivers/ide/ide-taskfile.c:229: warning: 'flags' may be used uninitialized in this function
> > 
> > which is a false positive, but it did not. So let's just initialize the
> > flags and be done with it, so that other developers don't waste their
> > time looking at it.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Like Borislav, I think it's better to use uninitialized_var().
> It describes the situation completely.
> 
> Please submit an updated patch, and thank you for this.

I fear somebody else will have to do that. I personally think
uninitialized_var() should not have been invented, I don't want to have
my name associated with any of its uses for it will inevitably lead to
bugs in the future.

I'll resubmit a patch not fixing the warning (because the rest is still
useful I think) but that's about all I can offer.

-- 
Jean Delvare
