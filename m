From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2 UPDATED] libata: make sure IRQ is cleared after ata_bmdma_freeze()
Date: Tue, 28 Nov 2006 04:03:30 -0500
Message-ID: <456BFB62.2000906@pobox.com>
References: <20061117030621.GD2184@htj.dyndns.org> <20061117030750.GE2184@htj.dyndns.org> <20061117032422.GF2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:3203 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935728AbWK1JDd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:03:33 -0500
In-Reply-To: <20061117032422.GF2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Now that BMDMA status is recorded in irq handler.  ata_bmdma_freeze()
> is free to manipulate host status.  Under certain circumstances, some
> controllers (ICH7 in enhanced mode w/ IRQ shared) raise IRQ when CTL
> register is written to and ATA_NIEN doesn't mask it.
> 
> This patch makes ata_bmdma_freeze() clear all pending IRQs after
> freezing a port.  This change makes explicit clearing in
> ata_device_add() unnecessary and thus kills it.  The removed code was
> SFF-specific and was in the wrong place.
> 
> Note that ->freeze() handler is always called under ap->lock held and
> irq disabled.  Even if CTL manipulation causes stuck IRQ, it's cleared
> immediately.  This should be safe (enough) even in SMP environment.
> More correct solution is to mask the IRQ from IRQ controller but that
> would be an overkill.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK

