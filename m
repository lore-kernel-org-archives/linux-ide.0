Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9F147C7E
	for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836464; cv=none; b=U7BxNvAvWAHwx9SyzLJDLWFYPBNh+0ur910vnbVfk2JjHJfIVytIox59TsbAGZZKrXh1+5Z+0G5zwvvW1M2uJRgji1cwSFQnzxKgvj3KsYxdP+5pMQWHJSDyEF4mDYFkvZW+BV8fWgbU2wlmafHcEABsT6pPt24njlO4W59iCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836464; c=relaxed/simple;
	bh=XzE6yzPe2bNAjFwthdRxZZzLKN1C49eNd52wBJv8kz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onW6jp1B5cjN52J2HeDrJhvXf/fIV0kDCDBex6C7M80X64bFfRyuupx5JNZJZO7+xcTmiwYcU3/NXd6U8TWIEoQRXL+ls/BOe46COSVqNoc074Eas88dnw9XOBlZiyrZT1hIaSKN4Ev4f5U7Q/IiSdXEDs2GD0Ij2FMjx/WktXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsawKjzX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsawKjzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2180C433F1;
	Thu, 11 Apr 2024 11:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712836464;
	bh=XzE6yzPe2bNAjFwthdRxZZzLKN1C49eNd52wBJv8kz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MsawKjzXCAA1u5CLvi4p9q8e2j3a0ivPgR+enDsdne/p88r4MOlcuQK//J7ALf/S7
	 Im/vk7SUDxHDkwEQNjATs2MTIaoU1Q2ZmYBhHh/IoPItb9hY0zzhlf0CVAcrGnjF2I
	 PUVah48aHXKvV8YLi4ZmCsu18DId3+oDFlpGIjwSy+M416czJLvgH/rTfubEWKU5Xg
	 gOv951VNk7FuExTN1qjQrSxht3/ZDkbeJXQxghKzOnmM+c/SQ5Nd3Tfw4d4UAqAzM3
	 fNDTlt14dOA9lXJmm9iR6ASmk/A7u11V9su1DO0c5fnS6LBABhKaVPYCHbYeHOTID2
	 hh09duXzSueAQ==
Message-ID: <51091e44-7cca-42c0-93c5-8f4d99e55fa8@kernel.org>
Date: Thu, 11 Apr 2024 20:54:22 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Remove ata_exec_internal_sg()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240411083158.723212-1-dlemoal@kernel.org>
 <ZhfC5+R2wB3I2bwp@x1-carbon>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZhfC5+R2wB3I2bwp@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 20:00, Niklas Cassel wrote:
