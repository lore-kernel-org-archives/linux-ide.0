Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324713635E
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 02:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551305; cv=none; b=fLFjG+m3DK/J0IyScl8L+7ZJewVbp8+4WEFQbRidziRWlp4PY+JfLlvRzdgcKpHc0K1ZhYBRVFCOW/0mV68dd8o7J+7TzqHEw7LtH8yXDIIdeq0YXVYYIPumhTSJLdpas+kGOCDo3+0PsTq3awidGzCuevIfBE1J4NV+DA+SOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551305; c=relaxed/simple;
	bh=2DpyZ7y/vH8/Hb+VP5oCS/iRP3ARxcjAVJhRJQiNa+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bI7UMIk6YuRZQlmWUoN7VTELs0dpJ3wNSWZbI8YlRvcAlciggbBe1uaSSPk+Dl6VURHPe0By3CGH56HURrqRD8J7126pn7wN95hJGAZKk3G/k4AnLKxIefy9vOUEtE6alFAvp5RDDugPqtsc1/NCMxn3/5mBJ/UNBsOGRwC22ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0SGKpL0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0SGKpL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC749C2BCB0;
	Tue, 12 May 2026 02:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551304;
	bh=2DpyZ7y/vH8/Hb+VP5oCS/iRP3ARxcjAVJhRJQiNa+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q0SGKpL0EgW1TO1S/WryXCRXuhVqADVMyD98S+MvcEY3G0iDVztLqGQz0G9e624uw
	 qdZB9bzUmVz//cOxFN6nLF/g29/C7uxf9knvFGIOCi0gv+/woRTDmA1EKD1NnwLL6v
	 qysEPFoSPdRuRrkZxtlYufjleNtZ9pN4U5WJNdRpCAJ+bEY5mNNSVScjApaC0ugV8B
	 dm7i5Tphmn2AuB+6pYwOeDrGPMp6ebWsxeW+L/Nyt5N/tlCcCTlFKwmnuziGB+rRtz
	 F/Ql3e1v5kXz+V0C8AfMqMaJjO3mQWQseW60FTpSBm2DOvoBMhjYGwZWmd/Uug+D5l
	 7yfKzdh/ecljA==
Message-ID: <cc742ac4-4278-4546-be6e-07b74f1be979@kernel.org>
Date: Tue, 12 May 2026 11:01:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: do not needlessly defer commands
 when using PMP with FBS
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
References: <20260508195051.188207-4-cassel@kernel.org>
 <20260508195051.188207-6-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260508195051.188207-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 04:50, Niklas Cassel wrote:
> The SATA specification does not allow a non-NCQ command to be issued while
> an NCQ command is outstanding.
> 
> Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> introduced a feature where a deferred non-NCQ command gets issued from a
> workqueue. The design stores a single non-NCQ command per port.
> 
> However, when using Port Multipliers (PMPs), specifically PMPs that
> support FIS-Based Switching (FBS), non-NCQ and NCQ commands can be mixed
> on the same port, just not for the same link, see e.g. ata_std_qc_defer()
> which is, and always has operated on a per-link basis.
> 
> Therefore, move the deferred_qc from struct ata_port to struct ata_link.
> This way, when using a PMP with FBS, we will not needlessly defer commands
> to all other links, just because one link issued a non-NCQ command while
> having an NCQ command outstanding. Only commands for that specific link
> will be deferred.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK. However Tommy did see a warning, so I wonder if we still have
something missing...

Nevertheless,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
