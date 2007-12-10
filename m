From: Mark Lord <liml@rtr.ca>
Subject: Re: SAS v SATA interface performance
Date: Mon, 10 Dec 2007 11:28:18 -0500
Message-ID: <475D6922.40309@rtr.ca>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru> <475CEBBA.3050409@gmail.com> <20071210143656.GD9227@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4758 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbXLJQ2U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 11:28:20 -0500
In-Reply-To: <20071210143656.GD9227@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Tejun Heo <htejun@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Mon, Dec 10 2007, Tejun Heo wrote:
>> There's one thing we can do to improve the situation tho.  Several
>> drives including raptors and 7200.11s suffer serious performance hit if
>> sequential transfer is performed by multiple NCQ commands.  My 7200.11
>> can do > 100MB/s if non-NCQ command is used or only upto two NCQ
>> commands are issued; however, if all 31 (maximum currently supported by
>> libata) are used, the transfer rate drops to miserable 70MB/s.
>>
>> It seems that what we need to do is not issuing too many commands to one
>> sequential stream.  In fact, there isn't much to gain by issuing more
>> than two commands to one sequential stream.
> 
> Well... CFQ wont go to deep queue depths across processes if they are
> doing streaming IO, but it wont stop a single process from doing so. I'd
> like to know what real life process would issue a streaming IO in some
> async manner as to get 31 pending commands sequentially? Not very likely
..

In the case of the WD Raptors, their firmware has changed slightly over
the years.  The ones I had here would *disable* internal read-ahead
for TCQ/NCQ commands, effectively killing any hope of sequential throughput
even for a queuesize of "1".   This was acknowledged by people with inside
knowledge of the firmware at the time.

Cheers
