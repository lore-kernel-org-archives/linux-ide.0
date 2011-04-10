From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] support for PMP used in TT BlackX Duet drive dock
Date: Mon, 11 Apr 2011 06:30:20 +0900
Message-ID: <20110410213020.GD9673@mtj.dyndns.org>
References: <201104071854.10911.morpheus.ibis@gmail.com>
 <201104081005.37191.morpheus.ibis@gmail.com>
 <20110408155918.GA3871@mtj.dyndns.org>
 <201104081913.25191.morpheus.ibis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46903 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758033Ab1DJVa0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Apr 2011 17:30:26 -0400
Received: by iwn34 with SMTP id 34so5052951iwn.19
        for <linux-ide@vger.kernel.org>; Sun, 10 Apr 2011 14:30:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104081913.25191.morpheus.ibis@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Herrmann <morpheus.ibis@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

On Fri, Apr 08, 2011 at 07:13:24PM +0200, Pavel Herrmann wrote:
> On Friday 08 of April 2011 17:59:18 Tejun Heo wrote:
> > Hey,
> > 
> > Can you please do the followings?
> > 
> > * Post dmesg w/o the patch.
> > 
> > * Try different combinations of the flags and see which ones are
> >   essential.
> > 
> > Thanks.
> 
> Hi
> 
> NO_LPM seems to be unnecessary, but as I don't do link PM on my desktop I 
> wouldn't drop it (when all other quirky PMPs need it), unless someone else 
> with a laptop (or using LPM on desktop) confirms it.
> 
> dmesgs attached (ata8 is JMB363, ata6 is ICH10R), filenames are self-expanatory

It's sad to see the PMP to require both quirks.  The SIMG ones were
first-gens so somewhat understandable.  Eh well, please feel free to
add "Acked-by: Tejun Heo <tj@kernel.org>".  Thanks.

-- 
tejun
