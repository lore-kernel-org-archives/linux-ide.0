From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata#upstream 1/2] sata_promise: add missing cable_detect
 hooks
Date: Wed, 04 Apr 2007 01:43:34 -0400
Message-ID: <46133B06.6020302@pobox.com>
References: <200703112019.l2BKJRQ7018662@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41454 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966312AbXDDFnj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 01:43:39 -0400
In-Reply-To: <200703112019.l2BKJRQ7018662@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> The recent change which moved cable detection from
> pdc_pre_reset() to the new ->cable_detect hook only
> added the hook for SATAII chips, leaving SATAI chips
> and the 20619 without the hook. Fixed by this patch.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
>  drivers/ata/sata_promise.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)

applied 1-2


