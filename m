From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Re: 2.4.22-rc2 ext2 filesystem corruption
Date: Mon, 03 Nov 2003 11:50:16 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1067820616.691.42.camel@gaston>
References: <200310311941.31930.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.86.99.235]:7367 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261881AbTKCAu6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Nov 2003 19:50:58 -0500
In-Reply-To: <200310311941.31930.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Sat, 2003-11-01 at 05:52, Bartlomiej Zolnierkiewicz wrote:
> [ http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/1164.html
>   for people seeing this subject for the first time ]
> 
> Hi,
> 
> Can you try booting with "hdX=autotune" (hdX==your drive) kernel parameter?
> Promise driver is not autotuning PIO modes if (U)DMA modes are going
> to be used, but correct PIO timings are needed even if (U)DMA is used.

That reminds me of something "interesting" I found: I got Apple's code
for the Xserve PDC 20270 and 271 chips, and they just no timing at all
except on the 271 for U/DMA. They rely on the chip snooping the
SET_FEATURE command and do it all except for that later case, where
the chip fails to properly setup U/DMA timings on a 133Mhz clocked
chip.

They do also some tweaking to select which PLL is used apparently. 

Ben.


