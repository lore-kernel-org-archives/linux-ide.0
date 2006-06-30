From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -mm] ide_end_drive_cmd(): avoid instruction pipeline
	stall
Date: Fri, 30 Jun 2006 18:26:56 +0100
Message-ID: <1151688416.31392.66.camel@localhost.localdomain>
References: <20060630161351.GA17434@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57992 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751626AbWF3RKw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 13:10:52 -0400
In-Reply-To: <20060630161351.GA17434@rhlx01.fht-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>

Ar Gwe, 2006-06-30 am 18:13 +0200, ysgrifennodd Andreas Mohr:
> Use an independently-formatted "unsigned int" for data instead of a
> restrictive "u16" to avoid instruction fetch pipeline stalls
> probably caused by the byte calculations later.

drivers/ide is on its way out. I'm also curious that this shows up given
that the inw() is going to cause a PCI sequence and stall the CPU
entirely for ages anyway.

NAK because
1. This is a gcc problem
2. Not everyone is using an intel x86-32 box which has such problems
3. IDE is in life-support mode and the relatives are already planning
the flowers.

Alan
