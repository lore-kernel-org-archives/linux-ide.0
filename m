Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698D39FD6;
	Mon, 21 Oct 2024 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508655; cv=none; b=BLZUeJnCg8gAcKu2kAEYdlv+Hp9PqCT3oGtCXV1wjr3wsKt0mh5KNCl3wOcQrdKuxGfE0yIrjBm2QjetXnW+KKfk6HXdjfQXzFuN0INlTIS5UEc3qtCq8RWUORgQMFAx/j5g8xe5UQ5RbfLItm/KwnTKZbP4i6anHe5lQxnFM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508655; c=relaxed/simple;
	bh=V2y7vo9LKGOZ0tWW9XkDgj45tINelaxj5+/uHLJyjvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA9mzSjE8AmlIR3fYIZHZBsYRdb9NKkPR7861Zbho65wdMUI7YGfKIr1+iMaG6thmb7O51XqpAcYG4JQ7KjUSCjj+7x4heUMkru0NDi5IJURwbUU9eXmflGA/Tp7XF6R+qlvwv54hVL8zNnPEfvnHTNolyZ9hywxYtA6kW2Tp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMo0M35g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMo0M35g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C431AC4CEC3;
	Mon, 21 Oct 2024 11:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729508655;
	bh=V2y7vo9LKGOZ0tWW9XkDgj45tINelaxj5+/uHLJyjvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMo0M35gln5n5YBsOzPzLQvm37tYESmeI89JvjV5mKLuiw28JenGK69a1rBEJ2+7+
	 WsrIZhcviLD3dBhbO9wFY/86/NNMRulS0xI0cMvbM4yU7ZMDldEPlxtFCjAjICToSo
	 kY6SIHL1MEqf0OE9zIVaClb7PcVGvRL1dCmD+EPZ9R/IagMJ2E0krfoC43JJYcIaAA
	 sFig3yBqrwK7HFZrmkW/glJqPb13wRp/1ObO1GfJwY0XrJ+u229Y8BO/CrJDIOAWGo
	 Xl/unMeQAxU1TxeLhI1n+eXkewP4OrdOVr4EJ9nx2QSecGrNDnOUb8wr9ei3XveoN+
	 tRk5lexWW8cdQ==
Date: Mon, 21 Oct 2024 13:04:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [RFC PATCH v1 34/57] sata_sil24: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <ZxY1KAvGpyIzARtX@ryzen.lan>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-34-ryan.roberts@arm.com>
 <ZxDUZMDf2Xfz2tvi@ryzen.lan>
 <7aa84080-6845-496a-a394-30d334632298@arm.com>
 <ZxEISOhaqRvHlc3U@ryzen.lan>
 <2f578256-7e56-491f-a4ca-ad6caa72b7ae@arm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f578256-7e56-491f-a4ca-ad6caa72b7ae@arm.com>

On Mon, Oct 21, 2024 at 10:24:37AM +0100, Ryan Roberts wrote:
> On 17/10/2024 13:51, Niklas Cassel wrote:
> > On Thu, Oct 17, 2024 at 01:42:22PM +0100, Ryan Roberts wrote:

(snip)

> That said, while investigating this, I've spotted a bug in my change. paddr calculation in sil24_qc_issue() is incorrect since sizeof(*pp->cmd_block) is no longer PAGE_SIZE. Based on feedback in another patch, I'm also converting the BUG_ONs to WARN_ON_ONCEs.

Side note: Please wrap you lines to 80 characters max.


> 
> Additional proposed change, which I'll plan to include in the next version:
> 
> ---8<---
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 85c6382976626..c402bf998c4ee 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -257,6 +257,10 @@ union sil24_cmd_block {
>         struct sil24_atapi_block atapi;
>  };
>  
> +#define SIL24_ATA_BLOCK_SIZE   struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE)
> +#define SIL24_ATAPI_BLOCK_SIZE struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE)
> +#define SIL24_CMD_BLOCK_SIZE   max(SIL24_ATA_BLOCK_SIZE, SIL24_ATAPI_BLOCK_SIZE)
> +
>  static const struct sil24_cerr_info {
>         unsigned int err_mask, action;
>         const char *desc;
> @@ -886,7 +890,7 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
>         dma_addr_t paddr;
>         void __iomem *activate;
>  
> -       paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
> +       paddr = pp->cmd_block_dma + tag * SIL24_CMD_BLOCK_SIZE;
>         activate = port + PORT_CMD_ACTIVATE + tag * 8;
>  
>         /*
> @@ -1192,7 +1196,7 @@ static int sil24_port_start(struct ata_port *ap)
>         struct device *dev = ap->host->dev;
>         struct sil24_port_priv *pp;
>         union sil24_cmd_block *cb;
> -       size_t cb_size = PAGE_SIZE * SIL24_MAX_CMDS;
> +       size_t cb_size = SIL24_CMD_BLOCK_SIZE * SIL24_MAX_CMDS;
>         dma_addr_t cb_dma;
>  
>         pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
> @@ -1265,8 +1269,8 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>         u32 tmp;
>  
>         /* union sil24_cmd_block must be PAGE_SIZE */

This comment should probably be rephrased to be more clear then, since like
you said sizeof(union sil24_cmd_block) will no longer be PAGE_SIZE.


> -       BUG_ON(struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE) != PAGE_SIZE);
> -       BUG_ON(struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE) > PAGE_SIZE);
> +       WARN_ON_ONCE(SIL24_ATAPI_BLOCK_SIZE != PAGE_SIZE);
> +       WARN_ON_ONCE(SIL24_ATA_BLOCK_SIZE != PAGE_SIZE - 16);
>  
>         ata_print_version_once(&pdev->dev, DRV_VERSION);
> ---8<---
