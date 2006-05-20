From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/7] sata_mv: deal with interrupt coalescing interrupts
Date: Sat, 20 May 2006 00:32:33 -0400
Message-ID: <446E9BE1.3060700@pobox.com>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca> <200605191624.56928.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:27580 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932495AbWETEcg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 May 2006 00:32:36 -0400
In-Reply-To: <200605191624.56928.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> In some systems, it is possible that the BIOS may have enabled interrupt coalescing
> for the Marvell controllers which support it.  This patch adds code to detect/ack
> interrupts from the chip's coalescing (combing) logic.
> 
> Signed-off-by: Mark Lord <liml@rtr.ca>

Applied, though I would like a follow-up which simply guarantees that 
irq coalescing is off.

	Jeff



