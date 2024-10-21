Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C40946C;
	Mon, 21 Oct 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502685; cv=none; b=dwUJuCMQxUgM86cvz1AIIROkDthRb1gZpXxpVGMRV3amnqOLRZTIqENlerWPAJZE7p1ewXFKZrNkpowMXANSDGdBFKx8JWR4/tUsjSxVsHMOYfy37dvfYv7h8UsGziIeNiGVp9f6dWMth1Bfsh/Kdjrf2aYjSN+lNEso4iI8gJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502685; c=relaxed/simple;
	bh=SjKP1oIEXTiCN0oAwEK9P+slmL0v48ocKI9D5tnpIIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQfpV1/wjQCVVw65n6CjnzFuE5ENZEKO6MKNebJkXCVzj7+IVBv7tgHLVwWnAXKRBD9VV8M/gic+LQDgflHeqMCHnjQ5oNF/dOGxWHf0WVcXv+rP+j+gZjJCw6GqUFy39M8h4UVNiR/tPipFfiHza4gB/p//E1sdDLPWZ6GKpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8769DA7;
	Mon, 21 Oct 2024 02:25:11 -0700 (PDT)
Received: from [10.57.87.148] (unknown [10.57.87.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAAF13F73B;
	Mon, 21 Oct 2024 02:24:38 -0700 (PDT)
Message-ID: <2f578256-7e56-491f-a4ca-ad6caa72b7ae@arm.com>
Date: Mon, 21 Oct 2024 10:24:37 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZxEISOhaqRvHlc3U@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2024 13:51, Niklas Cassel wrote:
> On Thu, Oct 17, 2024 at 01:42:22PM +0100, Ryan Roberts wrote:
>> On 17/10/2024 10:09, Niklas Cassel wrote:
> 
> (snip)
> 
>>> As you might know, there is an effort to annotate all flexible array
>>> members with their run-time size information, see commit:
>>> dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
>>
>> I'm vaguely aware of it. But as I understand it, __counted_by() nominates
>> another member in the struct which keeps the count? In this case, there is no
>> such member, it's size is implicit based on the value of PAGE_SIZE. So I'm not
>> sure if it's practical to use it here?
> 
> Neither am I :)
> 
> Perhaps some of the flexible array member experts like
> Kees Cook or Gustavo A. R. Silva could help us out here.

The GCC feature request is clear that it is explicitly to mark a member as the count variable: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896

But, yes, would be good to hear from Kees or Gustavo if there is an alternative mechanism for what we are doing here.

> 
> Would it make sense to add another struct member and simply initialize
> it to PAGE_SIZE, in order to be able to use the __counted_by macro?

I guess that _could_ be done. But the way the driver is currently structured takes the sge array pointer and passes that around for DMA, so I think the value of this tag within the struct would be lost anyway. It would also require reducing the number of sge entries to make space for the count, and given I'm not really familiar with the driver or HW, I'd be concerned that this could cause a performance regression. Overall, my preference is to leave it as is.

That said, while investigating this, I've spotted a bug in my change. paddr calculation in sil24_qc_issue() is incorrect since sizeof(*pp->cmd_block) is no longer PAGE_SIZE. Based on feedback in another patch, I'm also converting the BUG_ONs to WARN_ON_ONCEs.

Additional proposed change, which I'll plan to include in the next version:

---8<---
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 85c6382976626..c402bf998c4ee 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -257,6 +257,10 @@ union sil24_cmd_block {
        struct sil24_atapi_block atapi;
 };
 
+#define SIL24_ATA_BLOCK_SIZE   struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE)
+#define SIL24_ATAPI_BLOCK_SIZE struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE)
+#define SIL24_CMD_BLOCK_SIZE   max(SIL24_ATA_BLOCK_SIZE, SIL24_ATAPI_BLOCK_SIZE)
+
 static const struct sil24_cerr_info {
        unsigned int err_mask, action;
        const char *desc;
@@ -886,7 +890,7 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
        dma_addr_t paddr;
        void __iomem *activate;
 
-       paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
+       paddr = pp->cmd_block_dma + tag * SIL24_CMD_BLOCK_SIZE;
        activate = port + PORT_CMD_ACTIVATE + tag * 8;
 
        /*
@@ -1192,7 +1196,7 @@ static int sil24_port_start(struct ata_port *ap)
        struct device *dev = ap->host->dev;
        struct sil24_port_priv *pp;
        union sil24_cmd_block *cb;
-       size_t cb_size = PAGE_SIZE * SIL24_MAX_CMDS;
+       size_t cb_size = SIL24_CMD_BLOCK_SIZE * SIL24_MAX_CMDS;
        dma_addr_t cb_dma;
 
        pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
@@ -1265,8 +1269,8 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
        u32 tmp;
 
        /* union sil24_cmd_block must be PAGE_SIZE */
-       BUG_ON(struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE) != PAGE_SIZE);
-       BUG_ON(struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE) > PAGE_SIZE);
+       WARN_ON_ONCE(SIL24_ATAPI_BLOCK_SIZE != PAGE_SIZE);
+       WARN_ON_ONCE(SIL24_ATA_BLOCK_SIZE != PAGE_SIZE - 16);
 
        ata_print_version_once(&pdev->dev, DRV_VERSION);
---8<---

> 
> 
>>
>>>
>>> I haven't looked at the DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST macro, but since
>>
>> DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(), when doing a boot-time page size build,
>> defers the initialization of the global variable to kernel init time, when
>> PAGE_SIZE is known. Because SIL24_MAX_SGE is defined in terms of PAGE_SIZE, this
>> deferral is required.
>>
>>> sge[] now becomes a flexible array member, I think it would be nice if it
>>> would be possible to somehow use the __counted_by macro.
>>>

