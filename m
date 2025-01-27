Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04E3FC7
	for <linux-ide@vger.kernel.org>; Mon, 27 Jan 2025 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737938265; cv=none; b=u2MAm/rXC8OG0oYMcj+iQ8omGy/qdfFcAQZ0mCB60EpWjAheIpfC2WgIGsVqfFjYaDhVe9ARdhIkpI0ZVLYZsQkF1+DbsQyFJpcfktrCgQ8kj1bun9atOhsOmXM0lGLegu/AZeMmiSXVB7ZQiiduDN0lCD9A77V972xg2qGr7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737938265; c=relaxed/simple;
	bh=bQ4UkhgRArnQF4lDIfJeU9gPTBjd3rd7ovPSc+uVzME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKB+ovr6DcneVPpUn38Wly+xd3SCH/jtIAd0/avxRv79ljR75u8RFDsUnzmHhNQ9MH7gNywlewZcWerAR6aNqHzjOjkPEOLC5eXM+VY2Lglu6W5sHdlWWifWuEVXBGdg5Bqh4xohf1Toy+3ncsGNWvjxJS0sjIpAGgNMya0Zl+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVaH7XQy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVaH7XQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE73C4CED3;
	Mon, 27 Jan 2025 00:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737938265;
	bh=bQ4UkhgRArnQF4lDIfJeU9gPTBjd3rd7ovPSc+uVzME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YVaH7XQykiEXG5WGvIFqR0NWlxK2Lt0XkOftSvPibWdpsc0R70yJDmMA6WRc0eTSh
	 XvJ1m2GgxgCVk+FCBd5Mg/30vxkwgtAaj6D9aZmws7NbhgjIb3O4FRtEUsPVFulCrR
	 KXg8cgxCLppqmYpsUcg25ysbRRe6MiGoxGhxye30TASj/w1CXTTu5uNCuNjaOqY234
	 De9doNhQ1QGR6SGlut36ARJmcOV+ucUglccvTJYeyJ1gK60r/5FwGaEiKe5CG83IfF
	 jIKl93wG3etpAeVhaad/lPpFHBgP3rd7Mt2ajw9X6ebIIP0csDIz1qn5B5kgmRx8LJ
	 heXcKyenBDx/A==
Message-ID: <1addab73-2d85-466a-9a6a-13a838df61c4@kernel.org>
Date: Mon, 27 Jan 2025 09:37:44 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: ahci: Create a ahci_get_port_map_helper() helper
To: Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org
References: <20250116143630.1935474-4-cassel@kernel.org>
 <20250116143630.1935474-5-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250116143630.1935474-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 23:36, Niklas Cassel wrote:
> Create a ahci_get_port_map_helper() helper so that this code can be reused
> by other module parameters that are saved in a port bitmap.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 48 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 8d27c567be1c..92b08d3a0c3c 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -676,35 +676,27 @@ MODULE_PARM_DESC(mask_port_map,
>  		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
>  		 "form \"domain:bus:dev.func\"");
>  
> -static void ahci_apply_port_map_mask(struct device *dev,
> -				     struct ahci_host_priv *hpriv, char *mask_s)
> -{
> -	unsigned int mask;
> -
> -	if (kstrtouint(mask_s, 0, &mask)) {
> -		dev_err(dev, "Invalid port map mask\n");
> -		return;
> -	}
> -
> -	hpriv->mask_port_map = mask;
> -}
> +typedef void (*port_map_callback_t)(struct device *dev,
> +				    struct ahci_host_priv *hpriv, char *mask_s);
>  
> -static void ahci_get_port_map_mask(struct device *dev,
> -				   struct ahci_host_priv *hpriv)
> +static void ahci_get_port_map_helper(struct device *dev,

Can we drop the "_helper" at the end of the name ?

> +				     struct ahci_host_priv *hpriv,
> +				     const char *module_str,
> +				     port_map_callback_t apply_cb)

And maybe change this to "apply_port_map_mask_cb" to be clear about what is
being applied ?


-- 
Damien Le Moal
Western Digital Research
