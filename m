Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F09A59
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256040; cv=none; b=l2rQKQjliKMum/iKnJzTOmw0pymS87TeVYHyc3XXDUKkcdr+0Ky9JrzcVkCATnyrltXrBaZOrYYWa/pnLvTkh5vy3X7FtOCm+0lppo9Z5QjIOKzxWN5MBDUs3LYhAwfropz6feMtYwdstRn0IfFg3ZagNuyBifFP+QPpaXP0b7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256040; c=relaxed/simple;
	bh=Chsbqxd1N4qyhwFt7uxORGZsYjAmHU+OsXF9x3w6d9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/0W3X41FZgZb067vJp21cRcI6VSkMAeIzg9mLPrgTmcBrR6QkYPQZ3EtQa0c8AUcTGU6HVMZ4Ll57v7uRmzFyPoiCqSauYOJ/654dVx75JTq4DexynoR0tq8YU1ArgkoXd/ah5Wo9KqK/Ane4u4sLQlM2Ap6HZmWHsKUfYbhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJmKStFQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJmKStFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C295CC4CEE3;
	Mon, 30 Jun 2025 04:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751256040;
	bh=Chsbqxd1N4qyhwFt7uxORGZsYjAmHU+OsXF9x3w6d9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sJmKStFQwSuPw8z1mjdQTJ/l8exTxE2SaEBlrf9JnWr7I9zXy7JEiXY40I5PgWYzv
	 Vlqj7u3VBp41o4cCnDkgh9C16l8kdXmZqqiUomD7GQB/f6CHBXoA425u1KmzB3phR1
	 ZC+rvE0/gEqx0InMhEdwrltlnnZwqTsmbRhc8M+GTqFAwQNikd24dlzV1dZWXqTlmX
	 LRuiwzk3nfuGgNjkh+0ZkCY/dM5cnrTRfkXWa+bDCSccK2wkenr71DipeE7XaL9hwM
	 G70MrnjeibYDI5B9G0PrbVV2vJK8VBB6VLSOhpJPKBsGjAzS/R1R4NgmEHYF7okHqi
	 tLAGGnzqT34rw==
Message-ID: <d9111596-d9a7-4321-9fee-0a570bd77714@kernel.org>
Date: Mon, 30 Jun 2025 12:58:30 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] ata: libata-eh: Move and rename ata_eh_set_lpm()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20250627075207.23969-1-dlemoal@kernel.org>
 <20250627075207.23969-7-dlemoal@kernel.org> <aF54rsmrdoIHl14M@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aF54rsmrdoIHl14M@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 7:55 PM, Niklas Cassel wrote:
> On Fri, Jun 27, 2025 at 04:52:07PM +0900, Damien Le Moal wrote:
>> Move the definition of the function ata_eh_set_lpm() to avoid its
>> unnecessary forward declaration and rename the function to
>> ata_eh_link_set_lpm() to clarify that it acts on a link.
>> No functional changes.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Thanks. Corrected the patches as you suggested and queued them in for-6.17.


-- 
Damien Le Moal
Western Digital Research
