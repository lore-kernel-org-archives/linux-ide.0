From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.21-rc1] sata_promise: fix 20619 new EH merge error
Date: Sun, 25 Feb 2007 15:53:58 -0500
Message-ID: <45E1F766.1070800@garzik.org>
References: <200702251144.l1PBidUj003214@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34772 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbXBYUyA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Feb 2007 15:54:00 -0500
In-Reply-To: <200702251144.l1PBidUj003214@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> When I merged my 20619 new EH conversion with #libata-upstream
> I had to manually resolve a conflict, and inadvertently lost
> pdc_pata_ops' ->post_internal_cmd binding. Corrected by this patch.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> ---
> 
>  drivers/ata/sata_promise.c |    1 +
>  1 files changed, 1 insertion(+)

applied both patches


