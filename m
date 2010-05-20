From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] PXA DMA-capable PATA driver
Date: Thu, 20 May 2010 10:48:51 +0200
Message-ID: <4BF4F773.102@gmail.com>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com> <4BEDC8C1.30703@garzik.org> <201005180053.54248.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:52018 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab0ETIs5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 04:48:57 -0400
Received: by wwb34 with SMTP id 34so63885wwb.19
        for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 01:48:55 -0700 (PDT)
In-Reply-To: <201005180053.54248.marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com

On 05/18/2010 12:53 AM, Marek Vasut wrote:
> 4766 /**
> 4767  *      atapi_check_dma - Check whether ATAPI DMA can be supported
> 4768  *      @qc: Metadata associated with taskfile to check
> 4769  *
> 4770  *      Allow low-level driver to filter ATA PACKET commands, returning
> 4771  *      a status indicating whether or not it is OK to use DMA for the
> 4772  *      supplied PACKET command.
> 4773  *
> 4774  *      LOCKING:
> 4775  *      spin_lock_irqsave(host lock)
> 4776  *
> 4777  *      RETURNS: 0 when ATAPI DMA can be used
> 4778  *               nonzero otherwise
> 4779  */
> 
> this is from libata-core.c FYI and -EOPNOTSUPP is non-zero.

Argh... that method needs to be changed to return bool.

-- 
tejun
