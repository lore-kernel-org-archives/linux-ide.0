From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] ahci: fix nvec check
Date: Thu, 20 Oct 2016 16:32:13 +0100
Message-ID: <70330efb-76d5-0fc1-d69b-d4a8e27a5c7a@canonical.com>
References: <1476976541-14501-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60286 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934266AbcJTPcP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2016 11:32:15 -0400
In-Reply-To: <1476976541-14501-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, tj@kernel.org
Cc: linux-ide@vger.kernel.org

On 20/10/16 16:15, Christoph Hellwig wrote:
> commit 17a51f12 ("ahci: only try to use multi-MSI mode if there is more
> than 1 port") lead to a case where nvec isn't initialized before it's
> used.  Fix this by moving the check into the n_ports conditional.
> 
> Reported-by Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/ahci.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ed311a0..60e42e2 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1436,14 +1436,14 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>  				"ahci: MRSM is on, fallback to single MSI\n");
>  			pci_free_irq_vectors(pdev);
>  		}
> -	}
>  
> -	/*
> -	 * -ENOSPC indicated we don't have enough vectors.  Don't bother trying
> -	 * a single vectors for any other error:
> -	 */
> -	if (nvec < 0 && nvec != -ENOSPC)
> -		return nvec;
> +		/*
> +		 * -ENOSPC indicated we don't have enough vectors.  Don't bother
> +		 * trying a single vectors for any other error:
> +		 */
> +		if (nvec < 0 && nvec != -ENOSPC)
> +			return nvec;
> +	}
>  
>  	/*
>  	 * If the host is not capable of supporting per-port vectors, fall
> 
That looks good to me. Thanks Christoph

Acked-by: Colin Ian King <colin.king@canonical.com>
