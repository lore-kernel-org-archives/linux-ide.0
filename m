Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B01D357B;
	Thu, 17 Oct 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168951; cv=none; b=KaBEE2PX52A3n97/vfEI2PuWa87YggQiFezoFMiINjYGi2sJMNI2kPuaI8C5iwcGBuzM1qeLb5ErGqP53vDVlcALaCOhbDuw9VxnqAMjyztOYaHRT433JW8tI0i/bnZvb6I/NSKctMJ48U3sNM+/3BpbB4JwdixRwtHtN75leAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168951; c=relaxed/simple;
	bh=mc/yzIWYCjgGLm4SahWWAiiUzXVOAVxI1mD/8EoJXOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T53NKgK1zyOnnKwATpsRHUjAEEhTQEXoJzUe5GSFEv/PorJWbwKupxJgBclV5NIkR1+mPOIFIbOszHPF4vyUkBwDwJuwDCPWadmbJzqJyscZ5sKjAH1S0DIpfg6JHvdDxvfgSJyQFCffld8AVz/QJOYn/OtRIn8r2/oPsM3+6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70B1FFEC;
	Thu, 17 Oct 2024 05:42:55 -0700 (PDT)
Received: from [10.1.34.186] (XHFQ2J9959.cambridge.arm.com [10.1.34.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720173F71E;
	Thu, 17 Oct 2024 05:42:23 -0700 (PDT)
Message-ID: <7aa84080-6845-496a-a394-30d334632298@arm.com>
Date: Thu, 17 Oct 2024 13:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 34/57] sata_sil24: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: Niklas Cassel <cassel@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Damien Le Moal <dlemoal@kernel.org>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Kees Cook <kees@kernel.org>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-34-ryan.roberts@arm.com> <ZxDUZMDf2Xfz2tvi@ryzen.lan>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZxDUZMDf2Xfz2tvi@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2024 10:09, Niklas Cassel wrote:
> Hello Ryan,
> 
> While I realize that this has not always been consistent,
> please prefix the subject with "ata: ", so that it becomes
> "ata: sata_sil24: ".

Noted; I'll fix this in the next version.

> 
> On Mon, Oct 14, 2024 at 11:58:41AM +0100, Ryan Roberts wrote:
>> To prepare for supporting boot-time page size selection, refactor code
>> to remove assumptions about PAGE_SIZE being compile-time constant. Code
>> intended to be equivalent when compile-time page size is active.
>>
>> Convert "struct sil24_ata_block" and "struct sil24_atapi_block" to use a
>> flexible array member for their sge[] array. The previous static size of
>> SIL24_MAX_SGE depends on PAGE_SIZE so doesn't work for boot-time page
>> size.
>>
>> Wrap global variables that are initialized with PAGE_SIZE derived values
>> using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
>> deferred for boot-time page size builds.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> ***NOTE***
>> Any confused maintainers may want to read the cover note here for context:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>
>>  drivers/ata/sata_sil24.c | 46 +++++++++++++++++++---------------------
>>  1 file changed, 22 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
>> index 72c03cbdaff43..85c6382976626 100644
>> --- a/drivers/ata/sata_sil24.c
>> +++ b/drivers/ata/sata_sil24.c
>> @@ -42,26 +42,25 @@ struct sil24_sge {
>>  	__le32	flags;
>>  };
>>  
>> +/*
>> + * sil24 fetches in chunks of 64bytes.  The first block
>> + * contains the PRB and two SGEs.  From the second block, it's
>> + * consisted of four SGEs and called SGT.  Calculate the
>> + * number of SGTs that fit into one page.
>> + */
>> +#define SIL24_PRB_SZ	(sizeof(struct sil24_prb) + 2 * sizeof(struct sil24_sge))
>> +#define SIL24_MAX_SGT	((PAGE_SIZE - SIL24_PRB_SZ) / (4 * sizeof(struct sil24_sge)))
>> +
>> +/*
>> + * This will give us one unused SGEs for ATA.  This extra SGE
>> + * will be used to store CDB for ATAPI devices.
>> + */
>> +#define SIL24_MAX_SGE	(4 * SIL24_MAX_SGT + 1)
>>  
>>  enum {
>>  	SIL24_HOST_BAR		= 0,
>>  	SIL24_PORT_BAR		= 2,
>>  
>> -	/* sil24 fetches in chunks of 64bytes.  The first block
>> -	 * contains the PRB and two SGEs.  From the second block, it's
>> -	 * consisted of four SGEs and called SGT.  Calculate the
>> -	 * number of SGTs that fit into one page.
>> -	 */
>> -	SIL24_PRB_SZ		= sizeof(struct sil24_prb)
>> -				  + 2 * sizeof(struct sil24_sge),
>> -	SIL24_MAX_SGT		= (PAGE_SIZE - SIL24_PRB_SZ)
>> -				  / (4 * sizeof(struct sil24_sge)),
>> -
>> -	/* This will give us one unused SGEs for ATA.  This extra SGE
>> -	 * will be used to store CDB for ATAPI devices.
>> -	 */
>> -	SIL24_MAX_SGE		= 4 * SIL24_MAX_SGT + 1,
>> -
>>  	/*
>>  	 * Global controller registers (128 bytes @ BAR0)
>>  	 */
>> @@ -244,13 +243,13 @@ enum {
>>  
>>  struct sil24_ata_block {
>>  	struct sil24_prb prb;
>> -	struct sil24_sge sge[SIL24_MAX_SGE];
>> +	struct sil24_sge sge[];
>>  };
>>  
>>  struct sil24_atapi_block {
>>  	struct sil24_prb prb;
>>  	u8 cdb[16];
>> -	struct sil24_sge sge[SIL24_MAX_SGE];
>> +	struct sil24_sge sge[];
>>  };
>>  
>>  union sil24_cmd_block {
>> @@ -373,7 +372,7 @@ static struct pci_driver sil24_pci_driver = {
>>  #endif
>>  };
>>  
>> -static const struct scsi_host_template sil24_sht = {
>> +static DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(struct scsi_host_template, sil24_sht, {
>>  	__ATA_BASE_SHT(DRV_NAME),
>>  	.can_queue		= SIL24_MAX_CMDS,
>>  	.sg_tablesize		= SIL24_MAX_SGE,
>> @@ -382,7 +381,7 @@ static const struct scsi_host_template sil24_sht = {
>>  	.sdev_groups		= ata_ncq_sdev_groups,
>>  	.change_queue_depth	= ata_scsi_change_queue_depth,
>>  	.device_configure	= ata_scsi_device_configure
>> -};
>> +});
>>  
>>  static struct ata_port_operations sil24_ops = {
>>  	.inherits		= &sata_pmp_port_ops,
>> @@ -1193,7 +1192,7 @@ static int sil24_port_start(struct ata_port *ap)
>>  	struct device *dev = ap->host->dev;
>>  	struct sil24_port_priv *pp;
>>  	union sil24_cmd_block *cb;
>> -	size_t cb_size = sizeof(*cb) * SIL24_MAX_CMDS;
>> +	size_t cb_size = PAGE_SIZE * SIL24_MAX_CMDS;
>>  	dma_addr_t cb_dma;
>>  
>>  	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
>> @@ -1258,7 +1257,6 @@ static void sil24_init_controller(struct ata_host *host)
>>  
>>  static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  {
>> -	extern int __MARKER__sil24_cmd_block_is_sized_wrongly;
>>  	struct ata_port_info pi = sil24_port_info[ent->driver_data];
>>  	const struct ata_port_info *ppi[] = { &pi, NULL };
>>  	void __iomem * const *iomap;
>> @@ -1266,9 +1264,9 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  	int rc;
>>  	u32 tmp;
>>  
>> -	/* cause link error if sil24_cmd_block is sized wrongly */
>> -	if (sizeof(union sil24_cmd_block) != PAGE_SIZE)
>> -		__MARKER__sil24_cmd_block_is_sized_wrongly = 1;
>> +	/* union sil24_cmd_block must be PAGE_SIZE */
>> +	BUG_ON(struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE) != PAGE_SIZE);
>> +	BUG_ON(struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE) > PAGE_SIZE);
>>  
>>  	ata_print_version_once(&pdev->dev, DRV_VERSION);
>>  
>> -- 
>> 2.43.0
>>
> 
> As you might know, there is an effort to annotate all flexible array
> members with their run-time size information, see commit:
> dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")

I'm vaguely aware of it. But as I understand it, __counted_by() nominates
another member in the struct which keeps the count? In this case, there is no
such member, it's size is implicit based on the value of PAGE_SIZE. So I'm not
sure if it's practical to use it here?

> 
> I haven't looked at the DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST macro, but since

DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(), when doing a boot-time page size build,
defers the initialization of the global variable to kernel init time, when
PAGE_SIZE is known. Because SIL24_MAX_SGE is defined in terms of PAGE_SIZE, this
deferral is required.

> sge[] now becomes a flexible array member, I think it would be nice if it
> would be possible to somehow use the __counted_by macro.
> 
> Other than that, this looks good to me.

Thanks for the review!

> 
> 
> Kind regards,
> Niklas

