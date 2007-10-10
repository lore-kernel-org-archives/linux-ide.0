From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: skip suppress reporting if ATA_EHI_QUIET
Date: Tue, 09 Oct 2007 21:40:58 -0400
Message-ID: <470C2DAA.4090209@garzik.org>
References: <20071009055756.GG12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41721 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbXJJBk7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 21:40:59 -0400
In-Reply-To: <20071009055756.GG12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ATA_EHI_NO_AUTOPSY and ATA_EHI_QUIET are used during initial probing
> to skip exception analysis and reporting.  Usually, there's nothing to
> report but on some allowed but rare corner cases (e.g. phy status
> changed interrupt when IRQ is enabled on frozen port - this happens if
> IRQ pending status isn't cleared in the IRQ router or controller)
> exception messages get printed.
> 
> Skip reporting if ATA_EHI_QUIET is set.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

applied


