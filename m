From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Sat, 3 Feb 2007 19:59:30 +0000
Message-ID: <20070203195930.4dc956dc@localhost.localdomain>
References: <20070202063748.GC1625@htj.dyndns.org>
	<45C33BCF.2040506@emc.com>
	<45C354CF.1020500@gmail.com>
	<20070202153929.33f4a806@localhost.localdomain>
	<45C41018.1010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57967 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751385AbXBCTrM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 14:47:12 -0500
In-Reply-To: <45C41018.1010509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ric Wheeler <ric@emc.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

> So, I agree with Mark here.  We should retry and fail bio-by-bio.  The
> end effect wouldn't be much worse than block-by-block while taking much
> less time.

And perhaps flip the bio list backwards as well 8) ?
