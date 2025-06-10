Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E132BD5BD
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559070; cv=none; b=AcbmpDSU2fMFELzBPAVeOBVrC0wJ68KyEu+pV/9NjThuTbgl/m60ae6suGyu+ZYUO9IJn1FqvmhTcwTCYaP9Q4ba6tkZJZtDoh9HM0RCIyAtLKZKjUFAlJG0IGgSjxQFRAg4qdvNAK8JjoD6e0Hfmd0DHeOIBgsYlTsuDrpILn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559070; c=relaxed/simple;
	bh=PX2LD0Q+G/Y28Wy7C47DNhUI730zQ2rBYk6pTdR4Dck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klSnXiCEON2fbpVbGnZVPqzgVDfI4sdPUuMBqUkynDZbd1NkbZFGDhOtfeiCoU1laO2GYh1wUKcRN1gdwIiQ904syxbJBC0kSONSnL1Vc6xgfNDqXoYVIigoJ+foC0Mkj+sdGZ+7oVnnza07gLCFeiWOrLLRn9rI8VAXAceq/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2I278w4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2I278w4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC97C2BCFB;
	Tue, 10 Jun 2025 12:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559069;
	bh=PX2LD0Q+G/Y28Wy7C47DNhUI730zQ2rBYk6pTdR4Dck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z2I278w4Z/qY79/B1MIu8a/Zs50Rk/zvtPLNiZToZlhG/O7XC17V+CplNdrloCara
	 f5OeBRq1TA5PuQIpWBhhDj4ZUrPZiQ0I0oLwn+hwNEGMBrIHJ4kntSrgT0bO0XfXVi
	 gLAeF6qSeYLtnlmrMUcR38JoNontflO8WQcF44CGGcI5ejtf5NfhyxEvHEQv6QVeTG
	 +vnHdjE1rRxHEZmtuuZ6G5hSqs8t0kmxp9quuWfYs27V76c8o/3UUSV1OBSih4fklR
	 mdvwwGfVfBzUKRL60qpcqUYWC4GiZhLz5JtRHgJ9xm99sRGIBh0bXLRnWJ9Zt9pwFQ
	 OEnGQjCNqYX8w==
Message-ID: <fb578d4c-2669-4b66-90c3-579b870ee4b2@kernel.org>
Date: Tue, 10 Jun 2025 14:37:46 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ata: ahci: Use correct BIOS build date for
 ThinkPad W541 quirk
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me, Andy Yang <andyybtc79@gmail.com>,
 Mikko Juhani Korhonen <mjkorhon@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20250610110757.1318959-5-cassel@kernel.org>
 <20250610110757.1318959-6-cassel@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250610110757.1318959-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10-Jun-25 1:07 PM, Niklas Cassel wrote:
> Fix the TODO in ahci_broken_lpm() by using the proper BIOS build date.
> 
> The proper BIOS build date was provided by Hans, see Link.
> 
> Link: https://lore.kernel.org/linux-ide/6ea509c8-b38d-4941-8a29-c1117ff3dd5b@redhat.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/ata/ahci.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 163ac909bd06..e7c8357cbc54 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1438,13 +1438,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W541"),
>  			},
> -			/*
> -			 * Note date based on release notes, 2.35 has been
> -			 * reported to be good, but I've been unable to get
> -			 * a hold of the reporter to get the DMI BIOS date.
> -			 * TODO: fix this.
> -			 */
> -			.driver_data = "20180310", /* 2.35 */
> +			.driver_data = "20180409", /* 2.35 */
>  		},
>  		{ }	/* terminate list */
>  	};

