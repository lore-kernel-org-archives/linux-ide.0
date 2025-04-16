Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6A1D8E10
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792601; cv=none; b=jZmBuYsOcWYXHebP2Vb9TxE3TvnK/kYC0ZBY6TA+opqShXNr9h6dsRHM4OpGTP/Ue9yeIvfpG0QtVQ4jXSgh2UjuTkqvaUiFNsX7tmY9C9bY3WF16RRwXMnuqM8HbnHQygZ1teY7HQsRbghF3RIibZx6dUJgNliAuL+Zy6+5r50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792601; c=relaxed/simple;
	bh=rayKgY2WT+jfH/BO2GyKKl2OLa1FVUg/7VeMDjMCUVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6J0/JuRdmjdWPNHBUqpRXDjSqw38s/arn5IqHhxcwLW5Zauo+ZJij0tiAjDI3KXUFWI52R4OfSQMlkLlJpf8wA7a+3OpAwbDDOIgOhie2K0xdbaoxBqL/oPeyFXfoKKmqLGVQzeejV+fvl3N9Lqi4UD8dYH/aCNW7BGSL5m1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9RUoJVb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9RUoJVb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3079FC4CEE2;
	Wed, 16 Apr 2025 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744792600;
	bh=rayKgY2WT+jfH/BO2GyKKl2OLa1FVUg/7VeMDjMCUVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h9RUoJVb9m7miaTkbsG3oxq84dcCxLQt7GIPpoMIABOM/1P/YJBSub3uuUITqrl6a
	 vtqWc5gbjVJ6DGbNrxUAQdFV05FEA5Lqn6QF681YqpDPdzTClGmj3pip9imsA4hFbq
	 DC53DEFb5K/NR8cRmGZqdphiVXA8mZ9DAMrfQB3+g0B+ePjlnnqxvzsUugGAg8pTHH
	 tfR/7xV7e1C2ZlbmxIVZ36H3nhVknlubrtg5VYW4LboHC7RTennCNrmpFxLXiJ59Cj
	 hqTmiWOKiDoplRkuIa7Bnm4ibz1UuauppcpFtKve8stzcaas5pW0NdtbOZzNQO+6rV
	 dkLUplkO9rpZQ==
Message-ID: <81ea1d99-e668-4285-b85f-d5f332ac9b9f@kernel.org>
Date: Wed, 16 Apr 2025 17:35:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ata: libata-sata: Save all fields from sense data
 descriptor
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Hannes Reinecke <hare@suse.de>
References: <20250415073013.414987-5-cassel@kernel.org>
 <20250415073013.414987-6-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250415073013.414987-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 4:30 PM, Niklas Cassel wrote:
> When filling the taskfile result for a successful NCQ command, we use
> the SDB FIS from the FIS Receive Area, see e.g. ahci_qc_ncq_fill_rtf().
> 
> However, the SDB FIS only has fields STATUS and ERROR.
> 
> For a successful NCQ command that has sense data, we will have a
> successful sense data descriptor, in the Sense Data for Successful NCQ
> Commands log.
> 
> Since we have access to additional taskfile result fields, fill in these
> additional fields in qc->result_tf.
> 
> This matches how for failing/aborted NCQ commands, we will use e.g.
> ahci_qc_fill_rtf() to fill in some fields, but then for the command that
> actually caused the NCQ error, we will use ata_eh_read_log_10h(), which
> provides additional fields, saving additional fields/overriding the
> qc->result_tf that was fetched using ahci_qc_fill_rtf().
> 
> Fixes: 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Applied to for-6.15-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
