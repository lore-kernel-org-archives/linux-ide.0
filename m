From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 10/50] libata: force hardreset if link is in powersave
 mode
Date: Fri, 6 Jun 2008 18:27:15 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806061826420.3473@woody.linux-foundation.org>
References: <20080607010215.358296706@sous-sol.org> <20080607010555.470605116@sous-sol.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48521 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933623AbYFGBai (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2008 21:30:38 -0400
In-Reply-To: <20080607010555.470605116@sous-sol.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Tejun Heo <htejun@gmail.com>, matthieu.castet@parrot.com, Greg Kroah-Hartman <gregkh@suse.de>



On Fri, 6 Jun 2008, Chris Wright wrote:
>
> -stable review patch.  If anyone has any objections, please let us know.
> ---------------------
> 
> From: Tejun Heo <htejun@gmail.com>
> 
> Inhibiting link PM mode doesn't bring the link back online if it's
> already in powersave mode.  If SRST is used in these cases, libata EH
> thinks that the link is offline and fails detection.  Force hardreset
> if link is in powersave mode.

This isn't upstream. Maybe there's some reason it's not needed upstream, 
but it would be nice to know.

		Linus
