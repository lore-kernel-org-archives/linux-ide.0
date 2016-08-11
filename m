From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ahci: also use a per-port lock for the multi-MSIX
 case
Date: Thu, 11 Aug 2016 12:39:51 -0400
Message-ID: <20160811163951.GE2695@mtj.duckdns.org>
References: <1470925562-28914-1-git-send-email-hch@lst.de>
 <1470925562-28914-3-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34844 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465AbcHKQjx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2016 12:39:53 -0400
Received: by mail-yw0-f194.google.com with SMTP id r9so41751ywg.2
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2016 09:39:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1470925562-28914-3-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

On Thu, Aug 11, 2016 at 07:26:02AM -0700, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/libahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index dcf2c72..5a1329e 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2378,7 +2378,7 @@ static int ahci_port_start(struct ata_port *ap)
>  	/*
>  	 * Switch to per-port locking in case each port has its own MSI vector.
>  	 */
> -	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI) {
> +	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX)) {

Looks good.  Applied to libata/for-4.9.

Thanks.

-- 
tejun
