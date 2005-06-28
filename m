From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] ide dma blacklist toshiba
Date: Tue, 28 Jun 2005 00:01:29 -0400
Message-ID: <42C0CB99.9000105@pobox.com>
References: <20050626165533.GU12811@sputnik.stro.at> <42BEE984.8050704@pobox.com> <20050627072458.GG19550@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:39124 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262510AbVF1EBh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2005 00:01:37 -0400
In-Reply-To: <20050627072458.GG19550@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: maximilian attems <debian@sternwelten.at>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>

Jens Axboe wrote:
> On Sun, Jun 26 2005, Jeff Garzik wrote:
> 
>>maximilian attems wrote:
>>
>>>--- kernel-source-2.6.6/drivers/ide/ide-dma.c	2004-04-05 
>>>19:49:28.000000000 +1000
>>>+++ kernel-source-2.6.6-1/drivers/ide/ide-dma.c	2004-04-05 
>>>20:54:34.000000000 +1000
>>>@@ -125,6 +125,7 @@
>>>	{ "HITACHI CDR-8335"	,	"ALL"		},
>>>	{ "HITACHI CDR-8435"	,	"ALL"		},
>>>	{ "Toshiba CD-ROM XM-6202B"	,	"ALL"		},
>>>+	{ "TOSHIBA CD-ROM XM-1702BC"	,	"ALL"		},
>>>	{ "CD-532E-A"		,	"ALL"		},
>>>	{ "E-IDE CD-ROM CR-840",	"ALL"		},
>>>	{ "CD-ROM Drive/F5A",	"ALL"		},
>>
>>
>>When touching the blacklist, always make sure to patch 
>>ata_dma_blacklist[] (drivers/scsi/libata-core.c) in the same patch (or 
>>aonther patch mailed at the same time).
> 
> 
> This has come up at least two times in the last week already, how about
> adding a unified dma blacklist to ata.h instead?

Feel free to submit a patch :)

	Jeff



