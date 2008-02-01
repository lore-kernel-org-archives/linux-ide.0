From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/9] libata: implement and use ata_noop_irq_clear()
Date: Fri, 01 Feb 2008 15:45:23 -0500
Message-ID: <47A384E3.4000007@garzik.org>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853432109-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53773 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834AbYBAUp0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 15:45:26 -0500
In-Reply-To: <12016853432109-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Tejun Heo wrote:
> ->irq_clear() is used to clear IRQ bit of a SFF controller and isn't
> useful for drivers which don't use libata SFF HSM implementation.
> However, it's a required callback and many drivers implement their own
> noop version as placeholder.  This patch implements ata_noop_irq_clear
> and use it to replace those custom placeholders.
> 
> Also, SFF drivers which don't support BMDMA don't need to use
> ata_bmdma_irq_clear().  It becomes noop if BMDMA address isn't
> initialized.  Convert them to use ata_noop_irq_clear().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 2-3


