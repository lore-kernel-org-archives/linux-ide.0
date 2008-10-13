From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Porting old hardware from ide to libata (was [PATCH 0/7] ide:
 locking improvements)
Date: Mon, 13 Oct 2008 23:46:48 +0100
Message-ID: <20081013234648.41cfca48@lxorguk.ukuu.org.uk>
References: <678468.92529.qm@web57414.mail.re1.yahoo.com>
	<200810132345.51836.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50683 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754947AbYJMWqu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 18:46:50 -0400
In-Reply-To: <200810132345.51836.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: stan.cunningham@yahoo.com, linux-ide@vger.kernel.org

O> You may want to dig into archives and learn about history of libata.
> Especially under what conditions it has been ACK-ed and merged _five_
> years ago.  Just to quickly recall, there were two such conditions:
> 
> * PATA support would be moved from IDE to libata in an evolutionary way.

IDE stood stale for a year while you vanished (to CERN ?) so the rest of
the world decided to get on with it. As it happens an evolutionary change
would have made no sense as the mentality of the code is [thankfully]
quite different and we could eject an enormous amount of crud in the
process.

> * It would be moved out of SCSI in the long-term.
> 
>   Didn't happen.  Five years is more than enough time for that.

Its mostly happened, there are some interactions that still slowly push
their way up into the block layer.
 
> > So please, take the time to overcome the libata learning curve and start systematically porting support for the remaining old hardware to libata.
> 
> I don't mind somebody doing it.
> 
> I just have zero motivation to do it myself in my private time.

Yeah - I'm slowly working on it in parallel with the tty code.
Unfortunately the big remaining one (mac support) didn't happen as the
Mac that dwmw2 loaned me died and as in typical crapple design style it
needed major surgery with sharpened wall paper scrapers to even open it
the work didn't get done.

For non mainstream systems I'm in no great hurry to move them to libata,
its not like a Commode Amiga is a serious platform that needs the latest
cutting edge code.

Alan
