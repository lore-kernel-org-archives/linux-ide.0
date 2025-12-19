Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92A22ACEB
	for <linux-ide@vger.kernel.org>; Fri, 19 Dec 2025 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766130438; cv=none; b=WsVQgU0fb97235xY86iNfUF7QHKKIFx4SKklZVqy6nGWMvkOcpxOKfzUoJH0CazS1JRLWSNbAY6p8mHuUJ/atggWie1sYvhcaFee50Hv+DKb/uSREvYdu1NqGDUizJrQQbc8yYp5GKntmfoR8cA/dNw/vynXcWPPub02o0WIMUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766130438; c=relaxed/simple;
	bh=2q7+1z4BV34XQ/lsjU3ziX3exzxT1pvAYudVIsM2/j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRZuweww/7MQVbECK/j6KXv06F7j+yH7d2Mn5Q8h6EKT7UQPCmENeUifEpojr7O25fURghQLzC5X6xmzHMJlBQ9ifauuYxMlNzGi5rTmOYeztuD+28hVu+bYV1NcJI64DCMp5xz715eb3kAzRnW7ReWQoqv78C42UytcR4xsz/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5i8jajF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5i8jajF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80347C4CEF1;
	Fri, 19 Dec 2025 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766130438;
	bh=2q7+1z4BV34XQ/lsjU3ziX3exzxT1pvAYudVIsM2/j4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P5i8jajFfGGGwoQQU8uIeKlMH2VljSsXpl1x9eYYJywT3HVh5l9Iz84lkeXUwJ1N1
	 v62Qo/43PRff/5ZSLyL5/KCUswLDwDTtV67uUxHeL/98bJVFbk4RFxDPk+uz7L7rve
	 HQcs6TDHQ4rNsKxFhHa0Sup7OuzRWEqgpEKI0bh2FPH3JfpF+cb3DG19cXCBtTvjVH
	 gfdxo67VD9m3wFHlKqMHkFOU4x1YhdAGNLs1StpB6vtKSON8Gc2WNRkTQdGogkleww
	 6xkz0nsWntGr3YQY0nj/4F1eFpMud6HEhm+vsigKSXqUzbHXB9/eVVydtwQ8DNgvna
	 pzqIZUIMotXWg==
Message-ID: <521d6ca5-5d80-44ee-acef-fb1887deb9e9@kernel.org>
Date: Fri, 19 Dec 2025 16:47:16 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-scsi: avoid passthrough command
 starvation
To: Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Xingui Yang <yangxingui@huawei.com>
References: <20251217231712.490765-1-dlemoal@kernel.org>
 <20251217231712.490765-3-dlemoal@kernel.org> <aUSXeEoBg1cYYdtK@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aUSXeEoBg1cYYdtK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 09:08, Igor Pylypiv wrote:
>>  static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
>>  {
>>  	int ret;
>>  
>> +	/*
>> +	 * If we already have a deferred QC, then rely on the SCSI layer to
>> +	 * defer and requeue all incoming commands until the deferred QC is
>> +	 * processed, once all on-going commands are completed.
>> +	 */
>> +	if (ap->deferred_qc)
>> +		return SCSI_MLQUEUE_DEVICE_BUSY;
> 
> Should we free qc here? ata_scsi_translate() does not free qc if
> ata_scsi_defer() returns a non-zero value.

Good catch ! Sending V2.

-- 
Damien Le Moal
Western Digital Research
