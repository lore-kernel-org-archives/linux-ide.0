From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes passed from user-space
Date: Mon, 2 Jul 2007 21:53:16 +0200
Message-ID: <200707022153.16964.bzolnier@gmail.com>
References: <200706302110.20766.bzolnier@gmail.com> <200707022055.13683.bzolnier@gmail.com> <46894F3B.7050600@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:39868 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbXGBThO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 15:37:14 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2510311mue
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 12:37:12 -0700 (PDT)
In-Reply-To: <46894F3B.7050600@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Monday 02 July 2007, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Add the new code inside #ifdef X86, marking alim15x3 X86-only would be
> > on over-kill...

My reply is taken out of context.

> Ugh.  That's not how we do Linux development.  It is better to convert 
> the new code and wait for alpha/sparc users to scream, than add platform 
> ifdefs.  To do so creates divergent code paths, that runs counter to 
> Linux's goal of a portable driver.

I insisted on changes being done in "Linux style" since the begging but you've
complained about it and requested prior testing of the changes on alpha/sparc.

Maybe I misunderstood your first mail, if this is the case then we are fully
agreed and there are no discrepancies in our views on development style.

Thanks,
Bart
