From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/15] libata: implement ata_down_xfermask_limit()
Date: Sat, 01 Apr 2006 14:47:50 -0500
Message-ID: <442ED8E6.6030306@pobox.com>
References: <11438230983159-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10973 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751595AbWDATry (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 14:47:54 -0500
In-Reply-To: <11438230983159-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ata_down_xfermask_limit().  This function manipulates
> @dev->pio/mwdma/udma_mask such that the next lower transfer mode is
> selected.  This will be used by ata_bus_probe() rewrite and later by
> EH speeding down.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, though I share Alan's concerns, even with your explanation.  We'll 
see where this leads...

Not applied because it will cause a compile warning.

	Jeff



