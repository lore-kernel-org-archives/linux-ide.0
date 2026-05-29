Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26AA2877DA
	for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036954; cv=none; b=tgczFleeBv/XhTveCTAJIshuh/BRTa1oVW9Dqmyijc5lM2T2ExkKOaLJaZbiXQm2RUvONR3VlKDjknqFtstd2buJ7aI+FOJdA0OPn59MbaBJbyhdxzHGHeOHZz6ZLQPEdSoGnlNhyIJ+lSFlYtu/tfsOq2OGu/HixpB/pKEegzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036954; c=relaxed/simple;
	bh=k03ohX/mREfgW1MTNwquucjbu4RJDQL4TjyG84lcJC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=symGe1C87tDoZiu3DKmZGGVQBSrqMC5/IVEqe9fRsApiIRP/7e/REnNb/UtTdo/0fXliZPi9dLveTVSXE9mapIAx9YiMZB8fdgOcwNQjekOnpEmR9hvzuI7M5F2w9DitV4dsBvH24yYRve0AVDsdgxBxfkCF4rRSFpX/t1X8gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of1iBgQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of1iBgQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6311F00898;
	Fri, 29 May 2026 06:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780036953;
	bh=OsAlCgAYv0EwyfSG+efQ38vrHtqnMug+/SzXmJcaAC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Of1iBgQotdy6qP+U+JRl36bISe9EUURZm9KYKsxsZKSA+zhKJcb07m4Fd8PnJJc2G
	 VTOcxJghrv1emzgG2oipg9khI/EHiRExiJsEhBfYTgyd8mEwkYILewm/PmWrAR+Bzi
	 RRlHGUVVL6WPsfPsc9Y3UgVEShcBa8YpSv7tg3ulbXwShBf7Qcp9kVPRqB6EAEslWL
	 JZw5svttnuU+NQyKH5XP+KK0RrH7msXfSYZg46p0LcCoD3HeJJkV4EAntfn9PX+9zv
	 Y5aK1p8MXCVl8yWg4s6sAtO/89Gjc3JI/U00ZnpjaNuRUl6kdYfVkMDDZoVf8FsrsV
	 yldiTO1KT8h2w==
Message-ID: <07a727ab-7f0a-4574-8cac-a9e876b1e6be@kernel.org>
Date: Fri, 29 May 2026 15:42:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: libata-scsi: Remove lockdep_assert_held() in
 ata_scsi_translate()
To: Niklas Cassel <cassel@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Marco Elver <elver@google.com>,
 linux-ide@vger.kernel.org
References: <20260528172855.703631-5-cassel@kernel.org>
 <20260528172855.703631-6-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260528172855.703631-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/29 2:28, Niklas Cassel wrote:
> lockdep_assert_held() indirectly calls __assume_ctx_lock(), which will
> suppress any real context analysis from being performed.
> 
> Remove the lockdep_assert_held(). This will be replaced with context
> analysis in a follow-up commit.

I am not really liking the idea of removing runtime checks and replacing them
with compile time checks that work only with clang. What about gcc ? And are we
sure that the compile time checks are as solid as the runtime ones ?

As the sashiko comment mentions, can't we keep this and simply add a
__must_hold() annotation in the declaration ?

> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 6733f2b14521..8bfd3ffd8b89 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1852,8 +1852,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	struct ata_port *ap = dev->link->ap;
>  	struct ata_queued_cmd *qc;
>  
> -	lockdep_assert_held(ap->lock);
> -
>  	/*
>  	 * ata_scsi_qc_new() calls scsi_done(cmd) in case of failure. So we
>  	 * have nothing further to do when allocating a qc fails.


-- 
Damien Le Moal
Western Digital Research
