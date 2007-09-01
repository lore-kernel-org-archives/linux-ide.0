From: Satyam Sharma <satyam@infradead.org>
Subject: Re: [PATCH] drivers/firmware: const-ify DMI API and internals
Date: Sun, 2 Sep 2007 02:51:53 +0530 (IST)
Message-ID: <alpine.LFD.0.999.0709020249190.20781@enigma.security.iitk.ac.in>
References: <20070901142719.GA31990@havoc.gtf.org>
 <200709011833.08581.ak@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:37464 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbXIAVJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 17:09:23 -0400
In-Reply-To: <200709011833.08581.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, len.brown@intel.com, linux-ide@vger.kernel.org, dz@debian.org, minyard@acm.org, j.w.r.degoede@hhs.nl, lm-sensors@lm-sensors.org, rlove@rlove.org, bzolnier@gmail.com, dmitry.torokhov@gmail.com, mzxreary@0pointer.de, stelian@popies.net, ibm-acpi@hmh.eng.br, ambx1@neo.rr.com, gimli@dark-green.com



On Sat, 1 Sep 2007, Andi Kleen wrote:
> 
> >     And if we're really lucky, this might enable some additional
> >     optimizations on the part of the compiler.
> 
> Only if the kernel was compiled C++. C compilers generally ignore constness
> for optimization purposes because it can be so easily casted away.

???

I can't speak for the exact const-ification that Jeff did in this
particular patch, but if you intended your comment up there to be a
blanket statement, then you're totally and horribly wrong. There's a
whole plethora of optimizations that gcc does when dealing with const-
marked data. If you've seen / experienced otherwise, please post some
testcases.
