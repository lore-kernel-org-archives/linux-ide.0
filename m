From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata-core when not ata_id_use_dmadir despite yesSili
	conI mage
Date: 15 May 2004 10:46:28 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084639588.3070.9.camel@patibmrh9>
References: <1084630807.5082.42.camel@patibmrh9><200405151633.10473.bzolnie
	r@elka.pw.edu.pl> <40A64229.7000600@pobox.com><200405151838.15898.bzolnier@
	elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:39918 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264702AbUEOQqt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 12:46:49 -0400
In-Reply-To: <200405151838.15898.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

> > We can do so for our development here, but a better solution based on
> > released parts will need to be found...
> 
> Do you know of some way to detect SI 3611CT80 1.4?

I don't.

Jeff G, do you?

> > And this language makes sense, since it is unknown what all those cheap
> > old ATAPI devices will do.  It's too risky to simply set this bit for
> > all ATAPI devices, without lots of testing.
> 
> OK

Yes.

> > According to ATA/ATAPI7,
> >
> > 	A device that does not support the DMADIR feature may abort a
> > 	command if the DMADIR bit is set to 1.

I believe this is a t13.org change that is NOT backwards-compatible,
analogous to the theft I remember of op xEC Identify "word" 128.

I will double-check ATA/ATAPI 4/ 5/ 6 and report the relevant language
here.

Pat LaVarre


