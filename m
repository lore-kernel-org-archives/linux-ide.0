Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3AF215077;
	Tue, 26 Aug 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756184948; cv=none; b=PTRcHXnLg8PQF0SCuvPip0CALvavy1QJpXv0aHduRcYVPON4tc3M8rfnfCwsitBGQ3FPBR5MVfLVddktUEPQv5wFUuLibbzPlHIgCMezkELrcCcmLjhqyqnG/iR+So0yynnJvwKnj+Vmmk3WimrTl8uOyl1NYm60njGnVwj5gvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756184948; c=relaxed/simple;
	bh=W4XXRCWhkiA5nW0vb7FwmYtG9wU18GNBtufJX13/nU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lweYVCHgrDbQ/3/iHYQniifd7Iq8gQtmYn09M+J/Ta1aD9+u21fZ6K0cyiyATxortvE3njszGhn+FXuq3denM3wyociyrCdnAMHZ4U77ze+MIj+eq59VY+rnVY6Uk2dlkSfxms4BcjqQuax1Aer39PcSjDHQVBn0GVa42enI3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR/XQi81; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR/XQi81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9175FC4CEF1;
	Tue, 26 Aug 2025 05:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756184948;
	bh=W4XXRCWhkiA5nW0vb7FwmYtG9wU18GNBtufJX13/nU4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NR/XQi815eEEWQrX4QJs07XdGqSVoqdFGZXY6wLYFxtB0kPYYwAURypd6RAQS9n6G
	 dQHTMp8MV17lAW2RXCGtQq9Vmrn7pUBZlTDemC/DdKN5bYqICowpfDEaBU3UZ5RGLw
	 BZ/0vJnhIJIxjP+8yoJjiU4k/MzDer0xeiQ0EY4symiBJWQj9j1S9wvcQWrwj+VF6J
	 aU9cTkb19d5kNlPyiM3E1K4vceaOhwXkfY2UwXENwt5HLaPQtk7NKIYVxomswrMfKU
	 QDi/KOcKEU2A76jLc7taIlrdZ6UmhsVuLWCGFvprdcds3Q/CQ6gAi424UuCqR7sfb4
	 sPjk8zApxZIHw==
Message-ID: <138dde32-e528-4731-b766-4f26dd9366d1@kernel.org>
Date: Tue, 26 Aug 2025 14:09:05 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_xgene: Use int type for 'rc' to store error
 codes
To: Qianfeng Rong <rongqianfeng@vivo.com>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250826040219.133959-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250826040219.133959-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 13:02, Qianfeng Rong wrote:
> Use int instead of u32 for 'rc' variable to store negative error codes
> returned by ahci_do_softreset().
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/ata/ahci_xgene.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 5d5a51a77f5d..8d01c105fd44 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -450,7 +450,7 @@ static int xgene_ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
>  {
>  	int pmp = sata_srst_pmp(link);
>  	struct ata_port *ap = link->ap;
> -	u32 rc;
> +	int rc;
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	u32 port_fbs;

If you fix this, please fix it properly: the rc variable is not needed at all in
that function. You can just do:

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 5d5a51a77f5d..a6d964f7184c 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -450,7 +450,6 @@ static int xgene_ahci_pmp_softreset(struct ata_link *link,
unsigned int *class,
 {
        int pmp = sata_srst_pmp(link);
        struct ata_port *ap = link->ap;
-       u32 rc;
        void __iomem *port_mmio = ahci_port_base(ap);
        u32 port_fbs;

@@ -463,9 +462,7 @@ static int xgene_ahci_pmp_softreset(struct ata_link *link,
unsigned int *class,
        port_fbs |= pmp << PORT_FBS_DEV_OFFSET;
        writel(port_fbs, port_mmio + PORT_FBS);

-       rc = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
-
-       return rc;
+       return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
 }


>  
> @@ -500,7 +500,7 @@ static int xgene_ahci_softreset(struct ata_link *link, unsigned int *class,
>  	u32 port_fbs;
>  	u32 port_fbs_save;
>  	u32 retry = 1;
> -	u32 rc;
> +	int rc;
>  
>  	port_fbs_save = readl(port_mmio + PORT_FBS);
>  


-- 
Damien Le Moal
Western Digital Research
