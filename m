From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sis: add missing UDMA5 timing value in sis_66_set_dmamode()
Date: Tue, 25 Sep 2007 21:39:08 -0400
Message-ID: <46F9B83C.8060605@garzik.org>
References: <20070921072905.GC10660@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52572 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbXIZBjL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 21:39:11 -0400
In-Reply-To: <20070921072905.GC10660@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, desaster.area@addcom.de, alan@redhat.com, bzolnier@gmail.com

Tejun Heo wrote:
> sis_66_set_dmamode() also handles early UDMA100 (SIS630 ET) but is
> missing udma timing value for UDMA100.  According to sis5513, this
> should be 0x8000.  This caused UDMA100 device to fail on pata_sis till
> it downgrades to UDMA66 while it works fine on sis5513 at UDMA100.
> 
> Reported by Adam Blech.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Adam Blech <desaster.area@addcom.de>
> ---
>  drivers/ata/pata_sis.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied


