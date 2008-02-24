From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata fixes
Date: Sun, 24 Feb 2008 17:07:35 +0000
Message-ID: <20080224170735.7fed8ab6@core>
References: <20080224053508.GA17530@havoc.gtf.org>
	<200802241821.15052.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54756 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754501AbYBXRRe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 12:17:34 -0500
In-Reply-To: <200802241821.15052.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> From the patch description it can't be told whether the patch itself is
> correct and only the patch description is bogus...

zero length PRD misparsing. If I remember rightly old IDE never generates
64K PRD slots because other hardware can't handle it either (CS5520/30
etc)
