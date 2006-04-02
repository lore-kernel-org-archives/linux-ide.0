From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 09/15] libata: implement ata_down_xfermask_limit()
Date: Sun, 2 Apr 2006 15:58:56 +0900
Message-ID: <20060402065856.GI13172@htj.dyndns.org>
References: <11438230983159-git-send-email-htejun@gmail.com> <442ED8E6.6030306@pobox.com> <442F2110.7080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:46907 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751222AbWDBG7B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 01:59:01 -0500
Received: by zproxy.gmail.com with SMTP id o37so1421042nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 22:59:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <442F2110.7080501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sun, Apr 02, 2006 at 09:55:44AM +0900, Tejun Heo wrote:
> Jeff Garzik wrote:
> >Tejun Heo wrote:
> >>Implement ata_down_xfermask_limit().  This function manipulates
> >>@dev->pio/mwdma/udma_mask such that the next lower transfer mode is
> >>selected.  This will be used by ata_bus_probe() rewrite and later by
> >>EH speeding down.
> >>
> >>Signed-off-by: Tejun Heo <htejun@gmail.com>
> >
> >ACK, though I share Alan's concerns, even with your explanation.  We'll 
> >see where this leads...
> >
> >Not applied because it will cause a compile warning.
> >
> 
> I'll write fuller description of synchronization model in the head 
> message of new EH framework patchset. Sorry about the compile warning.
> 

Jeff, the compile warning is about ata_down_xfermask_limit() being
unused, which is intended.  This patch implements the function.  Later
changes will use it.  I'll re-post this patch as is in the next take.

-- 
tejun
