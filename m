Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C230242D9B
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351678; cv=none; b=GUd5OqalvK/Vv9iopMcGYjCdkjyKzpBZzU4GysqiT91MU0L7BlBYk6VL4TT+9GMbf5eyZnwyTHAddZRpEXb7moupamYElAv3IyyR0lzRWl0i2DthSUehXRgqnbhkbpgj11IbtC3LMIDVSoANv4YcY+YMy7xJ1C8FOiYuFiylqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351678; c=relaxed/simple;
	bh=IjMfRWonOFquH7Eajp0qi9noqdBRD4A2eXDbbcyGFAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvnFvz708Cgtn3aZUIf9LK+KZ9CiK8SOl5x6fchCFOejTtoQK/lko6nMZ5OXy8EBBmWlhxva5JMztEVeeanHpdVES/Sa+xcvyZqvqQMVIqd0qamQzIxKyx2wutTL9BwG0YMAMg0kEFN8lmdHhIPhki7T142YmIqzPB/OEn4DJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/6/WcxN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/6/WcxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE71C116B1;
	Fri,  2 Jan 2026 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767351677;
	bh=IjMfRWonOFquH7Eajp0qi9noqdBRD4A2eXDbbcyGFAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B/6/WcxNbCRMXY1NuaU5g5G/ZPSTkWY+3zNdaEKLsBJ+Xw7tsE53F+VsrZT5tD++R
	 23nDZqvAQyqlaNK4xlqfH3MFOd/znhIiI90PHa1jvI7+7uqj6xBk4OzvrtgOw2zZWG
	 XiRPZjiNhN5SpuUqBvaq0B8M4c+dbBURlPlAPOfRxehTjhseNAyqEo1GLzwcbzRxVX
	 Xeb0n/SdQWoX6k/xaoCSqrx0CW8rua5WtIA3UIBvwfduSfkF4C77GPv6tCjiQ9Vj2a
	 Elu2IQ8F7jBeFLV5ZXn9YCF6PIYx6en2PqK5X6zpD1EGUv7I+nf/y5xr1Iuc7Mjwzt
	 aos9pcMk8PCsg==
Message-ID: <26159237-5afc-48c5-a739-20e3ea121062@kernel.org>
Date: Fri, 2 Jan 2026 20:01:16 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: avoid passthrough command
 starvation
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Xingui Yang <yangxingui@huawei.com>, John Garry <john.g.garry@oracle.com>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <20251220002140.148854-3-dlemoal@kernel.org> <aVULegmRVY2O-TUC@ryzen>
 <0b9fb4a6-db2d-488d-a486-74c67709b3a2@kernel.org> <aVeT9_ZK1NtUXMCT@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aVeT9_ZK1NtUXMCT@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/2/26 18:46, Niklas Cassel wrote:
> On Fri, Jan 02, 2026 at 10:10:44AM +0900, Damien Le Moal wrote:
>> On 12/31/25 20:39, Niklas Cassel wrote:
>>> On Sat, Dec 20, 2025 at 09:21:40AM +0900, Damien Le Moal wrote:
>>>> @@ -1702,6 +1779,17 @@ static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
>>>>  	if (!ret)
>>>>  		return 0;
>>>>  
>>>> +	/*
>>>> +	 * We must defer this qc: if this is not an NCQ command, keep this qc
>>>> +	 * as a deferred one and wait for all on-going NCQ commands to complete
>>>> +	 * before issuing it with the deferred qc work.
>>>> +	 */
>>>> +	if (!ata_is_ncq(qc->tf.protocol)) {
>>>> +		ap->deferred_qc = qc;
>>>> +		return SCSI_MLQUEUE_DEVICE_BUSY;
>>>
>>> Here you save the qc, and you return SCSI_MLQUEUE_DEVICE_BUSY;
>>> SCSI_MLQUEUE_DEVICE_BUSY will cause the block layer to reinsert the request
>>> in the queue, so you will get the same request sent to ata_scsi_translate()
>>> again, even though you have save it. A little ugly IMO.
>>
>> No it will not cause a requeue in this case because this change:
>>
>>  	rc = ata_scsi_defer(ap, qc);
>> -	if (rc)
>> +	if (rc) {
>> +		if (qc == ap->deferred_qc)
>> +			return 0;
>>
>> ensures that we return "0", thus telling the scsi and block layer that the
>> command/request was accepted, but we do *not* call ata_qc_issue() for that qc.
>> It is deferred and will be issued by the deferred qc work once the queue drains.
> 
> I see how I got confused.
> 
> In the case where we store the deferred QC, you overload the return value.
> But the original return value did not make sense (SCSI_MLQUEUE_DEVICE_BUSY),
> as it means ask upper layer to requeue. I suggest that you let ata_scsi_defer()
> return some other value in this case.
> 
> ATA_DEFER_ACTION_CMD_STORED or something.
> 
> Then at the call site:
> 
> 	rc = ata_scsi_defer(ap, qc);
> 	if (rc) {
> 		if (rc == ATA_DEFER_ACTION_CMD_STORED)
> 			return 0;
> 		return rc;
> 	}

OK. Will send v5 with that.



-- 
Damien Le Moal
Western Digital Research
