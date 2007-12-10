From: Mark Lord <liml@rtr.ca>
Subject: Re: SAS v SATA interface performance
Date: Mon, 10 Dec 2007 11:32:57 -0500
Message-ID: <475D6A39.3080909@rtr.ca>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru> <475CEBBA.3050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4419 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbXLJQc6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 11:32:58 -0500
In-Reply-To: <475CEBBA.3050409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Tejun Heo wrote:
..
> NCQ is not more advanced than SCSI TCQ.  NCQ is "native" and "advanced"
> compared to old IDE style bus-releasing queueing support which was one
> ugly beast which no one really supported well.  The only example I can
> remember which actually worked was first gen raptors paired with
> specific controller with custom driver on windows.
..

I wrote PATA drivers for some chipsets that had hardware support for TCQ,
and it did make a very impressive throughput difference when enabled.
The IBM/Hitachi Deathst.. err.. Deskstar.. drives always had the best
support in firmware.  I believe we also used some WD drives, though there
firmware didn't perform as well.

ISTR that NCQ wins over TCQ (ATA) because multiple drives can interleave
their data transfers on the bus -- with TCQ, a drive took over the bus
at the start of data transfer and never released it until the command completed.

Cheers
