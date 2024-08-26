Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238263C
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645340; cv=none; b=c9CrXS1lXUnf7oIQ9kYkdEy7Pgt9gLbz6JLLUd3/aLTKzqhOEkpzDQMD6TZL5b+alB+QcBtaos09i3J6Wmkun6FgJNZ57lexQCRYavH1cOPbEtQQCEjFp0aKbg/v387rMPXYPA8tCnoXunSNFVdx8Aw9xNwTrc1g8wiBOQm94V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645340; c=relaxed/simple;
	bh=YJR7c2VnBzIU9sAMprcDag5A1KbLF97NmXMGymrAEm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqgWzqKm9JKJOj9K2q0ebBvhx/CYf6qgk+c/eYS1bC5qM7fySSiPbvE8Lpf+pbl35AZV1/JJ3tkODL3UD5NMmNO1qqQfrxbsRoF59C3KAHBe3ID5xFNAbvc65yf2ynUDzcS+9EJjN7h0Hw1/WaYh8s8I+wPkiegckY4qZfjbFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCMm5cDi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCMm5cDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5A7C4AF0E;
	Mon, 26 Aug 2024 04:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724645338;
	bh=YJR7c2VnBzIU9sAMprcDag5A1KbLF97NmXMGymrAEm0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCMm5cDiISX40Cr3JdwQbU/My8FpepgCL1gs0lb3bHZciT06YQgwiDgx92w1G5l92
	 rIiBpmZgDVa8IPDFjXhLJEcbfi4jTpxCVAr+gDpvRuKOZwe4EOSkwZ6aE3QAwzfy13
	 4KAox6BpDOWP4CGyYLAkJNFflQ4A3ombWJ3bJEAzQ69iFJ9pftLc/18WerCQhTHyMF
	 0IOlR61KhfoeZVV+1N5awSKAmAIBwmxLG5A6bBi9PQATal3Jx+4eyH1JHDVd60s+ts
	 NsX59ZoWWRSoXTMrIogiggNB1+x8KUJxlnvalmPYd0c/qhtk3HFYzqA1CKGZIcPAAb
	 Jqn4mYUoJz8jQ==
Message-ID: <c91cc480-c9b2-426c-8595-0cdcf104f841@kernel.org>
Date: Mon, 26 Aug 2024 13:08:57 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ata: libata-scsi: Remove obsoleted declaration for
 ata_schedule_scsi_eh
To: Gaosheng Cui <cuigaosheng1@huawei.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org
References: <20240824121147.2521772-1-cuigaosheng1@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240824121147.2521772-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/24 9:11 PM, Gaosheng Cui wrote:
> The ata_schedule_scsi_eh() have been removed since
> commit f8bbfc247efb ("[PATCH] SCSI: make scsi_implement_eh() generic
> API for SCSI transports"), and now it is useless, so remove it.

The path title and commit message could be better written. But see my comment
on your next patch.

> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/ata/libata.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 6abf265f626e..22e667394368 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -124,7 +124,6 @@ extern void ata_scsi_set_sense_information(struct ata_device *dev,
>  					   const struct ata_taskfile *tf);
>  extern void ata_scsi_media_change_notify(struct ata_device *dev);
>  extern void ata_scsi_hotplug(struct work_struct *work);
> -extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
>  extern void ata_scsi_dev_rescan(struct work_struct *work);
>  extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
>  			      unsigned int id, u64 lun);

-- 
Damien Le Moal
Western Digital Research

