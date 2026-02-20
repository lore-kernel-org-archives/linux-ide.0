Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07611C84AB
	for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624107; cv=none; b=GfXXueChUikpFKvmcz2merCpT/KQ8TvL0mZ/t/43PNuTnqnL94eoUjSmSbA2o9e22+D8rBMALyZ3fva4GaH+YzGg5b20/waqocfSWw8idfo+3Tu4QaNK7qu27ApiDJpvE2PUD+7iI1shW33JjTEjTnIZ/vfb0eGhN2HRxuOMeL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624107; c=relaxed/simple;
	bh=3mosdxtCdzvezbf6yW4dbDu3e6k/YtGypF2fh2EB2ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7Y2qiwJucSlBN5qwc7wrRgwIhmt0MDi4tiRhHHVSrSxYjlvMhmBNU1E/JlnRITU2sm33Bpj8yHtWDs2kl+QvB8vG6WlVcVnHwwckfw5hrrFCR/Awrw3zU862c+irhP3r/pHTiq8iSJtVREpgi57gEeiWKfKPRDL2uWWr/+pa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXChO9sp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXChO9sp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF40C116C6;
	Fri, 20 Feb 2026 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771624107;
	bh=3mosdxtCdzvezbf6yW4dbDu3e6k/YtGypF2fh2EB2ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZXChO9spvj2510pi5hHJuuLsH3wwXbHHW93aus8Urzg3sGCsuROyMymlrxDg7+PDD
	 cbDftEX/wzjpTcl6vR/4D2YA5oWYSQP8HONl7thEP6/vTZLHIHKUuCOZfF1iga1G0C
	 0YqmGy9OMvUupADFOf/VE4MicTNwdHnscWe/F/qdbt5+v8aXU/tDl4S+esZNpodCG4
	 zRE0Tiv5ke2qCgXghaqDhL3nEypto4o4D67d+jxxqh3tESZUKu3B+B7im/7kFSqD3u
	 +C6NYePYLD+G3ulBK0Wj2+qfAQO4b1Vh09JNhko3mIoYA1egSBIe2vaPnFAvpRnAya
	 MAzX5MTKuR1kQ==
Message-ID: <5f0aa0a4-0e0e-499c-8bb1-0bd665b36a67@kernel.org>
Date: Sat, 21 Feb 2026 06:48:25 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-core: fix cancellation of a port deferred
 qc work
To: Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20260220050053.390135-1-dlemoal@kernel.org>
 <20260220050053.390135-3-dlemoal@kernel.org> <aZia1dnJ9pVkf3pq@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aZia1dnJ9pVkf3pq@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/26 02:33, Igor Pylypiv wrote:
> On Fri, Feb 20, 2026 at 02:00:53PM +0900, Damien Le Moal wrote:
>> cancel_work_sync() is a sleeping function so it cannot be called with
>> the spin lock of a port being held. Move the call to this function in
>> ata_port_detach() before locking the port and add a call to
>> ata_scsi_requeue_deferred_qc() to make sure there are no remaining
>> deferred qc.
>>
>> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/ata/libata-core.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index beb6984b379a..54afa4df987e 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -6254,9 +6254,18 @@ static void ata_port_detach(struct ata_port *ap)
>>  	/* Wait for any ongoing EH */
>>  	ata_port_wait_eh(ap);
>>  
>> +	/* Requeue any remaining deferred qc. */
>> +	ata_scsi_requeue_deferred_qc(ap);
>> +
> 
> ata_scsi_requeue_deferred_qc() requires the port lock to be held (function
> has a lockdep assert).

Doh ! Yes, of course ! I had lockdep disabled on my test rig... Bad idea :)
Let me fix this.

> 
>>  	mutex_lock(&ap->scsi_scan_mutex);
>> +
>> +	/* Make sure the deferred qc work finished. */
>> +	cancel_work_sync(&ap->deferred_qc_work);
>> +
>>  	spin_lock_irqsave(ap->lock, flags);
>>  
>> +	WARN_ON(ap->deferred_qc);
>> +
>>  	/* Remove scsi devices */
>>  	ata_for_each_link(link, ap, HOST_FIRST) {
>>  		ata_for_each_dev(dev, link, ALL) {
>> @@ -6269,10 +6278,6 @@ static void ata_port_detach(struct ata_port *ap)
>>  		}
>>  	}
>>  
>> -	/* Make sure the deferred qc work finished. */
>> -	cancel_work_sync(&ap->deferred_qc_work);
>> -	WARN_ON(ap->deferred_qc);
>> -
>>  	/* Tell EH to disable all devices */
>>  	ap->pflags |= ATA_PFLAG_UNLOADING;
>>  	ata_port_schedule_eh(ap);
>> -- 
>> 2.53.0
>>
>>


-- 
Damien Le Moal
Western Digital Research
