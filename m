From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI UDMA - first in Linux
Date: 14 May 2004 14:19:50 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084565990.3084.36.camel@patibmrh9>
References: <1084563800.8752.53.camel@patibmrh9><40A52683.8050604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:5344 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262585AbUENUUO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 16:20:14 -0400
In-Reply-To: <40A52683.8050604@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> Windows and Linux have both supported SATA ATAPI -- which implicitly 
> includes UDMA from looking at the bridges -- for a while now, in various 
>   OS drivers.

SATA ATAPI PIO I find, easy, yes, immediately available in boot-from-CD
Linux such as Knoppix.

SATA ATA UDMA I have found.

SATA ATAPI UDMA I have not found.  Not in Linux, not in Windows.

Perhaps I should blame my Silicon Image 3611CT80 1.4 bridge, and buy
another?

Do we all agree SATA ATAPI UDMA is missing from Linux-2.6.6 `make
defconfig`?

Can any of us suggest other .config options to try?

> If you have an ICH5 or Silicon Image 3112, I bet you could use your 
> ATAPI device using the existing Linux IDE driver...

I believe I have ICH5.  I know I have a board labelled "Intel"
"D865GBF".

Pat LaVarre


