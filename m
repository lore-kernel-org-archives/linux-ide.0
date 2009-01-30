From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Switching from (deprecated) IDE driver -> SATA (PATA support)
Date: Fri, 30 Jan 2009 10:21:56 +0000
Message-ID: <20090130102156.1219bb2b@lxorguk.ukuu.org.uk>
References: <alpine.DEB.1.10.0901250553430.2441@p34.internal.lan>
	<200901252027.43376.bzolnier@gmail.com>
	<alpine.DEB.1.10.0901251612310.16676@p34.internal.lan>
	<200901252239.26268.bzolnier@gmail.com>
	<498240B7.6010500@tmr.com>
	<alpine.DEB.1.10.0901291937290.24753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34799 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755933AbZA3KWJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jan 2009 05:22:09 -0500
In-Reply-To: <alpine.DEB.1.10.0901291937290.24753@asgard.lang.hm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: david@lang.hm
Cc: Bill Davidsen <davidsen@tmr.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> what was the problem with these? I have somthing in this family in one of 
> my secondary boxes (I'd have to go check exactly which model)

343/363 don't work unless you use the alternate access via the BAR4
register range and leave BAR0-3 alone. That means you can't use the
standard IDE setup helper logic with them.

366 and later (which is almost certainly what you will have) replace this
with a different collection of errata which are handled by both sets of
drivers.

Alan
