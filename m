From: maximilian attems <janitor@sternwelten.at>
Subject: Re: [patch] ide dma blacklist toshiba
Date: Tue, 28 Jun 2005 09:41:11 +0200
Message-ID: <20050628074111.GC5115@sputnik.stro.at>
References: <20050626165533.GU12811@sputnik.stro.at> <42BEE984.8050704@pobox.com> <20050627072458.GG19550@suse.de> <42C0CB99.9000105@pobox.com> <20050628062725.GD3411@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:15760 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261781AbVF1HlT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jun 2005 03:41:19 -0400
Content-Disposition: inline
In-Reply-To: <20050628062725.GD3411@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>

On Tue, 28 Jun 2005, Jens Axboe wrote:

> On Tue, Jun 28 2005, Jeff Garzik wrote:
> > Jens Axboe wrote:
> > >On Sun, Jun 26 2005, Jeff Garzik wrote:
> > >
> > >>maximilian attems wrote:
> > >>
> > >>>--- kernel-source-2.6.6/drivers/ide/ide-dma.c	2004-04-05 
> > >>>19:49:28.000000000 +1000
> > >>>+++ kernel-source-2.6.6-1/drivers/ide/ide-dma.c	2004-04-05 
> > >>>20:54:34.000000000 +1000
> > >>>@@ -125,6 +125,7 @@
> > >>>	{ "HITACHI CDR-8335"	,	"ALL"		},
> > >>>	{ "HITACHI CDR-8435"	,	"ALL"		},
> > >>>	{ "Toshiba CD-ROM XM-6202B"	,	"ALL"		},
> > >>>+	{ "TOSHIBA CD-ROM XM-1702BC"	,	"ALL"		},
> > >>>	{ "CD-532E-A"		,	"ALL"		},
> > >>>	{ "E-IDE CD-ROM CR-840",	"ALL"		},
> > >>>	{ "CD-ROM Drive/F5A",	"ALL"		},
> > >>
> > >>
> > >>When touching the blacklist, always make sure to patch 
> > >>ata_dma_blacklist[] (drivers/scsi/libata-core.c) in the same patch (or 
> > >>aonther patch mailed at the same time).
> > >
> > >
> > >This has come up at least two times in the last week already, how about
> > >adding a unified dma blacklist to ata.h instead?
> > 
> > Feel free to submit a patch :)
> 
> Hehe, somehow I knew that was going to be the response :-)
> 
> -- 
> Jens Axboe

if you haven't done it yet, i'll spin one next weekend.
 
--
maks

