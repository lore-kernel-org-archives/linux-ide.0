From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Q] PCI Express and ide (native) leads to irq storm?
Date: Wed, 15 Nov 2006 13:49:21 -0500
Message-ID: <455B6131.1@pobox.com>
References: <453DC2A9.8000507@sw.ru> <453DC65C.8000408@sw.ru>	 <454206EE.9080206@sw.ru> <1161958862.16839.26.camel@localhost.localdomain> <4559879D.8090105@sw.ru> <455AF01C.5090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32144 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030863AbWKOStd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Nov 2006 13:49:33 -0500
In-Reply-To: <455AF01C.5090307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Vasily Averin <vvs@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, devel@openvz.org

Tejun Heo wrote:
> In short, some piix controllers including ICH7, when put into enhanced 
> mode (PCI native mode), uses BMDMA Interrupt bit as interrupt 
> pending/clear bit for *all* commands.  ie. Reading STATUS does NOT clear 

Yep.  I thought I had mentioned this, ages ago.


> Fortunately, libata is immune to the problem because it does 
> ap->ops->irq_clear(ap) in ata_host_intr() regardless of command type in 
> flight.  So, not loading IDE piix and using libata to drive all piix 
> ports solves the problem.

Yep, that's intentional :)

	Jeff



