From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND v3 3/6] AHCI: Make few function names more
 descriptive
Date: Tue, 23 Sep 2014 16:22:31 -0400
Message-ID: <20140923202231.GE14111@mtj.dyndns.org>
References: <cover.1411297686.git.agordeev@redhat.com>
 <fe20e3ee0fb7b3f68de0015dac11021c68823cf6.1411297686.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:32794 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbaIWUWg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Sep 2014 16:22:36 -0400
Content-Disposition: inline
In-Reply-To: <fe20e3ee0fb7b3f68de0015dac11021c68823cf6.1411297686.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Sep 21, 2014 at 03:19:26PM +0200, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: linux-ide@vger.kernel.org
> ---
>  drivers/ata/ahci.c    |  7 +++----
>  drivers/ata/ahci.h    |  6 +++---
>  drivers/ata/libahci.c | 16 ++++++++--------
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 7ce8e01..4a849f8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
...
> @@ -1305,9 +1305,8 @@ int ahci_host_activate(struct ata_host *host, int irq,
>  	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI)
>  		rc = ahci_host_activate_multi_irqs(host, irq, sht);
>  	else
> -		rc = ata_host_activate(host, irq, ahci_interrupt,
> +		rc = ata_host_activate(host, irq, ahci_single_irq_intr,
>  				       IRQF_SHARED, sht);
> -	return rc;

Hmmm... why is return removed here?

Thanks.

-- 
tejun
