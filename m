Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D8D198E6F;
	Mon, 21 Oct 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509983; cv=none; b=t96jAcWML5RsxkpIRKZBNuzPgkLdI1JiWFlImmDM0uUQGgdYAaOZmS4eKrnBj2ZTvIIvJXslEn/IfgDo/lMHtGs0LxiTD0QgIbNPllg/qyiTSrnB+ohZuBbntmMl/+oARJjrq8ANyvTSILWrMxqFKIXINykZIYUEyJiwKD9tbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509983; c=relaxed/simple;
	bh=eXElMq/1a3ZeIdUkaQeekewB1HwzNt8fpKY6IJrnxRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWTtaUnQI1IIztJ7nfxOQPd4E799qOfi4D0QT/vyyr01LGQxQvu8vhI/NmzNS0t9H0A7/8/FlUeO9bxG0OwMZ4bXJOCjBz2KMxqOG3iDSQSV/6L+8fEADOZOseK19ff4PPCmL+dvOh24H0gAqk51icoj3uHhJ925FdHO/mENlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F95ADA7;
	Mon, 21 Oct 2024 04:26:50 -0700 (PDT)
Received: from [10.57.87.148] (unknown [10.57.87.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700F03F528;
	Mon, 21 Oct 2024 04:26:17 -0700 (PDT)
Message-ID: <8e1e0824-1022-4f8f-9753-e134c7244d3a@arm.com>
Date: Mon, 21 Oct 2024 12:26:15 +0100
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
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-34-ryan.roberts@arm.com> <ZxDUZMDf2Xfz2tvi@ryzen.lan>
 <7aa84080-6845-496a-a394-30d334632298@arm.com> <ZxEISOhaqRvHlc3U@ryzen.lan>
 <2f578256-7e56-491f-a4ca-ad6caa72b7ae@arm.com> <ZxY1KAvGpyIzARtX@ryzen.lan>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZxY1KAvGpyIzARtX@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2024 12:04, Niklas Cassel wrote:
> On Mon, Oct 21, 2024 at 10:24:37AM +0100, Ryan Roberts wrote:
>> On 17/10/2024 13:51, Niklas Cassel wrote:
>>> On Thu, Oct 17, 2024 at 01:42:22PM +0100, Ryan Roberts wrote:
> 
> (snip)
> 
>> That said, while investigating this, I've spotted a bug in my change. paddr calculation in sil24_qc_issue() is incorrect since sizeof(*pp->cmd_block) is no longer PAGE_SIZE. Based on feedback in another patch, I'm also converting the BUG_ONs to WARN_ON_ONCEs.
> 
> Side note: Please wrap you lines to 80 characters max.

Yes sorry, I turned off line wrapping for that last mail because I didn't want
it to wrap the copy/pasted patch. I'll figure out how to mix and match for future.

> 
> 
>>
>> Additional proposed change, which I'll plan to include in the next version:
>>
>> ---8<---
>> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
>> index 85c6382976626..c402bf998c4ee 100644
>> --- a/drivers/ata/sata_sil24.c
>> +++ b/drivers/ata/sata_sil24.c
>> @@ -257,6 +257,10 @@ union sil24_cmd_block {
>>         struct sil24_atapi_block atapi;
>>  };
>>  
>> +#define SIL24_ATA_BLOCK_SIZE   struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE)
>> +#define SIL24_ATAPI_BLOCK_SIZE struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE)
>> +#define SIL24_CMD_BLOCK_SIZE   max(SIL24_ATA_BLOCK_SIZE, SIL24_ATAPI_BLOCK_SIZE)
>> +
>>  static const struct sil24_cerr_info {
>>         unsigned int err_mask, action;
>>         const char *desc;
>> @@ -886,7 +890,7 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
>>         dma_addr_t paddr;
>>         void __iomem *activate;
>>  
>> -       paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
>> +       paddr = pp->cmd_block_dma + tag * SIL24_CMD_BLOCK_SIZE;
>>         activate = port + PORT_CMD_ACTIVATE + tag * 8;
>>  
>>         /*
>> @@ -1192,7 +1196,7 @@ static int sil24_port_start(struct ata_port *ap)
>>         struct device *dev = ap->host->dev;
>>         struct sil24_port_priv *pp;
>>         union sil24_cmd_block *cb;
>> -       size_t cb_size = PAGE_SIZE * SIL24_MAX_CMDS;
>> +       size_t cb_size = SIL24_CMD_BLOCK_SIZE * SIL24_MAX_CMDS;
>>         dma_addr_t cb_dma;
>>  
>>         pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
>> @@ -1265,8 +1269,8 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>         u32 tmp;
>>  
>>         /* union sil24_cmd_block must be PAGE_SIZE */
> 
> This comment should probably be rephrased to be more clear then, since like
> you said sizeof(union sil24_cmd_block) will no longer be PAGE_SIZE.

How about:

/*
 * union sil24_cmd_block must be PAGE_SIZE once taking into account the 'sge'
 * flexible array members in struct sil24_atapi_block and struct sil24_ata_block
 */

> 
> 
>> -       BUG_ON(struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE) != PAGE_SIZE);
>> -       BUG_ON(struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE) > PAGE_SIZE);
>> +       WARN_ON_ONCE(SIL24_ATAPI_BLOCK_SIZE != PAGE_SIZE);
>> +       WARN_ON_ONCE(SIL24_ATA_BLOCK_SIZE != PAGE_SIZE - 16);
>>  
>>         ata_print_version_once(&pdev->dev, DRV_VERSION);
>> ---8<---

