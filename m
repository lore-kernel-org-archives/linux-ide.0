Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318C3A1E64
	for <linux-ide@vger.kernel.org>; Fri, 19 Dec 2025 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187354; cv=none; b=MhqT+ld7sSxJXUPz7FCOU3/Jnqg0XjltGgUZBassVjDf5JsLn8GtIjNdi031k9wBsNmPC30lYmExh0O26afcCoAgVfcqXvhLKeBycTjq8PhLwgWi1Zba5oN/qqVew/VGya2N0OHaz2+eGWERAA6gHjkdkuWe+ilvqk/Cy2cjiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187354; c=relaxed/simple;
	bh=LAyj8cQ6UlTXq3av5J0USNUu97QXxWuEeokUPO9/A2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+/8xGCqi0/BLwSZdb2U1N5anHvNmisEHjWRm9UjLfDVumMQDRxwBxjGhcs2R3Wq8j8JZ32NewJrWq7GAmlx/NT9Jowa7ZKqG4b87T4Ft1d4gbVdmx5sltVC2na/isyyXwIXyPjlM8WS6KlJ1d7TKhCArFbqf3jYpcVoaefbQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvn2qBvM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvn2qBvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F47C4CEF1;
	Fri, 19 Dec 2025 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766187353;
	bh=LAyj8cQ6UlTXq3av5J0USNUu97QXxWuEeokUPO9/A2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qvn2qBvM2E29l6qnXvp9pEKgW0Wg74uym/zhaAD305sxIF2Volt3ST+hC9TG5lXS3
	 cgiGnW76ordiyj8ZdCccYmqXHUyhKHqZB0TrazD8qrXCisivN3ldjM2d9m2c/6JfiV
	 uSrST2wh6i4JX2VxniP4NVKenasxOm95OMPclLTKIUW6IbNWAa2v49HCDHfWW6jpEN
	 lzZtzG7+j5SXJEHagZeAqxycOo67VC/QjEKTCm6TlSsMU8mWpkcKTsVN2D4zSZjgnZ
	 +mipG4jyQW61iOHMrQp/gRy6Pw9OJXwie+O4TryMMGNzAwLVwXohoCe1f5Uvzn2928
	 FeclzeYWmE+Kw==
Message-ID: <ca5e7ee3-a996-425d-8127-f243881e0a9c@kernel.org>
Date: Sat, 20 Dec 2025 08:35:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ata: libata-scsi: avoid passthrough command
 starvation
To: John Garry <john.g.garry@oracle.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Xingui Yang <yangxingui@huawei.com>
References: <20251219075134.501727-1-dlemoal@kernel.org>
 <20251219075134.501727-3-dlemoal@kernel.org>
 <e67adee8-281b-4a57-ab08-3b02acec7298@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e67adee8-281b-4a57-ab08-3b02acec7298@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 23:07, John Garry wrote:
>  >   	init_waitqueue_head(&ap->eh_wait_q);
>>   	init_completion(&ap->park_req_pending);
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 2586e77ebf45..b90b17f680f8 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -917,6 +917,12 @@ static void ata_eh_set_pending(struct ata_port *ap, bool fastdrain)
>>   
>>   	ap->pflags |= ATA_PFLAG_EH_PENDING;
>>   
>> +	/*
>> +	 * If we have a deferred qc, requeue it so that it is retried once EH
> 
> big nitpick: qc or QC? It seems quite inconsistent.

Yeah. "qc" I think, as that is what is being used most often. libata-eh has a
couple of "QC" in a comment though.


>> +void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>> +{
>> +	struct ata_queued_cmd *qc = ap->deferred_qc;
> 
> I think that you can just return early for !qc, no need to always be 
> doing the lockdep_assert_held check. However, lockdep is slow anyway and 
> I don't think that lockdep_assert_held does anything when lockdep is 
> disabled (so returning early does not nothing, apart from reduce 
> indentation).

OK for the return early. Bu even for that case, we should have the lockdep
annotation since we are not supposed to be looking at ap->deferred_qc without
holding the port lock. But granted, the lockdep assert may be overkill. Let me
check if we really need/want it.

>>   static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
>>   {
>>   	int ret;
>>   
>> +	/*
>> +	 * If we already have a deferred QC, then rely on the SCSI layer to
>> +	 * defer and requeue all incoming commands until the deferred QC is
>> +	 * processed, once all on-going commands are completed.
>> +	 */
>> +	if (ap->deferred_qc) {
>> +		ata_qc_free(qc);
> 
> Would adding WARN_ON_ONCE(ap->deferred_qc == qc) be totally unnecessary?

If such warning trigger, I think things would be really very broken, and likely
all sorts of failures/hangs would already be happening. Talking from experience
here as the initial versions of this patch where less than perfect :)


-- 
Damien Le Moal
Western Digital Research
