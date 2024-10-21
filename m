Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BF946C;
	Mon, 21 Oct 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511019; cv=none; b=ZAT4g455xk6A4Dk57SRA+1JLkLjh7yA+oZzxqWFyPgIcuaaJb7X0MaKlmowLLNsFLbv1dywD96VAvHw7H/mpXvSADIYwhkA6GH5yUDeSNkt4Hn6g1tX55iAjY4vOjM01I0vrTDeSXDcNI8qggNJ0DPW1ez4EiRfVkCH1At35aWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511019; c=relaxed/simple;
	bh=awMHKeW2IqFLj8Un2Mvc6m+8vNSs8NS5bptZgfjy3Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXAIaA5MWxmuqTLOmsMOhfzM9I4cKDD9+0BZUgJy0dQ5PewKt9jXyC8xE4e73ZrO7GkWFOagCV1s90axhsJkjmopclZxGR2nw+Vtrzo7P4Gb4hCTvPTxuB8Sn3wmO5xffGbp2FCOJ8Gj4UmMtePZZveIWpPbsoHnADQWKgogKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnUZcBiw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnUZcBiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83058C4CEC3;
	Mon, 21 Oct 2024 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511019;
	bh=awMHKeW2IqFLj8Un2Mvc6m+8vNSs8NS5bptZgfjy3Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnUZcBiwYN0oUEeEN8LXcEyIIfpko9fRGTmgbdH9YqBuPYZSZ6fd1nAx3SYHnTtZ6
	 0+kKjJEolyA7JaHYxeB1sERy/Bx0qJVDrUbBIrelx+n9qu30MtD+oRvnqdh/8FjREZ
	 1LkgNq/GG215kUUqZXU0mnCR8rXbaIKnXbgL8J49OpXiLNEQ8YLUuGiDMBSzbqyUzi
	 5xrjZJwdCHucJLpgaWYm/Wd+iqQmJaXwiYXdMlVIfubyCRZJUlS2Lp7nwvIUWGN29N
	 BIHjAFRwmJnNv1adZRa1v6DMrh8XfZk0jxPnpaLxgAIXB/RIHi8eLd+Wnk9LCHUIkk
	 wvtzlsVf2oaqQ==
Date: Mon, 21 Oct 2024 13:43:31 +0200
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
Message-ID: <ZxY-Y6GF0m_wTfyD@ryzen.lan>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-34-ryan.roberts@arm.com>
 <ZxDUZMDf2Xfz2tvi@ryzen.lan>
 <7aa84080-6845-496a-a394-30d334632298@arm.com>
 <ZxEISOhaqRvHlc3U@ryzen.lan>
 <2f578256-7e56-491f-a4ca-ad6caa72b7ae@arm.com>
 <ZxY1KAvGpyIzARtX@ryzen.lan>
 <8e1e0824-1022-4f8f-9753-e134c7244d3a@arm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e1e0824-1022-4f8f-9753-e134c7244d3a@arm.com>

On Mon, Oct 21, 2024 at 12:26:15PM +0100, Ryan Roberts wrote:
> On 21/10/2024 12:04, Niklas Cassel wrote:
> > On Mon, Oct 21, 2024 at 10:24:37AM +0100, Ryan Roberts wrote:
> >> On 17/10/2024 13:51, Niklas Cassel wrote:
> >>> On Thu, Oct 17, 2024 at 01:42:22PM +0100, Ryan Roberts wrote:
> > 
> > (snip)
> > 
> >> That said, while investigating this, I've spotted a bug in my change. paddr calculation in sil24_qc_issue() is incorrect since sizeof(*pp->cmd_block) is no longer PAGE_SIZE. Based on feedback in another patch, I'm also converting the BUG_ONs to WARN_ON_ONCEs.
> > 
> > Side note: Please wrap you lines to 80 characters max.
> 
> Yes sorry, I turned off line wrapping for that last mail because I didn't want
> it to wrap the copy/pasted patch. I'll figure out how to mix and match for future.
> 
> > 
> > 
> >>
> >> Additional proposed change, which I'll plan to include in the next version:
> >>
> >> ---8<---
> >> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> >> index 85c6382976626..c402bf998c4ee 100644
> >> --- a/drivers/ata/sata_sil24.c
> >> +++ b/drivers/ata/sata_sil24.c
> >> @@ -257,6 +257,10 @@ union sil24_cmd_block {
> >>         struct sil24_atapi_block atapi;
> >>  };
> >>  
> >> +#define SIL24_ATA_BLOCK_SIZE   struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE)
> >> +#define SIL24_ATAPI_BLOCK_SIZE struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE)
> >> +#define SIL24_CMD_BLOCK_SIZE   max(SIL24_ATA_BLOCK_SIZE, SIL24_ATAPI_BLOCK_SIZE)
> >> +
> >>  static const struct sil24_cerr_info {
> >>         unsigned int err_mask, action;
> >>         const char *desc;
> >> @@ -886,7 +890,7 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
> >>         dma_addr_t paddr;
> >>         void __iomem *activate;
> >>  
> >> -       paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
> >> +       paddr = pp->cmd_block_dma + tag * SIL24_CMD_BLOCK_SIZE;
> >>         activate = port + PORT_CMD_ACTIVATE + tag * 8;
> >>  
> >>         /*
> >> @@ -1192,7 +1196,7 @@ static int sil24_port_start(struct ata_port *ap)
> >>         struct device *dev = ap->host->dev;
> >>         struct sil24_port_priv *pp;
> >>         union sil24_cmd_block *cb;
> >> -       size_t cb_size = PAGE_SIZE * SIL24_MAX_CMDS;
> >> +       size_t cb_size = SIL24_CMD_BLOCK_SIZE * SIL24_MAX_CMDS;
> >>         dma_addr_t cb_dma;
> >>  
> >>         pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
> >> @@ -1265,8 +1269,8 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >>         u32 tmp;
> >>  
> >>         /* union sil24_cmd_block must be PAGE_SIZE */
> > 
> > This comment should probably be rephrased to be more clear then, since like
> > you said sizeof(union sil24_cmd_block) will no longer be PAGE_SIZE.
> 
> How about:
> 
> /*
>  * union sil24_cmd_block must be PAGE_SIZE once taking into account the 'sge'
>  * flexible array members in struct sil24_atapi_block and struct sil24_ata_block
>  */

Sounds good to me!


Kind regards,
Niklas
