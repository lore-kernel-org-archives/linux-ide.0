From: Jens Axboe <axboe@suse.de>
Subject: Re: [patch] ide dma blacklist toshiba
Date: Tue, 28 Jun 2005 08:27:26 +0200
Message-ID: <20050628062725.GD3411@suse.de>
References: <20050626165533.GU12811@sputnik.stro.at> <42BEE984.8050704@pobox.com> <20050627072458.GG19550@suse.de> <42C0CB99.9000105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:49598 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261600AbVF1G0H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2005 02:26:07 -0400
Content-Disposition: inline
In-Reply-To: <42C0CB99.9000105@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: maximilian attems <debian@sternwelten.at>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>

On Tue, Jun 28 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sun, Jun 26 2005, Jeff Garzik wrote:
> >
> >>maximilian attems wrote:
> >>
> >>>--- kernel-source-2.6.6/drivers/ide/ide-dma.c	2004-04-05 
> >>>19:49:28.000000000 +1000
> >>>+++ kernel-source-2.6.6-1/drivers/ide/ide-dma.c	2004-04-05 
> >>>20:54:34.000000000 +1000
> >>>@@ -125,6 +125,7 @@
> >>>	{ "HITACHI CDR-8335"	,	"ALL"		},
> >>>	{ "HITACHI CDR-8435"	,	"ALL"		},
> >>>	{ "Toshiba CD-ROM XM-6202B"	,	"ALL"		},
> >>>+	{ "TOSHIBA CD-ROM XM-1702BC"	,	"ALL"		},
> >>>	{ "CD-532E-A"		,	"ALL"		},
> >>>	{ "E-IDE CD-ROM CR-840",	"ALL"		},
> >>>	{ "CD-ROM Drive/F5A",	"ALL"		},
> >>
> >>
> >>When touching the blacklist, always make sure to patch 
> >>ata_dma_blacklist[] (drivers/scsi/libata-core.c) in the same patch (or 
> >>aonther patch mailed at the same time).
> >
> >
> >This has come up at least two times in the last week already, how about
> >adding a unified dma blacklist to ata.h instead?
> 
> Feel free to submit a patch :)

Hehe, somehow I knew that was going to be the response :-)

-- 
Jens Axboe

