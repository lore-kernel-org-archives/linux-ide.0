Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F86223708
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268694; cv=none; b=sfbMimDSGy3t1/QrbvuguGPUh+CmPGY2nmTe8yPoNixVFmkqkTz82csl2mq03fZ5tkklV4PJ/tP6hEExHH/DllKVPYba+nmF1Y/huiILPIad4awi94N88IuBxqOhB0yf3YmJW834RcahrIWMwFB+t/3KS3ttk/p5nUeFwJnDu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268694; c=relaxed/simple;
	bh=JWuwILYCZ474+w6QaLDovJO75S4kiKNHOf1l8YoFNjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBUcfPzzJpflhrnptIX5q1PgIsootVeNP+ak4c96PWp8bFwRZTG5Yt+76qWTqdngFhkMVqHmCXXyfz5WVxO2CmZNPVpMjoVFwsfUNeF+lJt0zrE5hEbrfA/SVzD0mI2l4Mq0z/cFS1LnOom1ZbDlK/6a3wUkMPJ62936U0fcW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drMSmXj6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drMSmXj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB09EC19425;
	Mon, 27 Apr 2026 05:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777268694;
	bh=JWuwILYCZ474+w6QaLDovJO75S4kiKNHOf1l8YoFNjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=drMSmXj6RSWB5woDVyBwlarWw5BJeFXLCfqv3MuD57UPOorYvgqdVPSx5aztWOr84
	 K8h94gbz1ORsg/Sq6kDrHJiShTLDe1PNMQ5VEuhyF82Hrtq5v9lhGc9KZFQa9euvIm
	 WEE6Lr+qRpG+AHII/Bqv6r/ez4rD7uMO+jMGEKXWgL5z+VY3s2DZrhrI8By0RQB4ob
	 EXFjW3tG3uoH+r9KJ2LjUk1ct5pfgQiP0w7eF53xIBHLjfyy7GsCxko0C6dkV0MtHj
	 ZsTfru4a2RY4pCvU5wgESHoGM8L58cMN9IQQRAs5hxX6wzrbfCTwSPoObZKG2lzzqa
	 FaRXLCM+90lQA==
Message-ID: <2a79933e-9051-4d5d-a95e-c4bfc2c2c932@kernel.org>
Date: Mon, 27 Apr 2026 14:44:46 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: ahci: fail probe if BAR too small for claimed
 ports
To: dayou5941@163.com, linux-ide@vger.kernel.org
Cc: cassel@kernel.org, liyouhong@kylinos.cn
References: <20260427053752.613848-1-dayou5941@163.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260427053752.613848-1-dayou5941@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 2:37 PM, dayou5941@163.com wrote:
> From: liyouhong <liyouhong@kylinos.cn>
> 
> When an AHCI controller is disabled in BIOS, its HOST_CAP register may
> contain invalid values (e.g., 0xFFFFFFFF) indicating an impossibly large
> number of ports. If CAP.NP claims more ports than can physically fit
> within the mapped BAR region, accessing port registers beyond the BAR
> boundary causes a kernel panic.
> 
> Add validation in ahci_init_one() to check that the BAR size is
> sufficient for the number of ports claimed in CAP.NP. The check
> calculates the required MMIO size as:
> 
>   required_size = 0x100 (global registers) + max_ports * 0x80
> 
> If required_size exceeds the actual BAR size, the probe fails with
> -ENODEV, preventing the panic and providing a clear error message.
> 
> This solution follows the suggestion by Damien Le Moal and Niklas Cassel
> to detect and reject obviously broken controller configurations early.
> 
> Reported-by: liyouhong <liyouhong@kylinos.cn>
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> ---
> v3:
> - Fix patch format: add "---" separator and move changelog to correct location
> - Change dev_err to dev_warn as suggested

Note for next time: please keep *all* versions notes in the changelog. Do not
keep only the description for the last changes.

> 
> ---
>  drivers/ata/ahci.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 1d73a53370cf..e5eff7e3d66b 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1888,6 +1888,23 @@ static ssize_t remapped_nvme_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(remapped_nvme);
>  
> +static int ahci_validate_bar_size(struct pci_dev *pdev, void __iomem *mmio)
> +{
> +	u32 cap = readl(mmio + HOST_CAP);
> +	unsigned int max_ports = ahci_nr_ports(cap);
> +	u32 last_port_end = 0x100 + (max_ports * 0x80);
> +	resource_size_t bar_size = pci_resource_len(pdev, AHCI_PCI_BAR_STANDARD);

Long line. Please break it after the "=":

	resource_size_t bar_size =
		pci_resource_len(pdev, AHCI_PCI_BAR_STANDARD);

> +
> +	if (last_port_end > bar_size) {
> +		dev_warn(&pdev->dev,
> +			 "BAR5 too small for %u ports (last port ends at %u, BAR %llu)\n",
> +			 max_ports, last_port_end, (unsigned long long)bar_size);

Here too, long line. Break it after last_port_end.

			max_ports, last_port_end,
			(unsigned long long)bar_size);


With that fixed, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
