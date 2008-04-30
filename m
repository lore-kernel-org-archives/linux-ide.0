From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Wed, 30 Apr 2008 18:38:18 +0900
Message-ID: <48183E0A.1070308@gmail.com>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <48175664.5030702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:28208 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759099AbYD3JiY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 05:38:24 -0400
Received: by wa-out-1112.google.com with SMTP id j37so215197waf.23
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 02:38:24 -0700 (PDT)
In-Reply-To: <48175664.5030702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> For the first time ever, I can now *heavily* mix PIO commands
> with NCQ/non-NCQ DMA commands, to drives on an attached PM
> (well, two attached PMs even), and the thing doesn't croak.
> Woo-hoo!

Cool.

> Time to batch up some patches for Jeff.  But sadly, just in time
> to have missed his weekly visit to linux-ide.  :)
> 
> I wonder if something like that is what bit sata_sil24 the other day
> when I had it plugged in, mixing DMA, NCQ, and PIO commands to drives
> on an attached PM?

sil24 and ahci are pretty heavily tested regarding command scheduling. 
I'll dig into the log soon.  Please give me some time.

Thanks.

-- 
tejun
