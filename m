From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/13] ide: add IDE_HFLAG_ERROR_STOPS_FIFO host flag
Date: Sat, 8 Sep 2007 16:27:29 +0100
Message-ID: <20070908162729.0f203af5@the-village.bc.nu>
References: <200709052352.57848.bzolnier@gmail.com>
	<20070906081356.GA20007@havoc.gtf.org>
	<20070908161755.10902b54@the-village.bc.nu>
	<46E2BCA8.30402@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60974 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752914AbXIHPTU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 11:19:20 -0400
In-Reply-To: <46E2BCA8.30402@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

> > You'd have to add the drain data on error hack first, right now we will
> > reset in that case (which for one or two devices has another problem in
> > that it won't clear a stuck FIFO)
> 
> Nod.  There was nothing ever wrong with Mark's drain patch, I just never 
> saw a solid justification for it outside of root 

You don't need to be root, any user can do this with the right commands
via SG_IO - and it happens on errors occassionally for real.
