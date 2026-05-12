Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48DB2DA76F
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551087; cv=none; b=UqDrbOpLdnGY1yHaT8udlUCJ7O2J9c4lfamuBrmL9qBxGOy6nqQ7+mINL6no49HeRAhwjZJ/B9Ks/aOkUzacNqHTebll2dvZGtw725bVWJFDqgwk3mb9KNhR2xE8DJcSQQyOmueVVXpWzkRvO0WqszQtaMdiJ0Stw8dZ8yUBIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551087; c=relaxed/simple;
	bh=972t3nviGogFPiZA0vK3SeIYfF9ETZ9oQGTEnIskZCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+Ze7QKliskJEW/ApkBH5IchgRDKw7kF8T38SvCYLkLw048I64JdZAyfoVJR/xU1mwAdyhhrr75VE6ccGP3omI5zQuBk69QN6NlzzdS3CBfKMAO8GJ6pqLkGG6DjvedAitHiIBVRVsS4eivEAZg+SL56lZbB6505MeyjeHE0D8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku117dtr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku117dtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A109C2BCF7;
	Tue, 12 May 2026 01:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551087;
	bh=972t3nviGogFPiZA0vK3SeIYfF9ETZ9oQGTEnIskZCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ku117dtrV52CP0oDs95Jv2KC4BwHd3AiarRvJbxpFlmnqPZUCNVvQIiMj3KrH+LAP
	 Sky41aSnNDNkzgCh90H9aaqUPL3zm6rQwoxZYDuElrPhXSwx6KvkVGDYG4hjdRaHEF
	 RGJ91gS7j8siJjnNpef59wal5iu6vT3ub724bUqnQg8g0W/2zFlX3qQsq/Kbe3xIR8
	 jTJ8Tnlpqkb8fb7hlu0l1vna9cG61sbH+1aQJM7F7/uH0eiVJPEHqXfFABdDHZG7Vr
	 17cRHhMPJvCmTAGdaxLldq84liunZ0fbeQm6sWtESHvJSWvIprgfwIwwcM6IfBjd8S
	 R4jKq/7zd3wiA==
Message-ID: <9a0b2636-1411-4ce1-bd7c-6fc265a1901f@kernel.org>
Date: Tue, 12 May 2026 10:58:04 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] ata: fix deferred QC handling for port multipliers
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
References: <20260508195051.188207-4-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260508195051.188207-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 04:50, Niklas Cassel wrote:
> Hello all,
> 
> Tommy Kelly reported a regression with PMP that use CBS:
> https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/
> 
> It turns out that the ap->excl_link logic used for PMP that use CBS is
> incompatible with the deferred qc issuing via a workqueue.
> This is fixed in patch 1/2.
> 
> While looking at the code, it turns out that the deferred qc issuing via
> workqueue is misdesigned. It assumed that we can't mix NCQ and non-NCQ
> commands on the same port. The limitation is that you can not mix NCQ and
> non-NCQ commands on the same drive. However, with a PMP with FBS, you can
> issue (mixed NCQ and non-NCQ commands) to the different drives. Thus, move
> the saved deferred QC from struct ata_port to struct ata_link. This is
> fixed in patch 2/2.
> 
> 

What are the changes from v2 ?

> Changes since v1:
> -Avoid a local variable in sata_pmp_qc_defer_cmd_switch(), call
>  ata_std_qc_defer(qc) inside the switch() directly instead.
> -Fix a typo, such that the the code actually compiles... Sorry for that.
> 
> 
> Niklas Cassel (2):
>   ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
>   ata: libata-scsi: do not needlessly defer commands when using PMP with
>     FBS
> 
>  drivers/ata/libata-core.c | 16 ++++---
>  drivers/ata/libata-eh.c   |  8 ++--
>  drivers/ata/libata-pmp.c  | 26 +++++++++--
>  drivers/ata/libata-scsi.c | 95 ++++++++++++++++++++++++---------------
>  include/linux/libata.h    |  8 ++--
>  5 files changed, 101 insertions(+), 52 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research
