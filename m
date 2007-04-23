From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] cmd64x: use interrupt status from MRDMODE register (take 2)
Date: Tue, 24 Apr 2007 00:03:10 +0200
Message-ID: <200704240003.10292.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200704142353.53115.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:32042 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbXDWWaU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 18:30:20 -0400
Received: by ug-out-1314.google.com with SMTP id 44so51003uga
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 15:30:20 -0700 (PDT)
In-Reply-To: <200704142353.53115.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 April 2007, Sergei Shtylyov wrote:
> Fold the parts of the ide_dma_end() methods identical to __ide_dma_end() into a
> mere call to it.
> Start using faster versions of the ide_dma_end() and ide_dma_test_irq() methods
> for the PCI0646U and newer chips that have the duplicate interrupt status bits
> in the I/O mapped MRDMODE register, determing what methods to use at the driver
> load time. Do some cleanup/renaming in the "old" ide_dma_test_irq() method too.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The fixes to PCI0646 chip reporting and some other changes from the older patch
> have been moved into a separate patch (to be posted RSN), otherwise there's a
> couple of style changes added.  The patch have received testing on PCI-649 now.

applied
