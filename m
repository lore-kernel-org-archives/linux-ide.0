From: maximilian attems <debian@sternwelten.at>
Subject: Re: [patch] ide dma blacklist toshiba
Date: Sun, 26 Jun 2005 19:48:13 +0200
Message-ID: <20050626174813.GW12811@sputnik.stro.at>
References: <20050626165533.GU12811@sputnik.stro.at> <42BEE984.8050704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:19129 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261508AbVFZRsC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:48:02 -0400
Content-Disposition: inline
In-Reply-To: <42BEE984.8050704@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>

On Sun, 26 Jun 2005, Jeff Garzik wrote:

> maximilian attems wrote:
> >--- kernel-source-2.6.6/drivers/ide/ide-dma.c	2004-04-05 
> >19:49:28.000000000 +1000
> >+++ kernel-source-2.6.6-1/drivers/ide/ide-dma.c	2004-04-05 
> >20:54:34.000000000 +1000
> >@@ -125,6 +125,7 @@
> > 	{ "HITACHI CDR-8335"	,	"ALL"		},
> > 	{ "HITACHI CDR-8435"	,	"ALL"		},
> > 	{ "Toshiba CD-ROM XM-6202B"	,	"ALL"		},
> >+	{ "TOSHIBA CD-ROM XM-1702BC"	,	"ALL"		},
> > 	{ "CD-532E-A"		,	"ALL"		},
> > 	{ "E-IDE CD-ROM CR-840",	"ALL"		},
> > 	{ "CD-ROM Drive/F5A",	"ALL"		},
> 
> 
> When touching the blacklist, always make sure to patch 
> ata_dma_blacklist[] (drivers/scsi/libata-core.c) in the same patch (or 
> aonther patch mailed at the same time).
> 
> 	Jeff

thanks to pinpoint that.
i'll send in a second patch covering the ata_dma_blacklist[].

--
maks