> On Thu, Apr 11, 2024 at 05:31:58PM +0900, Damien Le Moal wrote:
>> ata_exec_internal() is the only caller of ata_exec_internal_sg() and
>> always calls this function with a single element scattergather list.
>> Remove ata_exec_internal_sg() and code it directly in
>> ata_exec_internal(), simplifying a little the sgl handling for the
>> command.
>>
>> While at it, cleanup comments (capitalization) and change the variable
>> auto_timeout type to a boolean.
>>
>> No functional change.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/ata/libata-core.c | 105 ++++++++++++--------------------------
>>  1 file changed, 34 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index be3412cdb22e..ec7e57a0f684 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -1480,19 +1480,19 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>>  }
>>  
>>  /**
>> - *	ata_exec_internal_sg - execute libata internal command
>> + *	ata_exec_internal - execute libata internal command
>>   *	@dev: Device to which the command is sent
>>   *	@tf: Taskfile registers for the command and the result
>>   *	@cdb: CDB for packet command
>>   *	@dma_dir: Data transfer direction of the command
>> - *	@sgl: sg list for the data buffer of the command
>> - *	@n_elem: Number of sg entries
>> + *	@buf: Data buffer of the command
>> + *	@buflen: Length of data buffer
>>   *	@timeout: Timeout in msecs (0 for default)
>>   *
>> - *	Executes libata internal command with timeout.  @tf contains
>> - *	command on entry and result on return.  Timeout and error
>> - *	conditions are reported via return value.  No recovery action
>> - *	is taken after a command times out.  It's caller's duty to
>> + *	Executes libata internal command with timeout. @tf contains
>> + *	the command on entry and the result on return. Timeout and error
>> + *	conditions are reported via the return value. No recovery action
>> + *	is taken after a command times out. It is the caller's duty to
>>   *	clean up after timeout.
>>   *
>>   *	LOCKING:
>> @@ -1501,34 +1501,37 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>>   *	RETURNS:
>>   *	Zero on success, AC_ERR_* mask on failure
>>   */
>> -static unsigned ata_exec_internal_sg(struct ata_device *dev,
>> -				     struct ata_taskfile *tf, const u8 *cdb,
>> -				     int dma_dir, struct scatterlist *sgl,
>> -				     unsigned int n_elem, unsigned int timeout)
>> +unsigned int ata_exec_internal(struct ata_device *dev,
>> +			       struct ata_taskfile *tf, const u8 *cdb,
>> +			       int dma_dir, void *buf, unsigned int buflen,
>> +			       unsigned int timeout)
>>  {
>>  	struct ata_link *link = dev->link;
>>  	struct ata_port *ap = link->ap;
>>  	u8 command = tf->command;
>> -	int auto_timeout = 0;
>>  	struct ata_queued_cmd *qc;
>>  	unsigned int preempted_tag;
>>  	u32 preempted_sactive;
>>  	u64 preempted_qc_active;
>>  	int preempted_nr_active_links;
>> +	bool auto_timeout = false;
>>  	DECLARE_COMPLETION_ONSTACK(wait);
>>  	unsigned long flags;
>>  	unsigned int err_mask;
>>  	int rc;
>>  
>> +	if (WARN_ON(dma_dir != DMA_NONE && !buf))
>> +		return AC_ERR_INVALID;
>> +
>>  	spin_lock_irqsave(ap->lock, flags);
>>  
>> -	/* no internal command while frozen */
>> +	/* No internal command while frozen */
>>  	if (ata_port_is_frozen(ap)) {
>>  		spin_unlock_irqrestore(ap->lock, flags);
>>  		return AC_ERR_SYSTEM;
>>  	}
>>  
>> -	/* initialize internal qc */
>> +	/* Initialize internal qc */
>>  	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
>>  
>>  	qc->tag = ATA_TAG_INTERNAL;
>> @@ -1547,12 +1550,12 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>>  	ap->qc_active = 0;
>>  	ap->nr_active_links = 0;
>>  
>> -	/* prepare & issue qc */
>> +	/* Prepare and issue qc */
>>  	qc->tf = *tf;
>>  	if (cdb)
>>  		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
>>  
>> -	/* some SATA bridges need us to indicate data xfer direction */
>> +	/* Some SATA bridges need us to indicate data xfer direction */
>>  	if (tf->protocol == ATAPI_PROT_DMA && (dev->flags & ATA_DFLAG_DMADIR) &&
>>  	    dma_dir == DMA_FROM_DEVICE)
>>  		qc->tf.feature |= ATAPI_DMADIR;
>> @@ -1560,13 +1563,10 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>>  	qc->flags |= ATA_QCFLAG_RESULT_TF;
>>  	qc->dma_dir = dma_dir;
>>  	if (dma_dir != DMA_NONE) {
>> -		unsigned int i, buflen = 0;
>> -		struct scatterlist *sg;
>> +		struct scatterlist sgl;
> 
> Here you stack allocate a sgl, and save that stack allocated address
> for sgl in in qc->sg (using ata_sg_init()), however, a stack allocated
> variable is only valid until the scope ends.
> (See my comment at the end of this email.)
> 
> So by having the stack allocated variable here (instead of at e.g. the
> top of the function), when __ata_qc_complete() calls ata_sg_clean(),
> or when ata_qc_issue() uses qc->sg, the value that they access might
> be something else, since this variable has already went out of scope,
> and some other variable might have been allocated at that stack address.

Oh, crap. How did I not see crashes with that... Embarassing :)
I will move the declaration of sg at the top of the function.


-- 
Damien Le Moal
Western Digital Research

