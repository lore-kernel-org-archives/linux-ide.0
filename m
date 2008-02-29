From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: devres and requesting resources
Date: Fri, 29 Feb 2008 17:04:46 +0000
Message-ID: <20080229170446.48aff87d@core>
References: <47C75392.3020606@garzik.org>
	<47C7FA8B.7040306@gmail.com>
	<20080229140106.41ccc843@core>
	<200802291804.09412.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58961 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757829AbYB2RPr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Feb 2008 12:15:47 -0500
In-Reply-To: <200802291804.09412.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

> > legacy old IDE driver might but that probably isn't going to be fixed by
> > devres and is trivial to fix in that driver (just steal the code from
> > pata_legacy).
> 
> Yep, nice trick.
> 
> Since it is your idea/code could you please also fix ide_generic? :)

In my copious free time - ask me around August ;)

Alan
