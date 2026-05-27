Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768443D3008
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906671; cv=none; b=ulsth9D5MLRUBJDa6WjmGquY6KUrHhqpTYjdMqP3IzmotAeZcqeBEiRN4zgZUs50ng98l4T9X7Y04wWfRHADFWV0gVGWKLsz4TvyQKroQ+4BcL1VCF4xGFNYIyL+f/OSCrMpNNekWW1zoNg8oI40AXff4Rn/IJXv/J3nkpgZjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906671; c=relaxed/simple;
	bh=dbxjNigIngh7M09b7eeSzi2wI8KJKgu7A35vpUeGZHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ki5ka6NjDzC94U2ARg4dUSLwGVhZhdZ0oLq3x1y1N/Ua1hft+0OyOP56hrt4GnQKVXlQIJbfIPtu/pM5l3iBQxxVui/pt0ABDFpi511KINP2oAlz3B4yfNDBwYt25EpUxUTDvmC9TiUkdh6kRm0A6nhMBT61QXrrsomkHS13YyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=larbHGhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="larbHGhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847A91F000E9;
	Wed, 27 May 2026 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779906670;
	bh=eNujTG/39fNaDCvNydRHCeSjfhARq2GR83v5Hjh/kaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=larbHGhkmcnQFeHr1bcPd90nLIE2hkEaA3zdMFbmbhgax2A6Xwf9HIawDOSuylBnO
	 45wlyArjMtg5YqDKWWJrpdszzddVQtTI0CcueCjtOY8JOTM8nDdd9QdNgDRLvrz/Tg
	 1WTBgiRdcGs3alX3TjdRHj3TBLGsgZDpebbUjeRkgannP67s97AEptoVyjwJAAC6AS
	 z8JYWxTKxBq2AKC75MChBM8VrmTIk1Kq6iC5IWlkXtifev3hu+CkPOQj6g7dMWbdqg
	 g21pLib5lvtJsYR0ZrHLjxV95UQNyAMWH07CyjZU2JZOYyFqDYFmJkPxOTI0OsvHfo
	 B/zjsf9n1m1Yw==
Message-ID: <646d74f4-c4d2-4786-8444-69434ff88e68@kernel.org>
Date: Thu, 28 May 2026 03:31:08 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] ata: libata: Fix ata_exec_internal()
To: Bart Van Assche <bvanassche@acm.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Marco Elver <elver@google.com>,
 Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <htejun@gmail.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-2-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260521173347.2079560-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/22 2:33, Bart Van Assche wrote:
> Some but not all ata_exec_internal() calls happen from the context of
> the ATA error handler. Commit c0c362b60e25 ("libata: implement cross-port
> EH exclusion") added ata_eh_release() and ata_eh_acquire() calls in
> ata_exec_internal(). Calling these functions is necessary if the caller
> holds the eh_mutex but is not allowed if the caller doesn't hold that
> mutex. Fix this by only calling ata_eh_release() and ata_eh_acquire() if
> the caller holds the eh_mutex. An example of an indirect caller of
> ata_exec_internal() that does not hold the eh_mutex is
> ata_host_register().
> 
> Fixes: c0c362b60e25 ("libata: implement cross-port EH exclusion")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
