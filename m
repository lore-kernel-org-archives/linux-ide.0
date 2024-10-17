Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828742AB1;
	Thu, 17 Oct 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156203; cv=none; b=g18vQb5e2TEEy7WIoL1sRghVeyD2zOf8BnzT3PuajIFZ//9BdN/FgwnmDAOcWWU27A12YtVhuzd1UC3wmxPYore6zrphRXdWGN0pj+wqyMXe1lXKTeWxFTZF+3lLr124XgnXbO3deYBRp4kxKvQueshx/yh+GZSh5pT13feJCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156203; c=relaxed/simple;
	bh=DMcRV7qpaGp/pdog8ySpOqnvsEfxt/xtWnwiKVscW/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2ANv9yzZ+b+AhbJ/p3eAGiJp95kWm2i12n0ZzkUfHDmRlErHoEXdZDRh50ncW8hq09wqMpB01C8kdgjyc3VKywBw3yCZFVlJXDw+ncGTWwRnkEFBVuOaTt+2jhSlOc4B3fpLVllaxeKG0rosDSu1eZABuvWvFhsrDU1sb1/CoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6+o1hRI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6+o1hRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D52AC4CEC3;
	Thu, 17 Oct 2024 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729156203;
	bh=DMcRV7qpaGp/pdog8ySpOqnvsEfxt/xtWnwiKVscW/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6+o1hRIeBLlFbwcnGqlPWnptVLlqXRvpmUZ1deTnQTpiQ9+my5cvTv441B9ex+WU
	 BKmF2pnbu9r4nw840QVovROLQchDodEZt+XIOZVIgY0YQcXq7HPWnooQRQ9cjktl0E
	 vCZdfGp6Z316Gaj1f3ZcrTHxHQXz82HJxMrjeNWOkvJPpGQ+lT+4bgIhI5JppBXAcZ
	 yg14wDiCjaeERAP8ycJkJu4sZJlB0xAphAbVWykrR9ELhS2AuzgUA86nEDJvaTznfK
	 HsUiqDVs8VdiYthyxWAF/T7fy5XqKp2RwypV1vKHAdGRuBd6x4Hd3PpXIvesEojCnD
	 KuWaVmvTFs9Pw==
Date: Thu, 17 Oct 2024 11:09:56 +0200
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
	Kees Cook <kees@kernel.org>
Subject: Re: [RFC PATCH v1 34/57] sata_sil24: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <ZxDUZMDf2Xfz2tvi@ryzen.lan>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-34-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014105912.3207374-34-ryan.roberts@arm.com>

Hello Ryan,

While I realize that this has not always been consistent,
please prefix the subject with "ata: ", so that it becomes
"ata: sata_sil24: ".

