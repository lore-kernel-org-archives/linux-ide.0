From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sis: add missing UDMA5 timing value in
 sis_66_set_dmamode()
Date: Fri, 21 Sep 2007 11:41:48 +0100
Message-ID: <20070921114148.45c90b62@the-village.bc.nu>
References: <20070921072905.GC10660@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50183 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756180AbXIUKfF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 06:35:05 -0400
In-Reply-To: <20070921072905.GC10660@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, desaster.area@addcom.de, alan@redhat.com, bzolnier@gmail.com

On Fri, 21 Sep 2007 16:29:05 +0900
Tejun Heo <htejun@gmail.com> wrote:

> sis_66_set_dmamode() also handles early UDMA100 (SIS630 ET) but is
> missing udma timing value for UDMA100.  According to sis5513, this
> should be 0x8000.  This caused UDMA100 device to fail on pata_sis till
> it downgrades to UDMA66 while it works fine on sis5513 at UDMA100.
> 
> Reported by Adam Blech.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Adam Blech <desaster.area@addcom.de>

Acked-by: Alan Cox <alan@redhat.com>

I was just looking at this as we had a Red Hat bug for it 8)

