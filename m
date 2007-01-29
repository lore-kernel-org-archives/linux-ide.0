From: Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 11:16:09 -0600
Message-ID: <45BE2BD9.4020706@cs.wisc.edu>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>  <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net> <1170051963.6454.7.camel@Homer.simpson.net> <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sabe.cs.wisc.edu ([128.105.6.20]:44391 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbXA2SZ4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 13:25:56 -0500
In-Reply-To: <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>

Linus Torvalds wrote:
> 
> [ Added Jeff, Jens and Mike Christie to Cc. I would _guess_ this is 
>   associated with the "larger block pc request" stuff: Mike, Jens? James B 
>   added for good luck.
> 
>   It apparently started happening somewhere between 2.6.19 and 2.6.20-rc2, 
>   and doing a
> 
> 	gitk v2.6.19..v2.6.20-rc2 block/scsi_ioctl.c drivers/ide/
> 
>   I don't see anything else that really looks all that suspicious.. Unless 
>   maybe it's that "Fix SG_IO leak". Jeff added because of the hddtemp 
>   issue, but I think that was effectively SATA-only, so probably isn't 
>   relevant.
> 
>   Damn, I just realized that Jens is in the middle of his vacation for a 
>   week..
> 
>   Mike, can you please look at this and check? ]
> 

Ok, I am looking into it now.
