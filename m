From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Any guides for adding new IDE chipset drivers?
Date: Tue, 17 Feb 2004 14:27:06 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1077028026.31892.153.camel@cambridge.braddahead.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:24217 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S266218AbUBQOcX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Feb 2004 09:32:23 -0500
List-Id: linux-ide@vger.kernel.org
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

On Monday 16 of Febuary 2004 09:40:21 PST, Bart wrote:
>On Monday 16 of February 2004 18:04, Alex Bennee wrote:
>
>> Is there a driver that can be held of as an example of good taste and
>> the "right" way to implement a chipset driver?
>
>Yep.  Please take a look at drivers/ide/arm/icside.c.
>It is well written, quite simple and has DMA support.

Thanks. I'll base my driver on this one as it does seem quite easy
to follow. However I'm wondering what the point of the begin/end functions
are. The dma_read/write functions just seem to call dma_count which starts the
dma requests going.

Am I missing something here? Is all that required from the higher level a single
call to dma_read/write or should I be expecting a series of calls to setup a transfer?


>If you have any questions/issues feel free to ask
>on linux-ide@vger.kernel.org mailing list.

Hmmm, vger seems to be ignoring my subscribe requests. 

Is the list archived anywhere? None are listed on VGER.


-- 
Alex, homepage: http://www.bennee.com/~alex/
It is a hard matter, my fellow citizens, to argue with the belly,
since it has no ears.
		-- Marcus Porcius Cato

