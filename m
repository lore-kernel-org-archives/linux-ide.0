From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_rcar: fix interrupt handling
Date: Sat, 01 Jun 2013 03:06:24 +0400
Message-ID: <51A92CF0.3090804@cogentembedded.com>
References: <201306010238.35442.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:35642 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab3EaXGV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 May 2013 19:06:21 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so1873363lab.36
        for <linux-ide@vger.kernel.org>; Fri, 31 May 2013 16:06:19 -0700 (PDT)
In-Reply-To: <201306010238.35442.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: vladimir.barinov@cogentembedded.com

Hello.

On 06/01/2013 02:38 AM, Sergei Shtylyov wrote:

> The driver's interrupt handling code is too picky in deciding whether it should
> handle an interrupt or not which causes completely unneeded spurious interrupts.
> Thus make sata_rcar_{ata|serr}_interrupt() *void*; add ATA status register read
> to sata_rcar_ata_interrupt() to clear an unexpected ATA interrupt -- it doesn't
> get cleared by writing to the SATAINTSTAT register in the interrupt mode we use.
>
> Also, in sata_rcar_ata_interrupt() we should check SATAINTSTAT register only for
> enabled interrupts and we should clear  only those interrupts  that we have read
> as active first time around, because else we have  a  race and risk clearing  an
> interrupt that  can  occur between read  and write of the  SATAINTSTAT  register
> and never registering it...
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

     Darn, I forgot to Cc: stable@vger.kernel.org again.

MBR, Sergei

