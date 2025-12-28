Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EB18AE3
	for <linux-ide@vger.kernel.org>; Sun, 28 Dec 2025 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766888731; cv=none; b=Y1P1xa8dX0+vwGWBpbNcEhBrsyEoju8d/BaCAwdx0kuuvmfXOAQV7gNyiyZUSEUSZYYqo1BCPn9UBInLC4s7fSG8ymkxGh1IzhGqmHCeL8ZR0qIigyz0CzoQre4xbfJzGDcOJSNJfBULNgOx3yv2SLhbGd8qCuIdgS5c5e+fYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766888731; c=relaxed/simple;
	bh=QTFZsyuXlzuDTT5wfik70Mj8xKg4xf1Zf/OEGyHkTBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ku0eCNi0lX8uFJ3XEfDBip6LwNYrsc7F+XWBfu6ALhDTAhgMHO1v+xuYU2FVkN8CJsfBi7RUhxRL2K3+KZ6dqzP5pVL0h7BSfsEFnwLRls2P5OLKub512MiAud1vfHXZgsKI0nBUkJNpEIa7P/KB+UU90u+CYHS0JONJARU9GFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BegzdZvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BegzdZvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20861C4CEF1;
	Sun, 28 Dec 2025 02:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766888731;
	bh=QTFZsyuXlzuDTT5wfik70Mj8xKg4xf1Zf/OEGyHkTBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BegzdZvcDPAvkulVV6+59ZqBLGmqcyhcyq8tabE6LXXAt5HFl87lH4scZUsXGShuJ
	 xp8YGGOTi0bpf+bmHeOZkhmRf4da7mfNk0RjaWoyFV0GxmdgudJMkHopH65AAXjDE/
	 +HxKQygQFM8wXCv4VAKx9x8OMQpuuZvUXcq/aAbBnQl2un5hbkvl67Smo3pz2JFXF9
	 B1jeVqOO3eejMHF3usFHf66ISw/oijtNbSQd4rrmeE8KCqaJZ+3KGTDOx+Ueep+IhU
	 87HXIW/ttkdBbdrut/1+NMOJcDdw1JDo6yZ7oTRWWD1TAdNt12bKZ1sRxJwKgJsmzH
	 05PE2KweOQamA==
Message-ID: <540eab26-dc68-4889-b8c1-f8a9ce015d43@kernel.org>
Date: Sun, 28 Dec 2025 11:25:28 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: avoid passthrough command
 starvation
To: Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Xingui Yang <yangxingui@huawei.com>, John Garry <john.g.garry@oracle.com>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <20251220002140.148854-3-dlemoal@kernel.org> <aUm4CdHWRcNmCQ3X@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aUm4CdHWRcNmCQ3X@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 06:28, Igor Pylypiv wrote:
>> +static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
>> +{
>> +	struct ata_queued_cmd *qc = ap->deferred_qc;
>> +
>> +	/*
>> +	 * If we have a deferred qc, then qc_defer() is defined and we can use
>> +	 * this callback to determine if this qc is good to go, unless EH has
>> +	 * been scheduled.
>> +	 */
>> +	if (!qc)
>> +		return;
>> +
>> +	if (ata_port_eh_scheduled(ap)) {
>> +		ata_scsi_requeue_deferred_qc(ap);
>> +		return;
>> +	}
>> +	if (!ap->ops->qc_defer(qc))
>> +		queue_work(system_highpri_wq, &ap->deferred_qc_work);
> 
> Do we need to call cancel_work_sync(&ap->deferred_qc_work) in ata_port_detach()?

Good point. I added that.

-- 
Damien Le Moal
Western Digital Research