On Mon, Oct 14, 2024 at 11:58:41AM +0100, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Convert "struct sil24_ata_block" and "struct sil24_atapi_block" to use a
> flexible array member for their sge[] array. The previous static size of
> SIL24_MAX_SGE depends on PAGE_SIZE so doesn't work for boot-time page
> size.
> 
> Wrap global variables that are initialized with PAGE_SIZE derived values
> using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
> deferred for boot-time page size builds.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  drivers/ata/sata_sil24.c | 46 +++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 72c03cbdaff43..85c6382976626 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -42,26 +42,25 @@ struct sil24_sge {
>  	__le32	flags;
>  };
>  
> +/*
> + * sil24 fetches in chunks of 64bytes.  The first block
> + * contains the PRB and two SGEs.  From the second block, it's
> + * consisted of four SGEs and called SGT.  Calculate the
> + * number of SGTs that fit into one page.
> + */
> +#define SIL24_PRB_SZ	(sizeof(struct sil24_prb) + 2 * sizeof(struct sil24_sge))
> +#define SIL24_MAX_SGT	((PAGE_SIZE - SIL24_PRB_SZ) / (4 * sizeof(struct sil24_sge)))
> +
> +/*
> + * This will give us one unused SGEs for ATA.  This extra SGE
> + * will be used to store CDB for ATAPI devices.
> + */
> +#define SIL24_MAX_SGE	(4 * SIL24_MAX_SGT + 1)
>  
>  enum {
>  	SIL24_HOST_BAR		= 0,
>  	SIL24_PORT_BAR		= 2,
>  
> -	/* sil24 fetches in chunks of 64bytes.  The first block
> -	 * contains the PRB and two SGEs.  From the second block, it's
> -	 * consisted of four SGEs and called SGT.  Calculate the
> -	 * number of SGTs that fit into one page.
> -	 */
> -	SIL24_PRB_SZ		= sizeof(struct sil24_prb)
> -				  + 2 * sizeof(struct sil24_sge),
> -	SIL24_MAX_SGT		= (PAGE_SIZE - SIL24_PRB_SZ)
> -				  / (4 * sizeof(struct sil24_sge)),
> -
> -	/* This will give us one unused SGEs for ATA.  This extra SGE
> -	 * will be used to store CDB for ATAPI devices.
> -	 */
> -	SIL24_MAX_SGE		= 4 * SIL24_MAX_SGT + 1,
> -
>  	/*
>  	 * Global controller registers (128 bytes @ BAR0)
>  	 */
> @@ -244,13 +243,13 @@ enum {
>  
>  struct sil24_ata_block {
>  	struct sil24_prb prb;
> -	struct sil24_sge sge[SIL24_MAX_SGE];
> +	struct sil24_sge sge[];
>  };
>  
>  struct sil24_atapi_block {
>  	struct sil24_prb prb;
>  	u8 cdb[16];
> -	struct sil24_sge sge[SIL24_MAX_SGE];
> +	struct sil24_sge sge[];
>  };
>  
>  union sil24_cmd_block {
> @@ -373,7 +372,7 @@ static struct pci_driver sil24_pci_driver = {
>  #endif
>  };
>  
> -static const struct scsi_host_template sil24_sht = {
> +static DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(struct scsi_host_template, sil24_sht, {
>  	__ATA_BASE_SHT(DRV_NAME),
>  	.can_queue		= SIL24_MAX_CMDS,
>  	.sg_tablesize		= SIL24_MAX_SGE,
> @@ -382,7 +381,7 @@ static const struct scsi_host_template sil24_sht = {
>  	.sdev_groups		= ata_ncq_sdev_groups,
>  	.change_queue_depth	= ata_scsi_change_queue_depth,
>  	.device_configure	= ata_scsi_device_configure
> -};
> +});
>  
>  static struct ata_port_operations sil24_ops = {
>  	.inherits		= &sata_pmp_port_ops,
> @@ -1193,7 +1192,7 @@ static int sil24_port_start(struct ata_port *ap)
>  	struct device *dev = ap->host->dev;
>  	struct sil24_port_priv *pp;
>  	union sil24_cmd_block *cb;
> -	size_t cb_size = sizeof(*cb) * SIL24_MAX_CMDS;
> +	size_t cb_size = PAGE_SIZE * SIL24_MAX_CMDS;
>  	dma_addr_t cb_dma;
>  
>  	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
> @@ -1258,7 +1257,6 @@ static void sil24_init_controller(struct ata_host *host)
>  
>  static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
> -	extern int __MARKER__sil24_cmd_block_is_sized_wrongly;
>  	struct ata_port_info pi = sil24_port_info[ent->driver_data];
>  	const struct ata_port_info *ppi[] = { &pi, NULL };
>  	void __iomem * const *iomap;
> @@ -1266,9 +1264,9 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	int rc;
>  	u32 tmp;
>  
> -	/* cause link error if sil24_cmd_block is sized wrongly */
> -	if (sizeof(union sil24_cmd_block) != PAGE_SIZE)
> -		__MARKER__sil24_cmd_block_is_sized_wrongly = 1;
> +	/* union sil24_cmd_block must be PAGE_SIZE */
> +	BUG_ON(struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE) != PAGE_SIZE);
> +	BUG_ON(struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE) > PAGE_SIZE);
>  
>  	ata_print_version_once(&pdev->dev, DRV_VERSION);
>  
> -- 
> 2.43.0
> 

As you might know, there is an effort to annotate all flexible array
members with their run-time size information, see commit:
dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")

I haven't looked at the DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST macro, but since
sge[] now becomes a flexible array member, I think it would be nice if it
would be possible to somehow use the __counted_by macro.

Other than that, this looks good to me.


Kind regards,
Niklas
