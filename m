From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: icside_dmaintr() in icside.c
Date: Sat, 20 Nov 2004 13:08:18 +0000
Message-ID: <20041120130817.B13550@flint.arm.linux.org.uk>
References: <58cb370e041024065467404a38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261339AbUKTNI1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Nov 2004 08:08:27 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e041024065467404a38@mail.gmail.com>; from bzolnier@gmail.com on Sun, Oct 24, 2004 at 03:54:54PM +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Oct 24, 2004 at 03:54:54PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi Russell,
> 
> * for() loop in icside_dmaintr seems buggy
> 
> * what do you think about following patch?
>   (ide-dma is nowadays always build if BLK_DEV_IDEDMA)
> 
> [ide] icside: use ide_dma_intr()
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Looks fine.  I'd have liked to have done it this way initially, but
I seem to remember there were objections to using ide_dma_intr at
the time ("it's for PCI only").

Please push upstream if not already done so.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
