From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: ignore ATA_DMA_ERR on vmware
 ich4
Date: Thu, 10 Jan 2008 16:50:11 -0500
Message-ID: <47869313.7060306@garzik.org>
References: <4782013D.7010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32849 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872AbYAJVuN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 16:50:13 -0500
In-Reply-To: <4782013D.7010304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> VMware ich4 emulation incorrectly sets DMA_ERR on TF error.  Ignore
> it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

hrm.  IIRC, the old-IDE code just sorta ignores this, and in the 
original libata I followed old-IDE's habit of acking events with

	write-to-dma-status-register(err | intr)

so what part of libata-core cares about this distinction?  what is the 
specific behavior from the original problem report that this solves?

	Jeff



