From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: cosmetic clean up in ata_eh_reset()
Date: Thu, 25 Oct 2007 02:02:12 -0400
Message-ID: <47203164.9000801@garzik.org>
References: <20071024062126.GD11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55699 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485AbXJYGCN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 02:02:13 -0400
In-Reply-To: <20071024062126.GD11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Local variable @action usage in ata_eh_reset() is a bit confusing.
> It's used only to cache ehc->i.action to test reset masks after
> clearing it; however, due to the generic name "action", it's easy to
> misinterpret the local variable as containing the selected reset
> method later.  Also, the reason for caching the original value is easy
> to miss.
> 
> This patch renames @action to @tmp_action and make it buffer newly
> selected value instead to improve readability.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

applied


