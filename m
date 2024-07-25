Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CC17588
	for <linux-ide@vger.kernel.org>; Thu, 25 Jul 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925821; cv=none; b=PAUkDCr34o4tC1nxKde2GGF+ylllQyadqjF8L+x+pJ8IO6+UUSe6hHexaJ9p6txY57gM7IZgGlP1LCc+R79EvJWep3TUIEX9XdiduLxs6AljAvbW8JfPq6jrqY3oLLZ5Bg7C6v4LIn8J9q1C++Rg+d4Ahj/jLeaMIZLso8KijAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925821; c=relaxed/simple;
	bh=YUlycjjfdGtA3AqJ4Ip1UIUzgjNXQDT8dZYTes3JpO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPMPjjntdXe5zjhhL4R87s8fanZmoG7ogZS9j7sdrdvnjDMiGeYASvh/v4DncXop7ZN6Bm1zmqwfkdfWFpXG6OU529ECosbw8QfsKcY5+2QXhzhEUqAbuRyBBycgMxpTYqR3rp8ILqmvyU/YAOKYSD+tOztGVxJVI4Xy7fupkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP2X2s8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP2X2s8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82872C4AF07;
	Thu, 25 Jul 2024 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721925821;
	bh=YUlycjjfdGtA3AqJ4Ip1UIUzgjNXQDT8dZYTes3JpO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZP2X2s8/dFBsBAXsf9UaKnWUgtHJt76BzIzCiJmk8IRrqtN/Wf1x9wHGbZXSWXuiD
	 gGTxAWNlGmS/MVucbJbNVb7Edf0LrQGkNJ8wqzFe9JPZP8s2m7yQpCiJaZEGrhNYsY
	 j3cj1696DmMsK3lsJCN/zHkMJr2C9JVqKVAH6jv9OHe+Pgl8KiWAYGFOHlaSP12MNO
	 IaY564A7+I3BmuKY08yaEkXNoogQMYL5ZgBzLeGkfHpvUJZDnv0jqINuwK27sjN7vJ
	 fW/Qf4nXKuJ+41f9fiTkMRkCDbue5/RoKfqAOcO3HolMeQgCSvn+gPY1S2WBXUTp3J
	 7olJrOYf40h5g==
Date: Thu, 25 Jul 2024 18:43:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 3/4] ata: libata: Change ata_dev_knobble() to return a
 bool
Message-ID: <ZqKAuTShcH5i3_Jg@ryzen.lan>
References: <20240724054539.182655-1-dlemoal@kernel.org>
 <20240724054539.182655-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724054539.182655-4-dlemoal@kernel.org>

On Wed, Jul 24, 2024 at 02:45:38PM +0900, Damien Le Moal wrote:
> Change the function ata_dev_knobble() to return a boolean instead of a
> u8.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 272770f09609..4ef1d14aba1e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2219,12 +2219,12 @@ static int ata_do_link_spd_horkage(struct ata_device *dev)
>  	return 0;
>  }
>  
> -static inline u8 ata_dev_knobble(struct ata_device *dev)
> +static inline bool ata_dev_knobble(struct ata_device *dev)
>  {
>  	struct ata_port *ap = dev->link->ap;
>  
>  	if (ata_dev_horkage(dev) & ATA_HORKAGE_BRIDGE_OK)
> -		return 0;
> +		return false;
>  
>  	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
>  }
> -- 
> 2.45.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
