Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533C40A940
	for <linux-ide@vger.kernel.org>; Thu,  6 Aug 2026 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017351; cv=none; b=MVXdzo+2nr06ZAHpP8V2YD6+6OJiOKF1KnzSQiVt2gLxY3TkUnRfgPxY7aCO3C23cyJ9auZJlkinEs3WzpJKPfqCEqwvkuy28gkJv2pRnjy4QqXce5QBUDScIMaEoDwLUbB0CXGd3VCLvSchjqcRKUeGM5I/KqRVmIHRL81qAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017351; c=relaxed/simple;
	bh=ZoYjog3Dw6Z4RPfAyfCn3B+RZV12yo6wMZ/xGeejOu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAZ6qsPaWnbLt/YeFy59+WDaZvyiBDvIdGGBtmzGeJzpACRK2uiioRPbN1ZC0AUKbE2iJTIuevIvYZrwNjpSmHbukgvTMVBFMalB2cMXUIPor2OzwJcp3FSMk167jW+B1iKIcvq4K7+g9EQtNbAeR6cnem361WB7/wcIkCKe6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no6L8YpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no6L8YpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1187D1F000E9;
	Thu,  6 Aug 2026 11:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786017350;
	bh=Jy02JmAcic6jC8/GbqrzyQWS7iRaMGqhBRuTqyzN00U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=no6L8YpLbQhO1jOvC2J+uSjuH/8Q39rQmoF/AY7ZG8CekxeFDPCfbRIm//mPDg932
	 yCiBrvFIpAv+uutM7vl+EKuN7z5V0AI9bNz2CYF5/kRz8K+DxGicrGJAIWilNQuCxr
	 BPEbTFWRtPpD31Ie9egesRSwxDNt2exXcNgl1b2HRXCwEvXRxA9BySdxJqiD+K6MT7
	 6SVUyV0h/J4lmfaGLi5uKm3m66xNivpTpbeSAavhwC+bC08bIH/bpSzBgVt8PodWju
	 WV3wGkKEuJUeOvpDMj/m+p/ngsia8X2TQ19T1VtBjbdwbIPFNPDKqchTi4hOjgZmGK
	 VMf30iKG+ez6A==
Date: Thu, 6 Aug 2026 13:55:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] ata: pata_sl82c105: fix bridge revision use-after-free
Message-ID: <anR2QnAEP3FOzjwG@ryzen>
References: <20260806060628.1658-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806060628.1658-1-getshell@seu.edu.cn>

On Thu, Aug 06, 2026 at 02:06:28PM +0800, Hongyan Xu wrote:
> pci_get_slot() returns a referenced PCI device. Commit 44c10138fd4b
> ("PCI: Change all drivers to use pci_device->revision") replaced a
> configuration-space read with direct access to the cached revision field,
> but left that access after pci_dev_put(). The bridge may therefore be freed
> before its revision is read.
> 
> Read the revision before dropping the reference.
> 
> Fixes: 44c10138fd4b ("PCI: Change all drivers to use pci_device->revision")
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/ata/pata_sl82c105.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
> index 2d24c6b3e9d9..25bce3fe2a10 100644
> --- a/drivers/ata/pata_sl82c105.c
> +++ b/drivers/ata/pata_sl82c105.c
> @@ -264,6 +264,7 @@ static struct ata_port_operations sl82c105_port_ops = {
>  static int sl82c105_bridge_revision(struct pci_dev *pdev)
>  {
>  	struct pci_dev *bridge;
> +	u8 revision;
>  
>  	/*
>  	 * The bridge should be part of the same device, but function 0.
> @@ -285,8 +286,9 @@ static int sl82c105_bridge_revision(struct pci_dev *pdev)
>  	/*
>  	 * We need to find function 0's revision, not function 1
>  	 */
> +	revision = bridge->revision;
>  	pci_dev_put(bridge);
> -	return bridge->revision;
> +	return revision;
>  }
>  
>  static void sl82c105_fixup(struct pci_dev *pdev)
> -- 
> 2.50.1.windows.1
> 

Makes sense to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
