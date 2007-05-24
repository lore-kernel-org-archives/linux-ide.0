From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc2] libata: sata_sis fixes
Date: Thu, 24 May 2007 02:09:10 -0400
Message-ID: <46552C06.60208@garzik.org>
References: <200705240131.32021.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40967 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757859AbXEXGJO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 02:09:14 -0400
In-Reply-To: <200705240131.32021.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: htejun@gmail.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Uwe Koziolek wrote:
> The sata_sis driver supports SATA and PATA ports. The broken support
> of both types in one controller is fixed.
> 
> the pata133 sis controllers does not support a drive present status
> in the pci configspace like the older sis controllers, check removed.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

ditto Alan's comments:  your implementation is identical to 
ata_bmdma_error_handler(), so you can just use that.

otherwise, seems OK...

	Jeff


