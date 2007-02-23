From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: use interrupt status from MRDMODE register
Date: Fri, 23 Feb 2007 21:09:06 +0100
Message-ID: <200702232109.06226.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:14525 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932674AbXBWUDK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 15:03:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so461949uga
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 12:03:08 -0800 (PST)
In-Reply-To: <200702162321.40813.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Friday 16 February 2007, Sergei Shtylyov wrote:
> Fold the parts of the ide_dma_end() methods indetical to __ide_dma_end() into a
> mere call to it.
> Start using faster versions of the ide_dma_end() and ide_dma_test_irq() methods
> for the PCI0646U and newer chips that have the duplicate interrupt status bits
> in the I/O mapped MRDMODE register, determing what methods to use at the driver
> load time.  Do some cleanup/renaming in the "old" ide_dma_test_irq() method.
> 
> While at it, fix minor issues with PCI0646 chipset reporting:
> 
> - "IRQ workaround enabled" printed out not only for revision 0x01;
> 
> - "CMD646: chipset revision" printed twice (by IDE core and the driver itself);
> 
> - empty/pointless switch cases for the chips other than PCI0646.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
